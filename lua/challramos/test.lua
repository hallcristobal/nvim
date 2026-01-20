local utils = require("lua.plugins.utils.utils")
local extension_path = utils.MASON() .. "/packages/codelldb/extension"
local c_path = extension_path .. "/adapter/codelldb"
local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"
local cfg = require("rustaceanvim.config")

print(extension_path)
print(liblldb_path)
print(cfg)
print(c_path)


