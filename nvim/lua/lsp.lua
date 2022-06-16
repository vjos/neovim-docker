local nvim_lsp = require'lspconfig'

local pid = vim.fn.getpid()
local omnisharp_bin = "/home/jventers/.cache/omnisharp-vim/omnisharp-roslyn/run"

require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
    root_dir = nvim_lsp.util.root_pattern("*.csproj", "*sln");
}
