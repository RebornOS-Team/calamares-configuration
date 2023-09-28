import { mkdtemp, readdir } from "fs/promises";
import { tmpdir } from "os";
import { join, resolve } from "path";
import { parse } from "yaml";
import logger from "./logger";

type TNetInstallPackage = string | { name: string; description: string };

type TNetInstallSubGroup = {
  name: string;
  description: string;
  selected?: boolean;
  critical?: boolean;
  immutable?: boolean;
  subgroups?: TNetInstallSubGroup[];
  packages: TNetInstallPackage[];
};

type TNetInstallModule = {
  name: string;
  description: string;
  selected?: boolean;
  critical?: boolean;
  immutable?: boolean;
  subgroups?: TNetInstallSubGroup[];
  packages: TNetInstallPackage[];
};

const path = resolve("../etc/calamares/modules/netinstall.yaml");

logger.info(`Reading netinstall.yaml from: ${path}`);

const json: TNetInstallModule[] = parse(await Bun.file(path).text());

logger.info(`Found ${json.length} modules in netinstall.yaml`);

const discoverSubGroupPackages = (json: TNetInstallModule[]) => {
  const packages: string[] = [];
  json.forEach((section) => {
    if (section.packages) {
      packages.push(
        ...section.packages.map((x) => {
          if (typeof x === "string") {
            return x;
          }
          return x.name;
        })
      );
    }
    if (section.subgroups) {
      packages.push(...discoverSubGroupPackages(section.subgroups));
    }
  });
  return packages;
};

const packages = [...new Set(discoverSubGroupPackages(json))];

logger.info(`Found ${packages.length} unique packages in netinstall.yaml`);

const repositories = [
  {
    id: "core",
    name: "Arch Linux Core",
    url: "https://geo.mirror.pkgbuild.com/core/os/x86_64/core.db",
  },
  {
    id: "extra",
    name: "Arch Linux Extra",
    url: "https://geo.mirror.pkgbuild.com/extra/os/x86_64/extra.db",
  },
  {
    id: "multilib",
    name: "Arch Linux MultiLib",
    url: "https://geo.mirror.pkgbuild.com/multilib/os/x86_64/multilib.db",
  },
  {
    id: "rebornos",
    name: "RebornOS",
    url: "https://repo.rebornos.org/RebornOS/Reborn-OS.db",
  },
];

const remotePackages: string[] = [];

await Promise.all(
  repositories.map(async (repo) => {
    const tempDir = await mkdtemp(join(tmpdir(), repo.id));
    logger.info(`Fetching ${repo.name} repository database from ${repo.url}`);
    const body = await fetch(repo.url).then((res) => res.arrayBuffer());
    logger.success(`Fetched ${repo.name} repository database`);
    const db = join(tempDir, `${repo.id}.db`);
    await Bun.write(db, body);
    logger.info(`Extracting ${repo.name} repository database`);
    try {
      await Bun.spawn(["bsdtar", "-xf", db], {
        cwd: tempDir,
      }).exited;
      logger.success(`Extracted ${repo.name} repository database`);
      logger.info(`Reading ${repo.name} repository database`);
      const descriptionFiles = await readdir(tempDir, {
        withFileTypes: true,
      }).then((file) =>
        file.filter((x) => x.isDirectory()).map((x) => join(x.name, "desc"))
      );
      logger.success(`Read ${repo.name} repository database`);
      logger.info(`Parsing ${repo.name} repository database`);
      await Promise.all(
        descriptionFiles.map(async (file) => {
          const descPath = join(tempDir, file);
          const data = await Bun.file(descPath).text();
          const res = data.match(/%NAME%\n.*/g);
          if (res && res[0]) {
            remotePackages.push(res[0].replace("%NAME%\n", "").trim());
          }
        })
      );
    } catch (err) {
      logger.error(`Failed to extract ${repo.name} repository database`);
      logger.error(err);
    }
  })
);

logger.info(`Found ${remotePackages.length} unique packages in remote repos`);

const missingPackages = packages.filter((x) => !remotePackages.includes(x));

if (missingPackages.length > 0) {
  logger.error(`Found ${missingPackages.length} missing packages`);
  logger.error(`Missing packages: ${missingPackages.join(", ")}`);
  logger.error("Exiting with error code 1");
  process.exit(1);
}

logger.success(`Found ${missingPackages.length} missing packages`);

logger.success("Exiting with error code 0");
