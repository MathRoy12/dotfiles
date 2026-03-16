local opencode_buf = nil
local opencode_win = nil
local opencode_job_id = nil

-- Fonction pour obtenir les dimensions de la fenêtre flottante (80% de hauteur/largeur)
local function get_float_dimensions()
	local ui = vim.api.nvim_list_uis()[1]
	local width = ui.width
	local height = ui.height

	local float_width = math.floor(width * 0.85)
	local float_height = math.floor(height * 0.85)

	local row = math.floor((height - float_height) / 2)
	local col = math.floor((width - float_width) / 2)

	return {
		width = float_width,
		height = float_height,
		row = row,
		col = col,
	}
end

-- Fonction pour créer/afficher la fenêtre flottante OpenCode
function ToggleOpenCode()
	if opencode_win and vim.api.nvim_win_is_valid(opencode_win) then
		-- Si la fenêtre est ouverte, on la cache (le buffer reste en mémoire)
		vim.api.nvim_win_hide(opencode_win)
		opencode_win = nil
	else
		-- Si le buffer n'existe pas ou a été supprimé, on le crée
		if opencode_buf == nil or not vim.api.nvim_buf_is_valid(opencode_buf) then
			opencode_buf = vim.api.nvim_create_buf(false, true) -- Créer un buffer non listé
			-- Lancer opencode dans le buffer via terminal
			vim.api.nvim_buf_call(opencode_buf, function()
				opencode_job_id = vim.fn.termopen("opencode", {
					on_exit = function()
						opencode_job_id = nil
					end,
				})
			end)
		end

		-- Obtenir les dimensions de la fenêtre flottante
		local dims = get_float_dimensions()

		-- Ouvrir une fenêtre flottante avec le buffer
		opencode_win = vim.api.nvim_open_win(opencode_buf, true, {
			relative = "editor",
			width = dims.width,
			height = dims.height,
			row = dims.row,
			col = dims.col,
			style = "minimal",
			border = "rounded",
		})

		-- Passer en mode insertion automatiquement pour que l'utilisateur puisse taper
		vim.cmd("startinsert")
	end
end

-- Fonction pour nettoyer OpenCode à la fermeture de Neovim
function CleanupOpenCode()
	if opencode_job_id and vim.fn.jobwait({ opencode_job_id }, 100)[1] == -1 then
		-- Le job est toujours en cours, on le termine
		vim.fn.jobstop(opencode_job_id)
	end
end

-- Keybinding pour toggler OpenCode
vim.keymap.set("n", "<leader>oc", ToggleOpenCode, { desc = "Toggle OpenCode" })

-- Autocommand pour nettoyer OpenCode à la fermeture de Neovim
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = CleanupOpenCode,
	desc = "Close OpenCode process on Neovim exit",
})
