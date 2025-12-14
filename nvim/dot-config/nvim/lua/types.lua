--------------------------------------------------------------------------------
-- types.lua
-- Centralized type definitions for Neovim configs, LSP, plugins, etc.
-- EmmyLua/LuaLS compatible.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Neovim primitives
--------------------------------------------------------------------------------

---@class NvimKeymapOpts
---@field buffer? boolean|integer
---@field silent? boolean
---@field remap? boolean
---@field expr? boolean
---@field desc? string

---@alias KeymapRHS string|fun(...)

---@class KeymapSpec
---@field mode string|string[]     # "n", "v", { "n", "i" }, etc.
---@field lhs  string
---@field rhs  KeymapRHS
---@field opts? NvimKeymapOpts

--------------------------------------------------------------------------------
-- Autocmds
--------------------------------------------------------------------------------

---@class AutocmdOpts
---@field pattern? string|string[]
---@field group? integer|string
---@field callback? fun(ev: table)
---@field desc? string
---@field nested? boolean
---@field once? boolean

---@class AutocmdSpec
---@field event string|string[]      # "BufEnter", { "BufReadPost", "BufNewFile" }, etc.
---@field opts? AutocmdOpts

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------

---@class LspOnAttachFn
---@field (fun(client: vim.lsp.Client, bufnr: integer))

---@class LspConfigBase
---@field on_attach? LspOnAttachFn
---@field capabilities? table
---@field settings? table
---@field flags? table

---@class LspServerConfig : LspConfigBase

---@alias LspServerName
---| "pyright"
---| "ruff"
---| "lua_ls"
---| "tsserver"
---| "rust_analyzer"
---| "gopls"
---| string  # allow custom server names

---@alias LspServerMap table<LspServerName, LspServerConfig>

--------------------------------------------------------------------------------
-- Formatters / Linters (conform.nvim, null-ls style)
--------------------------------------------------------------------------------

---@class FormatterConfig
---@field command? string
---@field args? string[]
---@field cwd? fun(bufnr: number): string
---@field stdin? boolean

---@alias FormatterName string
---@alias FormatterList FormatterName[]

--------------------------------------------------------------------------------
-- Filetype → tools map
--------------------------------------------------------------------------------

---@class FiletypeConfig
---@field formatters? FormatterList
---@field lsp?         LspServerName[]

---@alias Filetype string
---@alias FiletypeMap table<Filetype, FiletypeConfig>

--------------------------------------------------------------------------------
-- Lazy.nvim plugin specs
--------------------------------------------------------------------------------

-- Basic Lazy spec (simplified but covers 95% of usage)
---@class LazyPluginSpec
---@field [1] string                       # plugin identifier, e.g. "neovim/nvim-lspconfig"
---@field name? string
---@field lazy? boolean
---@field event? string|string[]
---@field cmd? string|string[]
---@field ft? string|string[]
---@field keys? table[]                    # keys = { { "<leader>x", "<cmd>Something<cr>" } }
---@field init? fun()
---@field config? fun(_, opts: table)
---@field dependencies? LazyPluginSpec[]
---@field opts? table                     # plugin options passed to config()
---@field priority? number
---@field enabled? boolean|fun():boolean

---@alias LazySpecList LazyPluginSpec[]
