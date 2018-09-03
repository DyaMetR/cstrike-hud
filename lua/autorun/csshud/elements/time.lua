--[[
  TIME INDICATOR
]]

if CLIENT then

  -- Parameters
  local TIME_WIDTH = 1.285;

  --[[
    Draws the time indicator
    @param {number} x
    @param {number} y
    @param {string} value
    @void
  ]]
  function CSSHUD:DrawTime(x, y, value, w)
    w = w or TIME_WIDTH;
    self:DrawBaseElement(x, y, "e", value, w, CSSHUD:GetTimeColor());
  end

  --[[
    Draws time indicator with default settings
    @void
  ]]
  function CSSHUD:TimePanel()
    if (not CSSHUD:IsTimeEnabled()) then return end;
    if (not LocalPlayer():Alive()) then return end;
    local x, y = CSSHUD:GetDefaultScreenOffset();
    local value = CSSHUD:GetOverride("time") or CSSHUD:GetTime();

    CSSHUD:DrawTime((ScrW()/2) - (CSSHUD:GetWidth()/2) * (TIME_WIDTH/2), ScrH() - y, value, w);
  end

end
