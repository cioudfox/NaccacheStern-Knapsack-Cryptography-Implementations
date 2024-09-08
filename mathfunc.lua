--Math Functions Lua
local function itemgcd(a, b)
    if b == 0 then
        return a
    else
        return itemgcd(b, a % b)
    end
end

local function invmod(a, m)
    local m0, x0, x1 = m, 0, 1
    if m == 1 then return 0 end

    while a > 1 do
        local q = math.floor(a / m)
        local t = m

        m = a % m
        a = t
        t = x0

        x0 = x1 - q * x0
        x1 = t
    end

    if x1 < 0 then
        x1 = x1 + m0
    end

    return x1
end

local function ext_gcd(a, b)
    if b == 0 then
        return a, 1, 0
    else
        local gcd, x1, y1 = ext_gcd(b, a % b)
        local x = y1
        local y = x1 - math.floor(a / b) * y1
        return gcd, x, y
    end
end

local function mod_exp(a, exp, mod)
    if mod == 1 then
        return 0
    end
    
    local result = 1
    a = a % mod

    while exp > 0 do
        if (exp % 2) == 1 then
            result = (result * a) % mod
        end
        exp = exp >> 1
        a = (a * a) % mod
    end

    return result
end

local function intToBinArr(num)
    local binaryArray = {}
    for i = 1, 8 do
        binaryArray[i] = num % 2
        --table.insert(binaryArray, 1, num % 2)
        num = math.floor(num / 2)
    end
    return binaryArray
end

return { itemgcd = itemgcd, invmod = invmod, ext_gcd = ext_gcd, mod_exp = mod_exp, intToBinArr = intToBinArr}