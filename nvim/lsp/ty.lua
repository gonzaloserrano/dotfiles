cfg = {
	cmd = {
		'ty',
		'server'
	},
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
	settings = {
		ty = {
			disableLanguageServices = false,
		}
	}
}

vim.lsp.config.ty = cfg
return cfg
