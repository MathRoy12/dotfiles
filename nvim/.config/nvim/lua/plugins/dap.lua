return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<F8>", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<F9>", dap.step_out, { desc = "Step out" })
	end,
}
