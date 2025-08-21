return {
	"keaising/im-select.nvim",
	enabled = false,
	config = function()
		require("im_select").setup({
			default_im_select = "com.apple.keylayout.ABC",
			default_command = "macism",

			-- Restore the default input method state when the following events are triggered
			-- "VimEnter" and "FocusGained" were removed for causing problems, add it by your needs
			--set_default_events = { "InsertLeave", "CmdlineLeave" },
			set_default_events = { "InsertLeave", "CmdlineLeave", "TermLeave" },

			-- Restore the previous used input method state when the following events
			-- are triggered, if you don't want to restore previous used im in Insert mode,
			-- e.g. deprecated `disable_auto_restore = 1`, just let it empty
			-- as `set_previous_events = {}`
			set_previous_events = { "InsertEnter", "TermEnter" },
			--set_previous_events = {},

			-- Show notification about how to install executable binary when binary missed
			keep_quiet_on_no_binary = false,
			async_switch_im = true,
		})
	end,
}
