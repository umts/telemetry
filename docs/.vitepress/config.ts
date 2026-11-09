import { defineConfig } from "vitepress";

export default defineConfig({
  base: "./",
  title: "umts-telemetry",
  description: "Telemetry for UMTS rails and sinatra apps",
  themeConfig: {
    search: { provider: "local" },
    nav: [],
    sidebar: [
      {
        text: "Setup",
        items: [{ text: "Installation", link: "/installation" }],
      },
    ],
    socialLinks: [{ icon: "github", link: "https://github.com/umts/telemetry" }],
  },
});
