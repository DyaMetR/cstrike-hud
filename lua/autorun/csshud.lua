--[[
  Counter-Strike: Source
     Heads Up Display
      Version 1.0.3
        19/10/19
By DyaMetR
]]

-- Main framework table
CSSHUD = {};

-- Version number
CSSHUD.Version = "1.0.3";

--[[
  METHODS
]]

--[[
  Correctly includes a file
  @param {string} file
  @void
]]--
function CSSHUD:IncludeFile(file)
  if SERVER then
    include(file);
    AddCSLuaFile(file);
  end
  if CLIENT then
    include(file);
  end
end

--[[
  INCLUDES
]]
CSSHUD:IncludeFile("csshud/core.lua");
