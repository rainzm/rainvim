local M = {
	englishLayout = "com.apple.keylayout.ABC",
	-- chineseLayout = "com.apple.inputmethod.SCIM.ITABC",
	chineseLayout = "im.rime.inputmethod.Squirrel.Hans",
}

function M.switchEnglish()
	os.execute(string.format("xkbswitch -s %s", M.englishLayout))
end

function M.switchChinese()
	local cmd = string.format("xkbswitch -s %s", M.chineseLayout)
	local status = os.execute(cmd)
	if status ~= 0 then
		vim.notify("switch chinese failed.", "error")
	end
end

return M
