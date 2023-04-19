return {
	type = 'executable',
	command = vim.fn.exepath('elixir-ls-debugger'), -- https://github.com/williamboman/mason.nvim/blob/d97579ccd5689f9c6c365e841ea99c27954112ec/lua/mason-registry/elixir-ls/init.lua#L26
	args = {},
}
