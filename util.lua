M = {}


M.partial = function(f, arg)
    return function(...)
        return f(arg, ...)
    end
end

M.map = function(f, ...)
    local t = {}
    for _, v in ipairs(...) do
        t[#t+1] = f(v)
    end
    return t
end

M.filter = function(f, ...)
    local t = {}
    for _, v in ipairs(...) do
        if f(v) == true then
            t[#t+1] = (v)
        end
    end
    return t
end
