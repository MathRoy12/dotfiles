vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.cursorline = true

vim.o.scrolloff = 15

vim.o.mouse = "a"

vim.o.showmode = false
vim.o.ruler = false
vim.o.showcmd = false

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.shell = "/bin/zsh -i"

vim.diagnostic.config({
	underline = true,
	virtual_text = {
		spacing = 2,
		prefix = "●",
	},
	update_in_insert = true,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})
