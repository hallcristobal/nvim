local function g(name, value) 
  vim.api.nvim_set_var(name, value)
end

-- g("flutter_command", "flutter") -- The Flutter executable path/name; defaults to 'flutter'.
-- g("flutter_hot_reload_on_save", "1") -- Whether to auto hot-reload when dart files are saved; defaults to 1.
-- g("flutter_hot_restart_on_save", "0") -- Whether to auto hot-restart when dart files are saved; defaults to 0.

-- "split" or 1: Open the log in a split, this is the default.
-- "tab": Open the log in a new tab.
-- "hidden" or 0: Do not open the log by default, can be opened later with FlutterSplit etc.
g("flutter_show_log_on_run", "tab") -- Automatically open __Flutter_Output__ when starting flutter using :FlutterRun; it can have one of the following values:
g("flutter_show_log_on_attach", "tab") -- Identical to g:flutter_show_log_on_run but affecting the :FlutterAttach command.

-- g("flutter_split_height", ) -- Initial height of the window opened by :FlutterSplit (or :FlutterRun and :FlutterAttach, when g:flutter_show_log_on_run is set to "split"); defaults to standard vim behavior, which is splitting the window in half.
g("flutter_autoscroll", 1) -- Autoscroll the flutter log when 1, defaults to 0.
g("flutter_use_last_run_option", 1) -- When set to 1 then :FlutterRun will use the arguments from the previous call when no arguments are specified.
g("flutter_use_last_attach_option", 1) -- Identical to g:flutter_use_last_run_option but affecting the :FlutterAttach command.
-- g("flutter_close_on_quit", 0) -- Whether to close all __Flutter_Output__ windows (splits and tabs) on :FlutterQuit; defaults to 0.


return {
  "dart-lang/dart-vim-plugin",
  "thosakwe/vim-flutter",
}
