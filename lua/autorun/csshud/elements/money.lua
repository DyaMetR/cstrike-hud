--[[
  MONEY INDICATOR
]]

if CLIENT then

  -- Variables
  local lastValue = nil;
  local showLast = 0;
  local tick = 0;
  local amount = 0;

  --[[
    Does the money change animation
    @param {number} value
    @void
  ]]
  local function doAnimation(value)
    if (lastValue == nil) then lastValue = value end;
    if (lastValue != value) then
      amount = 1;
      showLast = tonumber(value) - lastValue;
      lastValue = value;
    end
    if (amount > 0 and tick < CurTime()) then
      amount = amount - 0.01;
      tick = CurTime() + 0.025;
    end
  end

  --[[
    Returns the difference indicator color
    @return {Color} color
  ]]
  local function getDifferenceColor()
    local add = CSSHUD:GetMoneyAddColor();
    local sub = CSSHUD:GetMoneySubColor();
    if (showLast > 0) then
      return Color(add.r, add.g, add.b, add.a * amount);
    else
      return Color(sub.r, sub.g, sub.b, sub.a * amount);
    end
  end

  --[[
    Draws the money indicator
    @param {number} x
    @param {number} y
    @param {number|string} value
    @void
  ]]
  function CSSHUD:DrawMoney(x, y, value)
    local COLOR = self:GetMoneyColor();
    local DIFF = getDifferenceColor();
    local color = Color((COLOR.r * (1-amount)) + (DIFF.r * amount), (COLOR.g * (1-amount)) + (DIFF.g * amount), (COLOR.b * (1-amount)), COLOR.a);
    x = x - self:GetWidth();
    y = y - self:GetHeight();
    -- Money indicator
    draw.SimpleText("$", "csshud", x - self:GetWidth() * 0.225, y + self:GetHeight() * 0.1, color, 0, 1);
    draw.SimpleText(value, "csshud", x + self:GetWidth() * self.NUMBER_X, y + self:GetHeight() * self.Y_OFFSET * 0.326, color, 2, 1);

    -- Difference indicator
    local sign = "+";
    if (showLast < 0) then sign = "-" end;
    draw.SimpleText(sign, "csshud", x - self:GetWidth() * 0.225, y + (self:GetHeight() * 0.1) - (self:GetHeight() * 0.8), DIFF, 0, 1);
    draw.SimpleText(math.abs(showLast), "csshud", x + self:GetWidth() * self.NUMBER_X, y + (self:GetHeight() * self.Y_OFFSET * 0.326) - (self:GetHeight() * 0.8), DIFF, 2, 1);

    doAnimation(value);
  end

  --[[
    Draws money indicator with default settings
    @void
  ]]
  function CSSHUD:MoneyPanel()
    if (not CSSHUD:IsMoneyEnabled()) then return end;
    if (not LocalPlayer():Alive()) then return end;
    local x, y = CSSHUD:GetDefaultScreenOffset();
    local value = CSSHUD:GetOverride("money");
    CSSHUD:DrawMoney(ScrW() - x, ScrH() - (y + CSSHUD:GetHeight()), value or CSSHUD:GetMoney());
  end

end
