return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "junegunn/fzf"
    },
    config = true,
    init = function()
        vim.api.nvim_create_user_command('Files', 'FzfLua files', {})
    end
  },
  {
    "junegunn/fzf", build="./install --bin"
  }
}
