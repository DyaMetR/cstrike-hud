--[[
  KILLFEED
]]

if CLIENT then

  -- Parameters
  local H = ScrH() * 0.107;

  --[[
    Draws the kill feed
    @void
  ]]
  function CSSHUD:KillfeedPanel()
    if (not CSSHUD:IsKillfeedEnabled()) then return end;
    for k, v in pairs(CSSHUD:GetKillfeed()) do
      CSSHUD:DrawKillfeed(k, ScrW() - 40, H + 32 + ((k - 1) * 36));
    end
  end

end
