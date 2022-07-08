function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function require_setup(plugin, config)
	require(plugin).setup(config)
end

function safe_require(plugin, config)
	config = config or {} 
	if not pcall(require_setup, plugin, config) then
		print('Warning: Plugin ' .. plugin ' not found.')
	end
end

safe_require('color-picker', {})
safe_require('zen-mode', {})

