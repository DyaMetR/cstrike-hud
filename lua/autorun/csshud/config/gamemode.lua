--[[
  GAMEMODE VALUE OVERRIDES
]]

if CLIENT then

  -- Parameters
  local DEFAULT = "sandbox";

  -- Database
  CSSHUD.GamemodeOverride = {};

  --[[
    Adds an override function for an element based on the gamemode
    @param {string} id
    @param {string} gamemode
    @param {function} func
    @void
  ]]
  function CSSHUD:AddOverride(id, gamemode, func)
    if (self.GamemodeOverride[id] == nil) then self.GamemodeOverride[id] = {}; end
    self.GamemodeOverride[id][gamemode] = func;
  end

  --[[
    Returns the value of the overriding function
    @param {string} id
    @param {string} gamemode
    @return {string|number} value
  ]]
  function CSSHUD:GetOverride(id)
    local gamemode = engine.ActiveGamemode();
    if (self.GamemodeOverride[id] == nil) then return -1; end
    if (self.GamemodeOverride[id][gamemode] == nil) then return self.GamemodeOverride[id][DEFAULT](); end
    return self.GamemodeOverride[id][gamemode]();
  end

end
