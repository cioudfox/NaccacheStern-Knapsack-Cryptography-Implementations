local oldreq = require
local require = function(s) return oldreq('Naccache_Stern_Lua.Naccache-Stern-Knapsack-Cryptography-Lua.functions.' .. s) end
local NSK = require("NSKalgo")
local dicts = require("dictionary")

local p = 74207281  -- Select some Mersennes Prime/Perfect Prime Value
--------------------------------------------------------------------------------------------------------
--- Generate the Secret Key
--------------------------------------------------------------------------------------------------------
local s = NSK.secretkey(p)
print("Generated SECRET KEY ", s)

--------------------------------------------------------------------------------------------------------
--- Generate the Public Key
--------------------------------------------------------------------------------------------------------
local pubk = NSK.publickey(p,s)
print("Public Key Table: " .. NSK.dump(pubk) .. "\n")

--------------------------------------------------------------------------------------------------------
--- Encrypting the Message
--------------------------------------------------------------------------------------------------------
print("Enter message to encrypt:")
local input = io.read()  print("\n")
local mess = dicts.asctodec(input) --Translate message to decimal form

-- Create the Encrypted Message (Cipher)
local cipher = NSK.encrypt(mess, pubk, p)

-- Cipher difficult to solve by knapsack problem 
print("Cipher Message: " .. NSK.dump(cipher) .. "\n")

--------------------------------------------------------------------------------------------------------
--- Decrypting the Message
--------------------------------------------------------------------------------------------------------
print("Enter Secret Key to decrypt:")
local seckey = tonumber(io.read())
local decryptmess = dicts.dectoasc(NSK.decrypt(cipher,p,seckey))
print("Decrypted Message: " .. decryptmess)  print("\n")--Ascii form
