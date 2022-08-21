M = {}

-- local wk = require("which-key")

-- M.setmap = function(key, value, descr, opts)
--     wk.register({ [key] = { value, descr } }, opts)
-- end

M.setmap = function (mode, key, value, descr, opts)
    opts["descr"] = descr
    vim.keymap.set(mode, key, value, opts)
end

M.genleader = function(leader)
    local function ret(s)
        return table.concat({ leader, s })
    end

    return ret
end

M.genheldkey = function(leader)
    local function ret(s)
        return table.concat({ "<", leader, "-", s, ">" })
    end

    return ret
end

M.leader = M.genleader("<Leader>")
M.localleader = M.genleader("<LocalLeader>")
M.Ctrl = M.genheldkey("c")
M.Alt = M.genheldkey("a")
M.Shift = M.genheldkey("s")
M.plugmapping = M.genleader("<Plug>")

return M
