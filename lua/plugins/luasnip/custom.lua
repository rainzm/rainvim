local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local su = require("luasnip_snippets.common.snip_utils")
local te = su.trig_engine

ls.add_snippets("go", {
	s({ trig = "jo", name = "jsonutils JSONObject", dscr = "jsonutils.JSONObject" }, { t("jsonutils.JSONObject") }),
	s({ trig = "jnd", name = "jsonutils NewDict", dscr = "jsonutils.NewDict" }, { t("jsonutils.NewDict()") }),
	s(
		{ trig = "jns", name = "jsonutils NewString", dscr = "jsonutils.NewString" },
		fmt([[jsonutils.NewString({})]], {
			i(1),
		})
	),
})
