--[[
License (DO NOT REMOVE):

zlib License

(C) 2025

This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribut
ion.
]]

-- AI generated functions start here
local function numToBinary(n, bits)
  bits = bits or 8
  local t = {}
  for i = bits - 1, 0, -1 do
    t[#t + 1] = math.floor(n / 2^i) % 2
  end
  return table.concat(t)
end

--- Write a bit-string (of '0'/'1') to file with a 3-bit padding header.
--  First 3 bits = number of padding zeros (0–7) appended at the end.
-- @param bitString  string of '0'/'1'
-- @param path       output filepath
local function writeBitStringToFile(bitString, path)
    -- calculate padding (to next multiple of 8)
    local pad = (8 - (#bitString % 8)) % 8
    -- build 3-bit header
    local headerBits = string.format("%03b", pad)
    -- full stream = header + data + pad zeros
    local fullBits = headerBits .. bitString .. string.rep("0", pad)

    local file = playdate.file.open(path, playdate.file.kFileWrite)
    assert(file, "Failed to open file for write: "..path)

    -- write in 8-bit chunks
    while #fullBits >= 8 do
        local byteBits = fullBits:sub(1,8)
        local byteVal  = tonumber(byteBits, 2)
        file:write(string.char(byteVal))
        fullBits = fullBits:sub(9)
    end

    file:close()
end

--- Read a file written by the above and return the original bit-string.
--  It reads the first 3 bits (padding count), then strips that many zeros off the end.
-- @param path  input filepath
-- @return      bitString (original '0'/'1' sequence)
local function readBitStringFromFile(path)
    local file = playdate.file.open(path, playdate.file.kFileRead)
    assert(file, "Failed to open file for read: "..path)

    local raw = file:read(file:getSize())
    file:close()

    -- convert all bytes to a long '0'/'1' string
    local bits = {}
    for i = 1, #raw do
        local b = raw:byte(i)
        for shift = 7,0,-1 do
            bits[#bits+1] = ((b >> shift) & 1) == 1 and '1' or '0'
        end
    end
    local allBits = table.concat(bits)

    -- extract header
    local padCount = tonumber(allBits:sub(1,3), 2)
    -- strip header and trailing padding
    local dataBits = allBits:sub(4, #allBits - padCount)

    return dataBits
end
-- AI generated functions end here