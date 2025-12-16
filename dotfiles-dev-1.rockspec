package = "dotfiles"
version = "dev-1"
source = {
	url = "git+ssh://git@github.com/sacsar/dotfiles.git",
}
description = {
	homepage = "*** please enter a project homepage ***",
	license = "*** please specify a license ***",
}
dependencies = {
	"lua >= 5.1",
}
build = {
	type = "builtin",
	modules = {
		["core.nvim"] = "src/lua/core/nvim/init.lua",
		["core.nvim.folds"] = "src/lua/core/nvim/folds.lua",
		["core.nvim.log"] = "src/lua/core/nvim/log.lua",
		["core.nvim.lsp"] = "src/lua/core/nvim/lsp.lua",
		["core.nvim.mappings"] = "src/lua/core/nvim/mappings.lua",
		["core.nvim.opts"] = "src/lua/core/nvim/opts.lua",
		["core.nvim.tools"] = "src/lua/core/nvim/tools.lua",
		["core.nvim.util"] = "src/lua/core/nvim/util.lua",
	},
}
