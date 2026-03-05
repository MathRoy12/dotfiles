return {
	{
		'nvim-telescope/telescope.nvim',
		enabled = true,
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
      			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
        			'nvim-telescope/telescope-fzf-native.nvim',

        			-- `build` is used to run some command when the plugin is installed/updated.
        			-- This is only run then, not every time Neovim starts up.
        			build = 'make',

        			-- `cond` is a condition used to determine whether this plugin should be
        			-- installed and loaded.
        			cond = function() return vim.fn.executable 'make' == 1 end,
      			},
      			{ 'nvim-telescope/telescope-ui-select.nvim' },

      			{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },		
		},
		config = function()
			require('telescope').setup {
				extensions = {
          				['ui-select'] = { require('telescope.themes').get_dropdown() },
        			},
			}

			pcall(require('telescope').load_extension, 'fzf')
      			pcall(require('telescope').load_extension, 'ui-select')

			local builtin = require 'telescope.builtin'

			vim.keymap.set('n', '<leader>fh', builtin.help_tags,{desc = '[F]ind [H]elp'})
			vim.keymap.set('n', '<leader>fk', builtin.keymaps,{desc = '[F]ind [K]eymaps'})
			vim.keymap.set('n', '<leader>ff', builtin.find_files,{desc = '[F]ind [F]iles'})
			vim.keymap.set('n', '<leader>fs', builtin.builtin,{desc = '[F]ind [S]elect Telescope'})
			vim.keymap.set({'n', 'v'}, '<leader>fw', builtin.grep_string,{desc = '[F]ind current [W]ord'})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep,{desc = '[F]ind by [G]rep'})
			vim.keymap.set('n', '<leader>fd', builtin.diagnostics,{desc = '[F]ind [D]iagnostic'})
			vim.keymap.set('n', '<leader>fr', builtin.oldfiles,{desc = '[F]ind [R]ecent files'})
			vim.keymap.set('n', '<leader>fc', builtin.commands,{desc = '[F]ind [C]ommands'})
			vim.keymap.set('n', '<leader><leader>', builtin.buffers,{desc = 'Find existing buffers'})

			vim.keymap.set(
				'n', 
				'<leader>fb', 
				function()
					builtin.current_buffer_fuzzy_find(require('telescope.themes'))
      				end,
				{desc = '[F]ind in current [b]uffer'}
			)


			vim.api.nvim_create_autocmd('LspAttach', {
        			group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        			callback = function(event)
          				local buf = event.buf

          				vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
          				vim.keymap.set('n', '<leader>gr', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
          				vim.keymap.set('n', '<leader>gr', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
          				vim.keymap.set('n', '<leader>od', builtin.lsp_document_symbols, { buffer = buf, desc = '[O]pen [D]ocument Symbols' })
          				vim.keymap.set('n', '<leader>ow', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = '[O]pen [W]orkspace Symbols' })
          				vim.keymap.set('n', '<leader>gt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
        			end,
      			})


		end
	}
}
