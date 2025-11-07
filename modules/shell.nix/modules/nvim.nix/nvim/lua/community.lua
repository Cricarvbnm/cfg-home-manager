---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  require("plugins.astrolsp").opts.features.inlay_hints and {
    import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints",
  } or {},
}
