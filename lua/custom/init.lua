-- require('lazy').setup {
--   -- apoulos lazy
--   {
--     'folke/zen-mode.nvim',
--     opts = {
--       -- your configuration comes here
--       -- or leave it empty to use the default settings
--       -- refer to the configuration section below
--     },
--   },
--   { 'mfussenegger/nvim-jdtls' },
--   {
--     'ThePrimeagen/harpoon',
--     branch = 'harpoon2',
--     dependencies = { 'nvim-lua/plenary.nvim' },
--   },
-- }

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Keep signcolumn on by default
-- apoulos was yes
-- auto makes which key small
vim.opt.signcolumn = 'no'

-- apoulos
vim.opt.list = false

-- Minimal number of screen lines to keep above and below the cursor.
-- apoulos was 10
vim.opt.scrolloff = 4

-- go/ydl was changing directory to go automatically so project is disabled
-- lvim.builtin.project.active = false
-- lvim.builtin.nvim-tree.active = false
-- require("nvim-tree").setup({
--   sync_root_with_cwd = true,
--   respect_buf_cwd = true,
--   update_focused_file = {
--     enable = true,
--     update_root = true
--   },
-- })

-- open diagnostic float when cursor at error
-- vim.api.nvim_create_autocmd('CursorHold', {
--   buffer = bufnr,
--   callback = function()
--     local opts = {
--       focusable = false,
--       close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
--       border = 'rounded',
--       source = 'always',
--       prefix = ' ',
--       scope = 'cursor',
--     }
--     vim.diagnostic.open_float(nil, opts)
--   end,
-- })

-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.wrap = true

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- Lazy
-- lvim.plugins = {
--   {
--     "folke/trouble.nvim",
--     cmd = "TroubleToggle",
--   },
--   {
--     "ray-x/go.nvim",
--     dependencies = { -- optional packages
--       "ray-x/guihua.lua",
--       "neovim/nvim-lspconfig",
--       "nvim-treesitter/nvim-treesitter",
--     },
--     config = function()
--       require("go").setup()
--     end,
--     event = { "CmdlineEnter" },
--     ft = { "go", 'gomod' },
--     build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
--   },
--   -- apoulos
--   -- from: https://github.com/z0mbix/vim-shfmt
--   {
--     "z0mbix/vim-shfmt",
--     ft = { "sh" },
--     -- { 'for': 'sh' }
--   },
-- }

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- goto previous position
-- apoulos from nvchad config
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = { '*' },
  callback = function()
    if vim.fn.line '\'"' > 1 and vim.fn.line '\'"' <= vim.fn.line '$' then
      -- vim.fn.nvim_exec('normal! g\'"', false)
      vim.api.nvim_exec2('normal! g`"', { output = false })
    end
  end,
})

-- go format and fix imports on save
-- from: https://github.com/ray-x/go.nvim
-- local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*.go',
--   callback = function()
--     -- require('go.format').gofmt()
--     require('go.format').goimport()
--   end,
--   group = format_sync_grp,
-- })

-- hide command bar at bottom of screen
-- vim.opt.cmdheight = 0

-- fold default to marker
vim.opt.foldmethod = 'marker'

-- autoinsert on terminal window entering
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
  pattern = 'term://*',
  command = 'startinsert',
})

-- stop auto comment
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = '*',
  command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
})

-- plugin vim-shfmt: from: https://github.com/z0mbix/vim-shfmt
-- open :Lazy to install plugin
-- indent 2 spaces (man shfmt)
vim.g.shfmt_extra_args = '-i 2'

-- plugin vim-shfmt: format on save
vim.g.shfmt_fmt_on_save = 1

-- open diagnostic float
vim.keymap.set('n', '<leader>e', function()
  local opts = {
    focusable = false,
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
    border = 'rounded',
    source = 'always',
    prefix = ' ',
    scope = 'cursor',
  }
  vim.diagnostic.open_float(nil, opts)
end, { desc = 'Show [E]rrors/warnings/hints' })

-- vim.keymap.set('n', '<leader>a', function()
--   vim.call 'CompileRunGcc'
-- end, { desc = 'Compile/Build/Run' })

vim.keymap.set('n', '<leader>a', function()
  CompileRun()
end, { desc = 'Compile/Build/Run' })

vim.keymap.set('n', '<M-a>', '<leader>a', { remap = true, desc = 'Compile/Build/Run' })
--   function()
--   CompileRun() -- vim.call 'CompileRunGcc'
-- end,

vim.keymap.set('n', '<tab>', ':bnext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-tab>', ':bprev<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<M-q>', ':q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<M-s>', ':update<CR>', { desc = 'Update' })
vim.keymap.set('n', '<M-g>', ':w<CR>!gco<CR>', { desc = 'Save and git commit' })
vim.keymap.set('n', '<M-t>', ':split term://bash<CR>', { desc = 'Terminal' })
-- search on // for select mode
-- vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
vim.keymap.set('v', '/', '"fy/\\V<C-R>f<CR>', { desc = 'search selected' })

-- nmap <leader>a :call CompileRunGcc()<cr>
-- " nmap <leader>q :q<CR>
-- " nmap <leader>s :update<CR>
-- nmap <tab> :bnext<CR>
-- nmap <S-tab> :bprev<CR>
-- nmap <M-a> :call CompileRunGcc()<cr>
-- nmap <M-q> :q<CR>
-- nmap <M-s> :update<CR>
-- " nmap <M-s> :w<CR>maven
-- nmap <M-g> :w<CR>:!gco<CR>
-- nmap <M-t> :split term://bash<CR>

-- old school vim settings
function CompileRun()
  vim.cmd 'update'
  local ft = vim.o.filetype
  if ft == 'c' then
    vim.cmd ':split term://gcc % -o %< && ./%<'
  elseif ft == 'cpp' then
    vim.cmd ':split term://g++ % -o %< && ./%<'
  -- vim.cmd "!g++ % -o %<"
  elseif ft == 'java' then
    -- vim.cmd ':split term://javac *.java && java -cp %:p:h %:t:r'
    vim.cmd ':split term://javac % && java -cp %:p:h %:t:r %:t:r'
  -- vim.cmd "!clear; javac % && java -cp %:p:h %:t:r"
  -- vim.cmd ":split term://javac --enable-preview --source 21 % && java --enable-preview -cp %:p:h %:t:r"
  elseif ft == 'haskell' then
    vim.cmd ':split term://ghc -dynamic % && ./%<'
  elseif ft == 'tcl' then
    vim.cmd ':split term://tclsh %'
  elseif ft == 'expect' then
    vim.cmd ':split term://expect %'
  elseif ft == 'perl' then
    vim.cmd ':split term://perl %'
  elseif ft == 'sh' then
    vim.cmd ':split term://bash %'
  elseif ft == 'bash' then
    vim.cmd ':split term://bash %'
  elseif ft == 'basic' then
    vim.cmd ':split term://bash %'
  elseif ft == 'basic' then
    vim.cmd ':split term://makehex.sh %'
  elseif ft == 'rust' then
    vim.cmd ':split term://cargo run && echo && echo DONE. && read a'
  elseif ft == 'python' then
    vim.cmd ':split term://python %'
  elseif ft == 'html' then
    vim.cmd '!firefox % &'
  elseif ft == 'javascript' then
    vim.cmd ':split term://node %'
  elseif ft == 'ruby' then
    vim.cmd ':split term://ruby %'
  elseif ft == 'zig' then
    vim.cmd ':split term://zig run -fno-llvm -fno-lld %'
  elseif ft == 'go' then
    vim.cmd ':split term://go run .'
  -- vim.cmd ":split term://go run . && echo && echo 'DONE (press return)' && read a"
  -- vim.cmd ":split term://go build -o ./a.out % && ./a.out && echo && echo 'DONE (press return)' && read a"
  -- vim.cmd ":split term://go build % && ./%< && echo && echo DONE. && read a"
  -- vim.cmd "!go build %<"
  -- vim.cmd "!time go run %"
  -- vim.cmd ":split term://go run %"
  -- vim.cmd ":split term://(go run % || read a)"
  -- best behaved on ctrl-d or fatal"
  -- vim.cmd ":split term://(go run %)"
  elseif ft == 'mkd' then
    vim.cmd '!~/.vim/markdown.pl % > %.html &'
    vim.cmd '!firefox %.html &'
  end
end

vim.cmd [[
  " search on // for select mode
  "vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

  func! CompileRunGcc()
    " exec "w"
    exec "update"
    if &filetype == 'c'
      exec ":split term://gcc % -o %< && ./%<"
      " exec ":split term://make && ./%<"
      " exec "!clear; gcc % -o %< && ./%<"
      " exec "!clear; gcc % -o %<"
      " exec ":split term://[ -f Makefile ] && make || gcc % -o %< && ./%<"
      " exec ":split term://test -f Makefile && make || gcc % -o %< && ./%<"
    elseif &filetype == 'cpp'
      exec ":split term://g++ % -o %< && ./%<"
      " exec "!g++ % -o %<"
    elseif &filetype == 'java'
      exec ":split term://javac *.java && java -cp %:p:h %:t:r"
      " exec ":split term://javac % && java -cp %:p:h %:t:r"
      " exec "!clear; javac % && java -cp %:p:h %:t:r"
      " exec ":split term://javac --enable-preview --source 21 % && java --enable-preview -cp %:p:h %:t:r"
    elseif &filetype == 'haskell'
      exec ":split term://ghc -dynamic % && ./%<"
    elseif &filetype == 'tcl'
      exec ":split term://tclsh %"
    elseif &filetype == 'expect'
      exec ":split term://expect %"
    elseif &filetype == 'perl'
      exec ":split term://perl %"
    elseif &filetype == 'sh'
      exec ":split term://bash %"
    elseif &filetype == 'bash'
      exec ":split term://bash %"
    elseif &filetype == 'basic'
      exec ":split term://bash %"
    elseif &filetype == 'basic'
      exec ":split term://makehex.sh %"
    elseif &filetype == 'rust'
      exec ":split term://cargo run && echo && echo DONE. && read a"
    elseif &filetype == 'python'
      exec ":split term://python %"
    elseif &filetype == 'html'
      exec "!firefox % &"
    elseif &filetype == 'javascript'
      exec ":split term://node %"
    elseif &filetype == 'ruby'
      exec ":split term://ruby %"
    elseif &filetype == 'zig'
      exec ":split term://zig run -fno-llvm -fno-lld %"
    elseif &filetype == 'go'
      exec ":split term://go run ."
      " exec ":split term://go run . && echo && echo 'DONE (press return)' && read a"
      " exec ":split term://go build -o ./a.out % && ./a.out && echo && echo 'DONE (press return)' && read a"
      " exec ":split term://go build % && ./%< && echo && echo DONE. && read a"
      " exec "!go build %<"
      " exec "!time go run %"
      " exec ":split term://go run %"
      " exec ":split term://(go run % || read a)"
      " best behaved on ctrl-d or fatal"
      " exec ":split term://(go run %)"
    elseif &filetype == 'mkd'
      exec "!~/.vim/markdown.pl % > %.html &"
      exec "!firefox %.html &"
    endif
  endfunc
]]

local harpoon = require 'harpoon'
harpoon:setup() -- REQUIRED

vim.keymap.set('n', '<M-h>', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<M-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<M-j>', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<M-k>', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<M-l>', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<M-;>', function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<M-S-P>', function()
  harpoon:list():prev()
end)
vim.keymap.set('n', '<M-S-N>', function()
  harpoon:list():next()
end)

-- basic telescope configuration
local conf = require('telescope.config').values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Harpoon',
      finder = require('telescope.finders').new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

vim.keymap.set('n', '<M-u>', function()
  toggle_telescope(harpoon:list())
end, { desc = 'Open harpoon window' })

vim.keymap.set('n', '<leader>z', function()
  require('zen-mode').toggle {
    window = {
      width = 1, -- 0.85, -- width will be 85% of the editor width
      options = {
        signcolumn = 'no', -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        cursorline = false, -- disable cursorline
        cursorcolumn = false, -- disable cursor column
        foldcolumn = '0', -- disable fold column
        list = false, -- disable whitespace characters
      },
    },
  }
end, { desc = '[Z]en mode' })

-- apoulos toggle comments
-- from: https://github.com/neovim/neovim/discussions/29075
vim.keymap.set({ 'n', 'v' }, '<leader>/', 'gc', { remap = true, desc = 'Toggle comment' })
vim.keymap.set({ 'n' }, '<leader>/', 'gcc', { remap = true, desc = 'Toggle comment' }) -- Use with leader n to comment n lines

vim.keymap.set('n', '<leader>tl', function()
  -- auto makes which key small
  -- local s = vim.opt.signcolumn._value
  vim.o.list = not vim.o.list
  -- local s = vim.o.list
  -- if s == 'yes' then
  --   vim.o.list = false
  -- else
  --   vim.o.signcolumn = 'yes'
  -- end
  vim.notify('list set to ' .. tostring(vim.o.list) .. ' with listchars: ' .. vim.o.listchars)
end, { desc = '[T]oggle [L]ist characters' })

vim.keymap.set('n', '<leader>tg', function()
  -- auto makes which key small
  -- local s = vim.opt.signcolumn._value
  local s = vim.o.signcolumn
  if s == 'yes' then
    vim.o.signcolumn = 'no'
  else
    vim.o.signcolumn = 'yes'
  end
  vim.notify 'hi'
end, { desc = '[T]oggle [G]it sign column' })

vim.keymap.set('n', '<leader>x', ':bd<CR>', { desc = 'Close Buffer' })
-- from lunarvim .local/share/lunarvim/lvim/lua/lvim/keymappings.lua
-- navigate tab completion with <c-j> and <c-k>
-- runs conditionally
-- ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
-- ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
vim.keymap.set('c', '<C-j>', 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, desc = 'Cmp Next' })
vim.keymap.set('c', '<C-k>', 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, desc = 'Cmp Prev' })
-- Resize with arrows
-- ["<C-Up>"] = ":resize -2<CR>",
-- ["<C-Down>"] = ":resize +2<CR>",
-- ["<C-Left>"] = ":vertical resize -2<CR>",
-- ["<C-Right>"] = ":vertical resize +2<CR>",
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { desc = 'Resize up' })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { desc = 'Resize down' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Resize left' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Resize right' })
-- QuickFix
-- ["]q"] = ":cnext<CR>",
-- ["[q"] = ":cprev<CR>",
-- ["<C-q>"] = ":call QuickFixToggle()<CR>",
vim.keymap.set('n', ']q', ':cnext<CR>', { desc = 'Quickfix next' })
vim.keymap.set('n', '[q', ':cprev<CR>', { desc = 'Quickfix prev' })
-- n: Move current line / block with Alt-j/k a la vscode.
-- ["<A-j>"] = ":m .+1<CR>==",
-- ["<A-k>"] = ":m .-2<CR>==",
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { desc = 'Line move down' })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { desc = 'Line move up' })
-- x: Move current line / block with Alt-j/k ala vscode.
-- ["<A-j>"] = ":m '>+1<CR>gv-gv",
-- ["<A-k>"] = ":m '<-2<CR>gv-gv",
vim.keymap.set('x', '<M-j>', ":m '>+1<CR>gv-gv", { desc = 'Block move down' })
vim.keymap.set('x', '<M-k>', ":m '>-3<CR>gv+gv", { desc = 'Block move up' })
-- v: Better indenting
-- ["<"] = "<gv",
-- [">"] = ">gv",
vim.keymap.set('v', '<', '<gv', { desc = 'Unindent' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent' })

-- apoulos from: https://vi.stackexchange.com/questions/42740/how-to-load-the-global-vim-object-so-lua-language-server-stops-complaining
-- error: caused Lua Language server refused to load this directory on nvim startup
-- moved diagnostics = {globals={'vim'}} to main init.lua lua_ls table and it is fixed
-- fix lua lsp warnings: undefined global vim
-- vim.lsp.start {
--   name = 'lua-language-server',
--   cmd = { 'lua-language-server' },
--   root_dir = vim.fs.dirname(vim.fs.find({ '.git', '.vim', 'nvim' }, { upward = true })[1]),
--   settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
-- }

--fix c/cpp comment string
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('FixCommentString', { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = '// %s'
  end,
  pattern = { 'c', 'cpp' },
})
