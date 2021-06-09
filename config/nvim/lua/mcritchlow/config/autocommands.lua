local api = vim.api
local function nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command('augroup '..group_name)
		api.nvim_command('autocmd!')
		for _, def in ipairs(definition) do
			-- if type(def) == 'table' and type(def[#def]) == 'function' then
			-- 	def[#def] = lua_callback(def[#def])
			-- end
			local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
			api.nvim_command(command)
		end
		api.nvim_command('augroup END')
	end
end

-- Define autocommands as a list here
local autocmds = {
	sofancy = {
		{"TextYankPost", "*", "lua require'vim.highlight'.on_yank {higroup='Substitute', timeout=300} endif"};
	};
}

nvim_create_augroups(autocmds)
