local utils = require("plugins.utils.utils")
local M = {}
--- Flutter stuff
function M.on_attach (client, bufnr)
  local opts = { buffer = bufnr, remap = false }
end

function M.dart_config (on_attach)
  return {
    cmd = { "dart", "language-server", "--protocol=lsp" },
    filetypes = { "dart" },
    root_dir = utils.root_pattern("pubspec.yaml"),
    init_options = {
      --- When set to true, workspace folders will be ignored and analysis will be performed based on the open files, as if no
      --- workspace was open at all. This allows opening large folders without causing them to be completely analyzed.
      --- Defaults to false.
      ---(bool?)
      -- onlyAnalyzeProjectsWithOpenFiles = true

      --- When set to false, completion will not include symbols that are not already imported into the current file.
      -- Defaults to true, though the client must additionally support workspace/applyEdit for these completions to be included.
      ---(bool?)
      suggestFromUnimportedLibraries = true,

      --- When set to true, dart/textDocument/publishClosingLabels notifications will be sent with information to render editor
      --- closing labels.
      ---(bool?)
      closingLabels = true,

      --- When set to true, dart/textDocument/publishOutline notifications will be sent with outline information for open files.
      ---(bool?)
      ouline = true, -- Default:

      --- When set to true, dart/textDocument/publishFlutterOutline notifications will be sent with Flutter outline information for
      --- open files.
      ---(bool?)
      flutterOutline = true,

      --- When set to true, indicates that the client will handle dart/openUri notifications by opening a browser for the supplied
      --- URI.
      ---(bool?)
      -- allowOpenUri
    },
    settings = {
      dart = {
        --- An array of paths (absolute or relative to each workspace folder) that should be excluded from analysis.
        --- (List<String>?)
        analysisExcludedFolders = {},

        --- When set to false, prevents registration (or unregisters) the SDK formatter. When set to true or not supplied, will
        --- register/reregister the SDK formatter.
        --- (bool?)
        -- enableSdkFormatter

        --- Sets a default value for the formatter to wrap code at if no value is specified in formatter.page_width in
        --- analysis_options.yaml. If unspecified by both, code will be wrapped at 80 characters.
        --- (int?)
        lineLength = 128,

        --- When set to true, completes functions/methods with their required parameters.
        --- (bool?)
        completeFunctionCalls = true,

        ---  Whether to generate diagnostics for TODO comments. If unspecified, diagnostics will not be generated.
        --- (bool?)
        showTodos = true,

        --- When set to "always", will include edits to rename files when classes are renamed if the filename matches the class
        --- name (but in snake_form). When set to "prompt", a prompt will be shown on each class rename asking to confirm the
        --- file rename. Otherwise, files will not be renamed. Renames are performed using LSP's ResourceOperation edits - that
        --- means the rename is simply included in the resulting WorkspaceEdit and must be handled by the client.
        --- (String)
        -- renameFilesWithClasses

        ---  Whether to include code snippets (such as class, stful, switch) in code completion. When unspecified, snippets
        ---  will be included.
        --- (bool?)
        -- enableSnippets

        --- Whether to update imports and other directives when files are renamed. When unspecified, imports will be updated if
        --- the client supports willRenameFiles requests.
        --- (bool?)
        -- updateImportsOnRename

        --- The typekind of dartdocs to include in Hovers, Code Completion, Signature Help and other similar requests. If not
        --- set, defaults to full.
        --- (none, summary or full)
        -- documentation

        --- Whether to include symbols from dependencies and Dart/Flutter SDKs in Workspace Symbol results. If not set,
        --- defaults to true.
        --- (bool?)
        -- includeDependenciesInWorkspaceSymbols
      },
    },
    on_attach = function (client, bufnr)
      on_attach(client, bufnr)
      M.on_attach(client, bufnr)
    end,
  }
end

return M
