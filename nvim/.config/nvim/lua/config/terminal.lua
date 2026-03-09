local term_buf = nil
local term_win = nil

function ToggleTerminal()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		-- Si la fenêtre est ouverte, on la cache (le buffer reste en mémoire)
		vim.api.nvim_win_hide(term_win)
		term_win = nil
	else
		-- Si le buffer n'existe pas ou a été supprimé, on le crée
		if term_buf == nil or not vim.api.nvim_buf_is_valid(term_buf) then
			term_buf = vim.api.nvim_create_buf(false, true) -- Créer un buffer non listé
		end

		-- Ouvrir une division en bas
		vim.cmd("botright sbuf " .. term_buf)
		term_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_height(term_win, 15) -- Ajuster la hauteur

		-- Si c'est un nouveau buffer, on lance le terminal dedans
		if vim.bo[term_buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end

		-- Passer en mode insertion automatiquement
		vim.cmd("startinsert")
	end
end

---createing a terminal
vim.keymap.set("n", "<leader>t", ToggleTerminal, { desc = "Toggle terminal" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
