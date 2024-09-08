local oldreq = require
local require = function(s) return oldreq('Naccache_Stern_Lua.Naccache-Stern-Knapsack-Cryptography-Lua.functions.' .. s) end
local mth = require("mathfunc")
--------------------------------------------------------------------------------------------------------
--- Program Information
--- Note: Lua uses floating point for all values, thus it is not as compatible for incredibly large numbers
--- unless if a largenum library is used. For simplicity and usability on online compilers, I have opted out
--- of using libraries. Will occasionally fail depending on prime selected due to overflow.
--- 
--- PRIVATE INFORMATION  ---
--- s = Secret key. Value that satisfies GCD(x,p-1) x <- some integer between (0, p-1)
--- 
--- PUBLIC INFORMATION  ---
--- p = prime
--- pval = Sequential key of primes used to calculate Public Key values {2,...,19} for 8 bit
--- pubk = Public Key, solved using (pval) * (binary of Integer)
--- cipher = Encrypted Message
--------------------------------------------------------------------------------------------------------
local pval = {2,3,5,7,11,13,17,19}

local function secretkey(p)
    local s = math.random(0, p-1)
    while mth.itemgcd(p-1, s) ~= 1 do
        s = (s + 1) % p
    end
    return s
end

local function publickey(p,s)
    local temp = {}
    local _, x, y = mth.ext_gcd(s, p-1) -- Calculate X and Y from Euclids to do modular exponentiation and sq root
    --print("Coefficients x and y:", x, y)
    for i = 1, #pval do
        if x < 0 then
            x = x + (p-1) -- If X is negative, add modulus to calculate its positive reciprocal
        end
        temp[i] = mth.mod_exp(pval[i],x,p) -- Modular Exponentiation to generate the public key
    end
    return temp
end

local function encrypt(mess,pubk,p)
    local binaryArray = {} -- Generate the Binary representation of message key
    for i = 1, #mess do
        binaryArray[i] = mth.intToBinArr(mess[i])
    end

    local cipher = {} -- Take Binary Key and Multiply by Prime Key
    for i = 1,#mess do
        local c = 1
        for j = 1,#pubk do
            c = (c * mth.mod_exp(pubk[j],binaryArray[i][j],p)) % p
        end
        cipher[i] = c
    end
    return cipher
end

--- LaTex of Wikipedia Entry
--- m=\sum _{i=0}^{n}{\frac {2^{i}}{p_{i}-1}}\times \left(\gcd(p_{i},c^{s}\pmod p)-1\right)
local function decrypt(cipher,p,s)
    local decipher = {}
    for i = 1,#cipher do
        local val = 0
        for j = 1,#pval do -- Summation (2^j-1 mod p * invmod p_i - 1) * (GCD(p_i,c^s mod p) - 1). 
            val = (val + ( (mth.mod_exp(2,j-1,p) * (mth.invmod((pval[j]-1),p)) )) * ((mth.itemgcd(pval[j],mth.mod_exp(cipher[i],s,p))-1))) % p
        end -- Lua indexing starting at 1, subtract j-1 from first equation for Summation.
        decipher[i] = val
    end
    return decipher
end

-- Libraryless Table Dump
local function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .." ".. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
  end

return { secretkey = secretkey, publickey = publickey, encrypt = encrypt, decrypt = decrypt, dump = dump}