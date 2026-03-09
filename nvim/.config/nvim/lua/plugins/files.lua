return {
	"nvim-mini/mini.files",
	version = false,
	config = function()
		require("mini.files").setup({
			mappings = {
				close = "<Esc>",
			},
		})
		vim.keymap.set("n", "<leader>of", function()
			MiniFiles.open()
		end, { desc = "[O]pen [F]iles" })
	end,
}
