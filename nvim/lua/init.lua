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
	local success, value = pcall(require_setup, plugin, config)
	if success then
		return value
	else
		print('Warning: Plugin ' .. plugin ' not found.')
	end
end


-- colour picker config
safe_require('color-picker', {})
map('n', '<C-c>', '<cmd>PickColor<cr>')
map('i', '<C-c>', '<cmd>PickColorInsert<cr>')

-- zen mode config
safe_require('zen-mode', {})

-- which-key.nvim config
safe_require('which-key', {})
