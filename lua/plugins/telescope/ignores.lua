local platco_ignore = {
  "assets/",
  "bolt/",
  "coverage/",
  "cypress/",
  "dist/",
  "docs/",
  "i18n/",
  "infra/",
  "license/",
  "node_modules/",
  "scripts/",
  "test/",
  "testing/",
  "ci/",
  "bin",
}
local xre_ignore = {
  "%code-coverage/",
  "%test/",
  "%target/",
  ".DS_Store"
}
local M = {
  ["default"] = {
    "yarn%.lock",
    "node_modules/",
    "raycast/",
    "dist/",
    "%.next",
    "%.git/",
    "%.gitlab/",
    "build/",
    "target/",
    "package%-lock%.json",
    "yarn.lock",

  },
  ["xre_parent"] = xre_ignore,
  ["xre_guide"] = xre_ignore,
  ["xre_framework"] = xre_ignore,
  ["mediaplayer-app"] = platco_ignore,
  ["flex-app"] = platco_ignore,
  ["platco-resident-app"] = platco_ignore,
  ["mediaplayer-solid"] = {
    ".husky/",
    ".storybook/",
    "devices/",
    "dist/",
    "environments/",
    "node_modules/",
    "public/",
    ".editorconfig",
    ".gitignore",
    ".prettierignore",
    ".prettierrc",
    "LICENSE",
    "NOTICE",
    "README.md",
    "eslint.config.js",
    "index.html",
    "package.json",
    "pnpm-lock.yaml",
    "tsconfig.json",
    "vite.config.js",

  },
  ["dart"] = {
    "coverage/",
    "test/",
    "test_fixes/",
    "test_private/",
    "test_profile/",
    "test_release/",
    ".dart_tool/",
    ".git/",
    ".idea/",
    "android/",
    -- "assets/",
    -- "bin/",
    "build/",
    "ios/",
    -- "lib/",
    "linux/",
    "macos/",
    "web/",
    "windows/",
    ".flutter-plugins",
    ".flutter-plugins-dependencies",
    ".gitignore",
    ".metadata",
    "README.md",
    "__Flutter_Output__",
    "analysis_options.yaml",
    "devtools_options.yaml",
    "flutter_card_test.iml",
    "pubspec.lock",
    "pubspec.yaml",
  },
  ["java"] = {}
}
local function setDefault(t, d)
  local mt = { __index = function() return d end }
  setmetatable(t, mt)
end

setDefault(M, {})

return M;
