local M = {}
--- Flutter stuff
local nvim_eleven = vim.fn.has 'nvim-0.11' == 1
local validate = vim.validate
local function tbl_flatten(t)
  --- @diagnostic disable-next-line:deprecated
  return nvim_eleven and vim.iter(t):flatten(math.huge):totable() or vim.tbl_flatten(t)
end

-- For zipfile: or tarfile: virtual paths, returns the path to the archive.
-- Other paths are returned unaltered.
local function strip_archive_subpath(path)
  -- Matches regex from zip.vim / tar.vim
  path = vim.fn.substitute(path, 'zipfile://\\(.\\{-}\\)::[^\\\\].*$', '\\1', '')
  path = vim.fn.substitute(path, 'tarfile:\\(.\\{-}\\)::.*$', '\\1', '')
  return path
end
local function search_ancestors(startpath, func)
  if nvim_eleven then
    validate('func', func, 'function')
  end
  if func(startpath) then
    return startpath
  end
  local guard = 100
  for path in vim.fs.parents(startpath) do
    -- Prevent infinite recursion if our algorithm breaks
    guard = guard - 1
    if guard == 0 then
      return
    end

    if func(path) then
      return path
    end
  end
end

local function escape_wildcards(path)
  return path:gsub('([%[%]%?%*])', '\\%1')
end

local function root_pattern(...)
  local patterns = tbl_flatten { ... }
  return function(startpath)
    startpath = strip_archive_subpath(startpath)
    for _, pattern in ipairs(patterns) do
      local match = search_ancestors(startpath, function(path)
        for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, '/'), true, true)) do
          if vim.loop.fs_stat(p) then
            return path
          end
        end
      end)

      if match ~= nil then
        return match
      end
    end
  end
end

function M.dart_config(on_attach)
  return {
    cmd = { "dart", "language-server", "--protocol=lsp" },
    filetypes = { "dart" },
    root_dir = root_pattern 'pubspec.yaml',
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
        -- analysisExcludedFolders

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
    on_attach = on_attach,
  }
end

return M
