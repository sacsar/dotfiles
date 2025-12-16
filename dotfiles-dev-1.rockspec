package = "dotfiles"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/sacsar/dotfiles.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
dependencies = {
   queries = {}
}
build_dependencies = {
   queries = {}
}
build = {
   type = "builtin",
   modules = {
      ["core.folds"] = "lua/core/folds.lua",
      ["core.log"] = "lua/core/log.lua",
      ["core.lsp"] = "lua/core/lsp.lua",
      ["core.mappings"] = "lua/core/mappings.lua",
      ["core.opts"] = "lua/core/opts.lua",
      ["core.tools"] = "lua/core/tools.lua",
      ["core.util"] = "lua/core/util.lua"
   }
}
test_dependencies = {
   queries = {}
}
