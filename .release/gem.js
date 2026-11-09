import { spawn } from "node:child_process";
import fs from "node:fs";
import path from "node:path";

function exec(command, args = []) {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, { stdio: "inherit" });
    child.on("close", (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`"${command} ${args.join(" ")}" exited with code ${code}`));
      }
    });
    child.on("error", reject);
  });
}

export async function prepare(config, context) {
  const versionFile = "./lib/umts/telemetry/version.rb";
  const prev = fs.readFileSync(versionFile, { encoding: "UTF-8" });
  const next = prev.replace(/VERSION = ".+?"/u, `VERSION = "${context.nextRelease.version}"`);
  fs.writeFileSync(versionFile, next);
  await exec("bin/rake", ["build"]);
}

export async function publish() {
  const gems = fs.readdirSync("./pkg").filter((f) => f.endsWith(".gem"));
  for (const gem of gems) {
    // oxlint-disable-next-line no-await-in-loop
    await exec("gem", ["push", path.join("pkg", gem)]);
  }
}
