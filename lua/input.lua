local M = {
	englishLayout = "com.apple.keylayout.ABC",
	chineseLayout = "com.apple.inputmethod.SCIM.ITABC",
}

function M.switchEnglish()
	os.execute(string.format("xkbswitch -s %s", M.englishLayout))
end

function M.switchChinese()
	local cmd = string.format("xkbswitch -s %s", M.chineseLayout)
	local status = os.execute(cmd)
	vim.notify(string.format("exec cmd: %s", cmd), "info")
	if status == 0 then
		vim.notify("switch chinese success.", "info")
	else
		vim.notify("switch chinese failed.", "error")
	end
end

return M
