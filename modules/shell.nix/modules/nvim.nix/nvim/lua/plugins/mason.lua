---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- Python
        "pyright",
        "black",
        "flake8",
        "debugpy",

        -- Go
        "gopls",
        "gofumpt",
        "golangci-lint-langserver",
        "delve",

        -- Lua
        "lua-language-server",
        "stylua",
        "luacheck",

        -- Sh
        "bash-language-server",
        "shellcheck",
        "beautysh",
        "bash-debug-adapter",

        -- C/C++
        "clangd",
        "clang-format",
        "cpplint",
        "codelldb",

        -- Markdown
        "marksman",
        "prettier",
        "vale",

        -- YAML
        "yaml-language-server",
        "prettier",
        "cfn-lint",

        -- JSON
        "biome",
        "prettier",

        -- TOML
        "taplo",
        "tombi",

        -- XML
        "lemminx",
        "xmlformatter",

        -- hyprland
        "hyprls",

        -- Java
        "google-java-format",
        "jdtls",
        "java-debug-adapter",
        -- "checkstyle",

        -- Latex
        "tex-fmt",

        -- nix
        'nil',
        'nixfmt',
      },
    },
  },
}
