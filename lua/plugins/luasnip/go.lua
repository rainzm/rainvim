local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local util = require("plugins.luasnip.util")
local ai = require("luasnip.nodes.absolute_indexer")
local partial = require("luasnip.extras").partial

local function not_in_function()
	return not util.is_in_function()
end

local in_test_func = {
	show_condition = util.is_in_test_function,
	condition = util.is_in_test_function,
}

local in_test_file = {
	show_condition = util.is_in_test_file,
	condition = util.is_in_test_file,
}

local in_func = {
	show_condition = util.is_in_function,
	condition = util.is_in_function,
}

local not_in_func = {
	show_condition = not_in_function,
	condition = not_in_function,
}

return {
	ls.s(
		{ trig = "jo", name = "jsonutils JSONObject", dscr = "jsonutils.JSONObject" },
		{ ls.t("jsonutils.JSONObject") },
		in_func
	),
	ls.s(
		{ trig = "jnd", name = "jsonutils NewDict", dscr = "jsonutils.NewDict" },
		{ ls.t("jsonutils.NewDict()") },
		in_func
	),
	ls.s(
		{ trig = "jns", name = "jsonutils NewString", dscr = "jsonutils.NewString" },
		fmt([[jsonutils.NewString({})]], {
			ls.i(1),
		}),
		in_func
	),
}
