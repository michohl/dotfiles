-- Setup Panels
require("dapui").setup({
  layouts = {
    {
      -- You can change the order of elements in the sidebar
      elements = {
        -- Provide IDs as strings or tables with "id" and "size" keys
        {
          id = "scopes",
          size = 0.25, -- Can be float or integer > 1
        },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 30,
      position = "left", -- Can be "left" or "right"
    },
    {
      elements = {
        "repl",
        -- "console",
      },
      size = 30,
      position = "bottom", -- Can be "bottom" or "top"
    },
  }
})


-- Setup golang
require('dap-go').setup {
  dap_configurations = {
    {
      -- Must be "go" or it will be ignored by the plugin
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  },
  -- delve configurations
  delve = {
    -- time to wait for delve to initialize the debug session.
    -- default to 20 seconds
    initialize_timeout_sec = 20,
    -- a string that defines the port to start delve debugger.
    -- default to string "${port}" which instructs nvim-dap
    -- to start the process in a random available port
    port = "${port}"
  },
}

-- Load the VSCode launch.json if it exists. Otherwise just run normally
local continue = function()
  if vim.fn.filereadable('.vscode/launch.json') then
    require('dap.ext.vscode').load_launchjs()
  end
  require('dap').continue()
end

vim.keymap.set('n', '<Leader>c', function() continue() end)          -- Start a new debug session or continue until next breakpoint
