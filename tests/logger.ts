import chalk from "chalk";

export default {
  log: (...args: unknown[]) =>
    console.log(
      `[LOG]     [${new Date().toString().split(" ").slice(1, 5).join(" ")}] `,
      ...args
    ),
  info: (...args: unknown[]) =>
    console.info(
      chalk.blueBright(
        `[INFO]    [${new Date().toString().split(" ").slice(1, 5).join(" ")}]`,
        ...args
      )
    ),
  success: (...args: unknown[]) =>
    console.log(
      chalk.greenBright(
        `[SUCCESS] [${new Date().toString().split(" ").slice(1, 5).join(" ")}]`,
        ...args
      )
    ),
  warn: (...args: unknown[]) =>
    console.warn(
      chalk.yellowBright(
        `[WARN]    [${new Date().toString().split(" ").slice(1, 5).join(" ")}]`,
        ...args
      )
    ),
  error: (...args: unknown[]) =>
    console.error(
      chalk.redBright(
        `[ERROR]   [${new Date().toString().split(" ").slice(1, 5).join(" ")}]`,
        ...args
      )
    ),
  debug: (...args: unknown[]) =>
    console.debug(
      chalk.gray(
        `[DEBUG]   [${new Date().toString().split(" ").slice(1, 5).join(" ")}]`,
        ...args
      )
    ),
};
