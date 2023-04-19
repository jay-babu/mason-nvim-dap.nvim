return {
	type = 'executable',
	command = vim.fn.exepath('dart-debug-adapter'),
	args = { 'flutter' },
}
