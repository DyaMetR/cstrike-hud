--[[
  CONFIGURATION
]]

if CLIENT then

  --[[
    Returns the CSS default background color
    @return {Color} color
  ]]
  function CSSHUD:GetDefaultBackgroundColor()
    return Color(0, 0, 0, 90);
  end

  --[[
    Returns the CSS default HUD color
    @return {Color} color
  ]]
  function CSSHUD:GetDefaultColor()
    return Color(188, 126, 0, 200);
  end

  --[[
    Returns the CSS default critical health HUD color
    @return {Color} color
  ]]
  function CSSHUD:GetDefaultCritColor()
    return Color(192, 28, 0, 140);
  end

  --[[
    Returns the CSS default pickup history icons color
    @return {Color} color
  ]]
  function CSSHUD:GetDefaultPickupColor()
    return Color(255, 200, 0, 255);
  end

  --[[
    Returns the default screen offset
    @return {number} x
    @return {number} y
  ]]
  function CSSHUD:GetDefaultScreenOffset()
    local X_OFFSET = 0.012;
    local Y_OFFSET = 0.02;
    return ScrW() * X_OFFSET, ScrH() * Y_OFFSET;
  end

  --[[
    Returns what is shown on the money indicator
    @void
  ]]
  function CSSHUD:GetMoney()
    return math.Clamp(LocalPlayer():Frags() * 300, 0, 16000);
  end

  --[[
    Returns what is shown on the time indicator
    @void
  ]]
  function CSSHUD:GetTime()
    return os.date("%H:%M", os.time());
  end

end
