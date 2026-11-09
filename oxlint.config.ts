import { defineConfig } from "oxlint";

export default defineConfig({
  $schema: "./node_modules/oxlint/configuration_schema.json",
  plugins: ["eslint", "typescript", "unicorn", "oxc", "node", "import", "promise"],
  categories: {
    correctness: "error",
    suspicious: "warn",
    pedantic: "warn",
    perf: "error",
    restriction: "error",
  },
  rules: {
    "eslint/no-new": "off",
    "import/no-default-export": "off",
    "import/no-unassigned-import": "off",
    "oxc/no-async-await": "off",
  },
});
