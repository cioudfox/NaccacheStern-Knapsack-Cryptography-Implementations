--Convert any dictionary that has 255 or less characters
local function asctodec(str)
    local decarr = {}
    for i = 1, #str do
        local char = str:sub(i, i)
        table.insert(decarr, string.byte(char))
    end
    return decarr
end

-- Function to convert decimal array back to ASCII string
local function dectoasc(decarr)
    local temp = {}
    for _, value in ipairs(decarr) do
        table.insert(temp, string.char(value))
    end
    return table.concat(temp)
end

return {asctodec = asctodec, dectoasc = dectoasc}