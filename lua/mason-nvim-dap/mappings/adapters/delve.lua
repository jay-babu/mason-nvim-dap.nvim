-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
return {
	type = 'server',
	port = '${port}',
	executable = {
		command = vim.fn.exepath('dlv'),
		args = { 'dap', '-l', '127.0.0.1:${port}' },
	},
}
