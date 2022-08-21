local util = require("util")
local km = require "keymap"
M = {}

local function mapping_getter(mode)
    local mappings = vim.api.nvim_get_keymap(mode)
    mappings = util.filter(function(x) return x.buffer == 0 end, mappings)
    local ret = {}
    for _, v in ipairs(mappings) do
        mappings[mode.rhs] = v
    end
    return ret
end

local mapget = {}
for _, mode in ipairs({"n", "v", "i", "t"}) do
    mapget[mode] = partial(mapping_getter, mode)
end


M.toggledmapping = function(mode, key, value, descr, opts)
    local using_old = true
    local oldmap = mapget[mode]()[key]
    local function ret()
        if using_old then
            oldmap = mapget[mode]()[key]
            km.setmap(key, value, descr, opts)
            using_old = false
        else
            km.setmap(oldmap.lhs, oldmap.rhs, oldmap.descr, { oldmap.mode, oldmap.noremap, oldmap.silent, oldmap.nowait, oldmap.script, oldmap.expr })
            using_old = true
        end
    end
    return ret
end

M.toggledmode = function(toggledmappings)
    local toggle = function()
        for _, mapping in pairs(toggledmappings) do
            mapping()
        end
    end
    return toggle
end
