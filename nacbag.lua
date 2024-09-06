
--------------------------------------------------------------------------------------------------------
--- Functions used: GCD, Inverse Modulus, Extended Euclidean GCD, Modular Exponentiation
--- none of functions are designed for Large values past 10000000 
--- avoiding use of largenum library for simulation
--------------------------------------------------------------------------------------------------------
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

-- Libraryless Table Dump
local function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. ' ['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
  end
--------------------------------------------------------------------------------------------------------
--- Program Information
--- Note: Lua uses floating point for all values, thus it is not as compatible for incredibly large numbers
--- unless if a largenum library is used. For simplicity and usability on online compilers, I have opted out
--- of using libraries. Will occasionally fail depending on prime selected due to overflow.
--- 
--- PRIVATE INFORMATION  ---
--- p = some arbitrary large prime
--- s = Secret key. Value that satisfies GCD(x,p-1) x <- some integer between (0, p-1)
--- 
--- PUBLIC INFORMATION  ---
--- pval = Sequential key of primes used to calculate Public Key values
--- pubk = Public Key, solved using (pval) * (binary of Integer)
--- Cipher = Encrypted Message
--------------------------------------------------------------------------------------------------------
local p = 9999971  -- Prime Value Selected

math.randomseed(os.time()) --Generate a random value. Keep running until a gcd = 1 found
local s = math.random(0, p-1)
while itemgcd(p-1, s) ~= 1 do
    s = (s + 1) % p
end

print("SECRET KEY ", s)  -- Secret Key Generated


local pval = {2,3,5,7,11,13,17}
local pubk = {0,0,0,0,0,0,0}
local _, x, y = extended_gcd(s, p-1) -- Calculate X and Y from Euclids to do modular exponentiation and sq root
print("Coefficients x and y:", x, y)
for i = 1, #pval do
    if x < 0 then
      x = x + (p-1) -- If X is negative, add modulus to calculate its positive reciprocal
    end
    pubk[i] = modular_exponentiation(pval[i],x,p) -- Modular Exponentiation to generate the public key
end

--Create Message to send
local mess = {11,54,67,81,34,31,32,77,81}
print("Original Message: " .. dump(mess))

print("Public Key Table: " .. dump(pubk))
--------------------------------------------------------------------------------------------------------
--- Encrypting the Message
--------------------------------------------------------------------------------------------------------
local binaryArray = {} -- Generate the Binary representation of message key
for i = 1, #mess do
    binaryArray[i] = integerToBinaryArray(mess[i])
end

local cipher = {} -- Take Binary Key and Multiply by Prime Key
for i = 1,#mess do
    local c = 1
    for j = 1,#pubk do
        c = (c * modular_exponentiation(pubk[j],binaryArray[i][j],p)) % p
    end
    cipher[i] = c
end

-- Cipher is difficult to solve given values are too large with no easy way to reduce the knapsack problem
print("Cipher Message: " .. dump(cipher))

--------------------------------------------------------------------------------------------------------
--- Decrypting the Message
--- LaTex of Wikipedia Entry
--- m=\sum _{i=0}^{n}{\frac {2^{i}}{p_{i}-1}}\times \left(\gcd(p_{i},c^{s}\pmod p)-1\right)
--------------------------------------------------------------------------------------------------------
local decipher = {}
for i = 1,#mess do
    local val = 0
    for j = 1,#pval do -- Summation (2^j-1 mod p * invmod p_i - 1) * (GCD(p_i,c^s mod p) - 1). Accounts for Lua indexing starting at 1, subtract 1 from first equation.
        val = (val + ( (modular_exponentiation(2,j-1,p) * (invmod((pval[j]-1),p)) )) * ((itemgcd(pval[j],modular_exponentiation(cipher[i],s,p))-1))) % p
    end
    decipher[i] = val
end

print("Decrypted Message: " .. dump(decipher))