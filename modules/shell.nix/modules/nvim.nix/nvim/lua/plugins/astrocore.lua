---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      diagnostics = { virtual_text = true, virtual_lines = false },
    },

    diagnostics = {
      virtual_text = true,
    },

    filetypes = {
      extension = {
        hyprland = "hyprlang",
        hypr = "hyprlang",
      },
    },

    options = {

      opt = {
        jumpoptions = "stack",
        fileencodings = "ucs-bom,utf-8,cp936,gb18030,gbk,big5,sjis,euc-jp,latin1",
        scrolloff = 3,
        mouse = "a",

        -- UI
        number = true,
        relativenumber = false,
        cursorline = true,
        cursorlineopt = "number",
        colorcolumn = "80",
        signcolumn = "yes",
        wrap = true,

        -- Search
        showmatch = true,
      },
    },

    mappings = {
      n = {
        -- Buffer Navigation
        ["L"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["H"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
      },

      [{ "n", "i", "v" }] = {
        ["<C-S>"] = false,
      },
    },
  },
}
