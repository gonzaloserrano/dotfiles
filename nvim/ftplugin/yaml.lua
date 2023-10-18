require'lspconfig'.yamlls.setup{
	settings = {
		yaml = {
			keyOrdering = false,
		}
	}
}

local set = vim.opt
set.expandtab = true
set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2
