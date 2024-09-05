--[[
Naccache–Stern knapsack cryptosystem
]]
--[[
function S_root(a, b)
    --Default case: B CANNOT BE 0
    if b == 0 then
        return a, 1, 0
    else -- Recursively loop for x1 and y1
        local _, x1, y1 = S_root(b, a % b)
        local x = y1
        local y = x1 - math.floor(a / b) * y1
        return ((2^x) % (b+1)), x, y
    end
end
]]
--S_root function: Modified Euclidean Algo.
function itemgcd(a, b)
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

local function extended_gcd(a, b)
    if b == 0 then
        return a, 1, 0
    else
        local gcd, x1, y1 = extended_gcd(b, a % b)
        local x = y1
        local y = x1 - math.floor(a / b) * y1
        return gcd, x, y
    end
end

local function modular_exponentiation(a, exp, mod)
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

local function integerToBinaryArray(num)
    local binaryArray = {}
    for i = 1, 8 do
        binaryArray[i] = num % 2
        --table.insert(binaryArray, 1, num % 2)
        num = math.floor(num / 2)
    end
    return binaryArray
end

-- DEBUG VALUES
--local pval = 997
--local sval = math.random(1,pval-1)
--print("Secret Key",sval)
local a, p = 401, 1097
local pval = {2,3,5,7,11,13,17,19}
local pubk = {0,0,0,0,0,0,0,0}

local gcd, x, y = extended_gcd(a, p-1)
--print("GCD:", gcd)
print("Coefficients x and y:", x, y)
for i = 1, #pval do
    --print("TEST,", modular_exponentiation(3,347,997))
    pubk[i] = modular_exponentiation(pval[i],x,p)
end
--local sroot, x, y = S_root(a, p-1)

for i = 1 , #pubk do
    print("Public Key", pubk[i])
end

local mess = {11,40,50,32}
local binaryArray = {}

for i = 1, #mess do
    binaryArray[i] = integerToBinaryArray(mess[i])
end

--Create Cipher
local cipher = {}
for i = 1,#mess do
    local c = 1
    for j = 1,8 do
        c = (c * modular_exponentiation(pubk[j],binaryArray[i][j],p)) % p
        --print("Cipher - debug", c)
    end
    cipher[i] = c
end

for i=1,#cipher do
    print(cipher[i])
end
--Decrypt Message
local decipher = {}
for i = 1,#mess do
    local val = 0
    for j = 1,8 do -- Summation (2^j-1 mod p * invmod p_i - 1) * (GCD(p_i,c^a mod p) - 1) 
        val = (val + ( (modular_exponentiation(2,j-1,p) * (invmod((pval[j]-1),p)) )) * ((itemgcd(pval[j],modular_exponentiation(cipher[i],a,p))-1))) % p
    end

    decipher[i] = val
    --print("ORIGINALMESS"..val)
end

for i=1,#decipher do
    print(decipher[i])
end