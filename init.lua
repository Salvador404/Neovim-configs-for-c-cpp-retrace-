
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({

  
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end
  },

  
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        completion = { autocomplete = false },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end
  },

  
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").clangd.setup {}
      require("lspconfig").pyright.setup {}
    end
  },

  
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        direction = "vertical",
        size = 50,
        open_mapping = [[<C-\>]]
      }
    end
  }

})


require("nvim-treesitter.configs").setup({
  ensure_installed = { "cpp", "c", "lua", "python" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})


vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })


local Terminal = require("toggleterm.terminal").Terminal
local code_term = Terminal:new({
  direction = "vertical",
  size = 50,
  id = 101,
  hidden = false
})

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end


local function get_mod_time(path)
  local stat = vim.loop.fs_stat(path)
  if stat then
    return stat.mtime.sec
  else
    return 0
  end
end


local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end



local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end


vim.keymap.set("n", "<leader>c", function()
  local filename = vim.fn.expand("%:t:r")
  local filetype = vim.bo.filetype
  local filepath = vim.fn.expand("%:p")
  local output = vim.fn.expand("%:p:h") .. "/" .. filename .. ".exe"

  if filetype == "cpp" or filetype == "c" then
    
    if file_exists(output) then
      vim.fn.system("del \"" .. output .. "\"")
    end
    local cmd
	if filetype == "cpp" then
	  cmd = string.format("g++ \"%s\" -o \"%s\"", filepath, output)
	elseif filetype == "c" then
	  cmd = string.format("gcc \"%s\" -o \"%s\"", filepath, output)
	end

    local result = vim.fn.system(cmd)

    if vim.v.shell_error ~= 0 then
      print("❌ Compile error:")
      print(result)
    else
      print("✅ Compiled successfully.")
    end
  else
    print("🚫 This file type is not supported for compilation.")
  end
end, { noremap = true, silent = true })


vim.keymap.set("n", "<leader>r", function()
  local filename = vim.fn.expand("%:t:r")
  local filetype = vim.bo.filetype
  local output = vim.fn.expand("%:p:h") .. "/" .. filename .. ".exe"

  if filetype == "cpp" or filetype == "c" then
    if not file_exists(output) then
      print("🚫 No executable found. Please compile first with <leader>c.")
      return
    end
    if not code_term:is_open() then
      code_term:open()
    end
    
    code_term:send("echo.\n", false)
    code_term:send(string.format("\"%s\"\n", output), false)
  elseif filetype == "python" then
    local filepath = vim.fn.expand("%")
    local command = string.format("python \"%s\"", filepath)
    if not code_term:is_open() then
      code_term:open()
    end
    code_term:send("echo.\n", false)
    code_term:send(command .. "\n", false)
  else
    print("🚫 This file type is not supported.")
    return
  end
end, { noremap = true, silent = true })


vim.cmd.colorscheme("habamax")




