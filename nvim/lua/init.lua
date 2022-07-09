function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function require_setup(plugin, config)
	local loaded = require(plugin)
	loaded.setup(config)
	return loaded
end

function safe_require(plugin, config)
	config = config or {} 
	local success, value = pcall(require_setup, plugin, config)
	if success then
		return value
	else
		print('Warning: Plugin ' .. plugin ' not found.')
		return nil
	end
end


-- colour picker config
safe_require('color-picker', {})
map('n', '<C-c>', '<cmd>PickColor<cr>')
map('i', '<C-c>', '<cmd>PickColorInsert<cr>')

-- shade.nvim config; must be loaded before zen plugins as it will break them if not disabled
local shade = safe_require('shade', {
	overlay_opacity = 25,
	opacity_step = 1,
	keys = {
		toggle = '<Leader>s',
	},
})

-- true zen config
local true_zen = safe_require('true-zen', {
	integrations = {
		lightline = true,
	}
})

if true_zen and shade then
	true_zen.before_mode_ataraxis_on = function ()
		shade.deactivate()
	end
	true_zen.after_mode_ataraxis_off = function ()
		shade.activate()
	end
end

map('n', '<Leader>z', '<cmd>TZAtaraxis<cr>')


-- which-key.nvim config
safe_require('which-key', {})

-- indent-blankline setup
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

safe_require('indent_blankline', {
    show_end_of_line = true,
    space_char_blankline = " ",
})
