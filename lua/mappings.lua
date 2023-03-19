vim.g.mapleader = "'"
local M = {}

function M.noremap(mode, shorcut, command)
	vim.api.nvim_set_keymap(mode, shorcut, command, { noremap = true, silent = true })
end

function M.nnoremap(shortcut, command)
	M.noremap("n", shortcut, command)
end

function M.vnoremap(shortcut, command)
	M.noremap("v", shortcut, command)
end

function M.tnoremap(shorcut, command)
	M.noremap("t", shorcut, command)
end

function M.inoremap(shorcut, command)
	M.noremap("i", shorcut, command)
end

function M.cnoremap(shorcut, command)
	M.noremap("c", shorcut, command)
end

local rhs_options = {}

function rhs_options:new()
	local instance = {
		cmd = "",
		options = { noremap = false, silent = false, expr = false, nowait = false },
	}
	setmetatable(instance, self)
	self.__index = self
	return instance
end

function rhs_options:map_cmd(cmd_string)
	self.cmd = cmd_string
	return self
end

function rhs_options:map_cr(cmd_string)
	self.cmd = (":%s<CR>"):format(cmd_string)
	return self
end

function rhs_options:map_args(cmd_string)
	self.cmd = (":%s<Space>"):format(cmd_string)
	return self
end

function rhs_options:map_cu(cmd_string)
	self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
	return self
end

function rhs_options:with_silent()
	self.options.silent = true
	return self
end

function rhs_options:with_noremap()
	self.options.noremap = true
	return self
end

function rhs_options:with_expr()
	self.options.expr = true
	return self
end

function rhs_options:with_nowait()
	self.options.nowait = true
	return self
end

function M.map_cr(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cr(cmd_string)
end

function M.map_cmd(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cmd(cmd_string)
end

function M.map_cu(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cu(cmd_string)
end

function M.map_args(cmd_string)
	local ro = rhs_options:new()
	return ro:map_args(cmd_string)
end

function M.nvim_load_mapping(mapping)
	for key, value in pairs(mapping) do
		local mode, keymap = key:match("([^|]*)|?(.*)")
		if type(value) == "string" then
			value = M.map_cr(value):with_noremap():with_silent()
		end
		if type(value) == "table" and value.f then
			local m = value.m or "n"
			vim.keymap.set(m, key, value.f)
		end
		if type(value) == "table" and value.cmd then
			local rhs = value.cmd
			local options = value.options
			vim.api.nvim_set_keymap(mode, keymap, rhs, options)
		end
	end
end

M.nnoremap("<C-A>", "^")
M.nnoremap("<C-S>", "$")
M.vnoremap("<Leader>y", '"+y')
M.nnoremap("<Leader>s", ":w<CR>")
M.nnoremap("<Leader>S", ":wa<CR>")
M.nnoremap("<Leader>Q", ":wa<CR>:qa<CR>")

M.nnoremap("<C-[>", "<C-I>")
M.nnoremap("<C-O>", "<C-T>")
M.nnoremap("<C-P>", "<C-O>")

-- highlight
M.nnoremap("n", ":set hlsearch<cr>n")
M.nnoremap("N", ":set hlsearch<cr>N")
M.nnoremap("/", ":set hlsearch<cr>/")
M.nnoremap("?", ":set hlsearch<cr>?")
M.nnoremap("*", "*:set hlsearch<cr>")
M.nnoremap("gm", ":set nohlsearch<cr>")

M.nvim_load_mapping({
	["n|gwg"] = "ChooseWin",
	["n|gwc"] = "ChooseWinCopy",
	["n|gws"] = "ChooseWinSwap",
})

return M
