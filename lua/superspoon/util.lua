local M = {}

M.mode = function()
	local modes = {
		["n"] = "NORMAL",
		["no"] = "NORMAL",
		["v"] = "VISUAL",
		["V"] = "V-LINE",
		["\22"] = "V-BLOCK",
		["s"] = "SELECT",
		["S"] = "S-LINE",
		["\19"] = "S-BLOCK",
		["i"] = "INSERT",
		["ic"] = "INSERT",
		["R"] = "REPLACE",
		["Rv"] = "V-REPLACE",
		["c"] = "COMMAND",
		["r"] = "PROMPT",
		["r?"] = "CONFIRM",
		["t"] = "TERMINAL",
	}

	local current_mode = vim.api.nvim_get_mode().mode

	return table.concat({ " [", modes[current_mode], "] " }):upper()
end

M.filetype = function()
	return vim.bo.filetype ~= "" and table.concat({ vim.bo.filetype, " " }) or "unknown"
end

M.file_info = function()
	return "%t %m%r "
end

M.line_info = function()
	return vim.bo.filetype == "alpha" and "" or " %l/%L:%c [%P] "
end

M.diagnostics = function()
	local set_hl = vim.api.nvim_set_hl
	local hl_bg = {}

	local colors = require("superspoon.lib.diagnostics").colors
	local get_col = vim.g.colors_name

	hl_bg.default = vim.fn.synIDattr(vim.fn.hlID("Statusline"), "bg")

	if colors.cattpuccin[get_col] then
		hl_bg.catppuccin = vim.fn.synIDattr(vim.fn.hlID("Pmenu"), "bg")
	elseif colors.habamax[get_col] then
		hl_bg.habamax = vim.fn.synIDattr(vim.fn.hlID("StatuslineNC"), "bg")
	end

	hl_bg = hl_bg.catppuccin or hl_bg.habamax or hl_bg.default

	local hl_origin = {
		error = vim.api.nvim_get_hl_by_name("DiagnosticError", true),
		warn = vim.api.nvim_get_hl_by_name("DiagnosticWarn", true),
		info = vim.api.nvim_get_hl_by_name("DiagnosticInfo", true),
		hint = vim.api.nvim_get_hl_by_name("DiagnosticHint", true),
	}

	local hl_fetched = {
		error = { fg = hl_origin.error.foreground, bg = hl_bg, default = true },
		warn = { fg =  hl_origin.warn.foreground,  bg = hl_bg, default = true },
		info = { fg =  hl_origin.info.foreground,  bg = hl_bg, default = true },
		hint = { fg =  hl_origin.hint.foreground,  bg = hl_bg, default = true },
	}

	set_hl(0, "SpoonDiagnosticError", hl_fetched.error)
	set_hl(0, "SpoonDiagnosticWarn",  hl_fetched.warn )
	set_hl(0, "SpoonDiagnosticInfo",  hl_fetched.info )
	set_hl(0, "SpoonDiagnosticHint",  hl_fetched.hint )

	local count = {}
	local dtype = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(dtype) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local diagnostics = {
		errors = count["errors"] ~= 0
				and table.concat({ "%#SpoonDiagnosticError#  ", count["errors"], "%#SpoonDiagnosticError# " })
			or "",

		warnings = count["warnings"] ~= 0
				and table.concat({ "%#SpoonDiagnosticWarn#  ", count["warnings"], "%#SpoonDiagnosticWarn# " })
			or "",

		hints = count["hints"] ~= 0
				and table.concat({ "%#SpoonDiagnosticHint#  ", count["hints"], "%#SpoonDiagnosticHint# " })
			or "",

		info = count["info"] ~= 0
				and table.concat({ "%#SpoonDiagnosticInfo#  ", count["info"], "%#SpoonDiagnosticInfo# " })
			or "",
	}

	return table.concat({ diagnostics.errors, diagnostics.warnings, diagnostics.hints, diagnostics.info, "%#Normal#" })
end

return M
