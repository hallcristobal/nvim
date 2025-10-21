local js_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue"
}
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "williamboman/mason.nvim",
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    },
    -- {
    --   "mxsdev/nvim-dap-vscode-js",
    --   config = function()
    --     require("dap-vscode-js").setup({
    --       debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
    --       adapters = {
    --         "chrome",
    --         "pwa-node",
    --         "pwa-chrome",
    --         "node-terminal",
    --         "node"
    --       }
    --     })
    --   end
    -- },
    {
      "Joakker/lua-json5",
      build = "./install.sh",
    },
    {
      "rcarriga/nvim-dap-ui",
      event = "VeryLazy",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap"
      },
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        require("dapui").setup()
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.after.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.after.event_exited["dapui_config"] = function() dapui.close() end
      end
    },
  },
  config = function()
    local dap = require("dap")
    require("nvim-dap-virtual-text").setup()
    ---
    --- Gets a path to a package in the Mason registry.
    --- Prefer this to `get_package`, since the package might not always be
    --- available yet and trigger errors.
    ---@param pkg string
    ---@param path? string
    local function get_pkg_path(pkg, path)
      pcall(require, 'mason')
      local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
      path = path or ''
      local ret = root .. '/packages/' .. pkg .. '/' .. path
      return ret
    end

    require('dap').adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
          '${port}',
        },
      },
    }


    for _, language in ipairs(js_languages) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          name = "--------------------------------",
          type = "",
          request = "launch"
        }
      }
    end


    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dr", function()
      if vim.fn.filereadable(".vscode/launch.json") then
        local dap_vscode = require("dap.ext.vscode")
        dap_vscode.load_launchjs(nil, {
          ["pwa-node"] = js_based_languages,
          ["node"] = js_based_languages,
        })
      end
      dap.continue()
    end)
  end
}
