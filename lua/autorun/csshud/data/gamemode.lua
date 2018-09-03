--[[
  GAMEMODE VARIATIONS IN IMPLEMENTATION
]]

if CLIENT then

  -- Sandbox
  CSSHUD:AddOverride("money", "sandbox", function() return math.Clamp(CSSHUD:GetVariant("money", CSSHUD:GetMoneyVariant()).value() * CSSHUD:GetMoneyMultiplier(), 0, CSSHUD:GetMaxMoney()); end);
  CSSHUD:AddOverride("time", "sandbox", function() return CSSHUD:GetVariant("time", CSSHUD:GetTimeVariant()).value(); end);

  -- Dark RP
  CSSHUD:AddOverride("money", "darkrp", function() return LocalPlayer():getDarkRPVar("money") or 0; end);

end
