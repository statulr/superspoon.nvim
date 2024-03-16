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
		["rm"] = "MOAR",
		["r?"] = "CONFIRM",
		["t"] = "TERMINAL",
	}

	local current_mode = vim.api.nvim_get_mode().mode

	return table.concat({ "%s ", modes[current_mode] }):upper()
end

M.file_info = function()
	return " %t %m%r "
end

M.line_info = function()
	if vim.bo.filetype == "alpha" then
		return ""
	end

	return " %l:%c [%P] "
end

M.lsp = function()
	local set_hl = vim.api.nvim_set_hl
	local hl_bg = vim.fn.synIDattr(vim.fn.hlID("Statusline"), "bg")

	local hl_origin = {
		error = vim.api.nvim_get_hl_by_name("DiagnosticSignError", true),
		warn = vim.api.nvim_get_hl_by_name("DiagnosticSignWarn", true),
		info = vim.api.nvim_get_hl_by_name("DiagnosticSignInfo", true),
		hint = vim.api.nvim_get_hl_by_name("DiagnosticSignHint", true)
	}

	local hl_fetched = {
		error = {
			fg = hl_origin.error.foreground,
			bg = hl_bg
		},
		warn = {
			fg = hl_origin.warn.foreground,
			bg = hl_bg
		},
		info = {
			fg = hl_origin.info.foreground,
			bg = hl_bg
		},
		hint = {
			fg = hl_origin.hint.foreground,
			bg = hl_bg
		},
	}

	set_hl(0, "SpoonDiagnosticError", hl_fetched.error)
	set_hl(0, "SpoonDiagnosticWarn", hl_fetched.warn)
	set_hl(0, "SpoonDiagnosticInfo", hl_fetched.info)
	set_hl(0, "SpoonDiagnosticHint", hl_fetched.hint)

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

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = table.concat({ "%#SpoonDiagnosticError#  ", count["errors"], "%#SpoonDiagnosticError# " })
	end
	if count["warnings"] ~= 0 then
		warnings = table.concat({ "%#SpoonDiagnosticWarn#  ", count["warnings"], "%#SpoonDiagnosticWarn# " })
	end
	if count["hints"] ~= 0 then
		hints = table.concat({ "%#SpoonDiagnosticHint#  ", count["hints"], "%#SpoonDiagnosticHint# " })
	end
	if count["info"] ~= 0 then
		info = table.concat({ "%#SpoonDiagnosticInfo#  ", count["info"], "%#SpoonDiagnosticInfo# " })
	end

	return table.concat({ errors, warnings, hints, info, "%#Normal#" })
end

return M
