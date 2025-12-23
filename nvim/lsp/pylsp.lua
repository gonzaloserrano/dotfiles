cfg = {
	cmd = {
		'uv',
		'run',
		'--with',
		'python-lsp-server,python-lsp-isort,pylsp-rope,python-lsp-ruff,pylsp-mypy,pyls-memestra',
		'pylsp'
	},
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
	settings = {
		pylsp = {
			configurationSources = { "flake8" },
			plugins = {
				-- Disable default linter
				pyflakes = {
					enabled = false,
				},
				pycodestyle = {
					enabled = false,
				},
				mccabe = {
					enabled = false,
				},
				-- Plugins configuration
				flake8 = {
					enabled = true,
				},
				isort = {
					enabled = true,
				},
				jedi_completion = {
					enabled = true,
					fuzzy = true
				},
				["pyls-memestra"] = {
					enabled = true,
					recursive = true
				},
				rope_autoimport = {
					enabled = true
				},
			}
		}
	}
}

vim.lsp.config.pylsp = cfg
return cfg
