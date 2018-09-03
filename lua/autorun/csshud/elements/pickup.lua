--[[
  PICKUP HISTORY
]]

if CLIENT then

  --[[
    Draws the pickup history
    @param {number} x
    @param {number} y
    @void
  ]]
  function CSSHUD:DrawPickupHistory(x, y)
    local history = self:GetPickupHistory();
    for _, pickup in pairs(history) do
      self:DrawPickup(x, y - (ScreenScale(50) * pickup.count), pickup);
    end
  end

  --[[
    Draws the pickup history with default settings
    @void
  ]]
  function CSSHUD:PickupPanel()
    if (not CSSHUD:IsPickupEnabled()) then return end;
    CSSHUD:DrawPickupHistory(ScrW() - 30, ScrH() - (CSSHUD:GetHeight() * 5));
  end

end
