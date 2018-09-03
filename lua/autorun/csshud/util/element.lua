--[[
  BASE FOR HUD ELEMENTS
]]

if CLIENT then

  -- Parameters
  local SCALE_W, SCALE_H = 0.10390625, 0.05125;
  local BACKGROUND = Color(0, 0, 0, 90);
  local ICON_X = 0.1067;
  CSSHUD.NUMBER_X = 0.9181;
  CSSHUD.Y_OFFSET = 0.3921;

  --[[
    Returns the width of the base element
    @return {number} width
  ]]
  function CSSHUD:GetWidth()
      return ScrW() * SCALE_W;
  end

  --[[
    Returns the height of the base element
    @return {number} height
  ]]
  function CSSHUD:GetHeight()
      return ScrH() * SCALE_H;
  end

  --[[
    Draws a background
    @param {number} x
    @param {number} y
    @param {number} width_multiplier
  ]]
  function CSSHUD:DrawBackground(x, y, mul)
      mul = mul or 1;
      local w, h = self:GetWidth(), self:GetHeight();
      draw.RoundedBox(8, x, y, w * mul, h, self:GetBackgroundColor() or BACKGROUND);
  end

  --[[
    Draws a base element
    @param {number} x
    @param {number} y
    @param {string} icon
    @param {string|number} value
    @param {number} width_multiplier
    @param {Color} color
  ]]
  function CSSHUD:DrawBaseElement(x, y, ico, value, w, col)
      col = col or self:GetDefaultColor();
      w = w or 1;
      y = y - self:GetHeight();
      self:DrawBackground(x, y, w);
      draw.SimpleText(ico, "csshud", x + ICON_X * self:GetWidth(), y + self:GetHeight() * self.Y_OFFSET, col, 0, 1);
      draw.SimpleText(value, "csshud", x + self.NUMBER_X * self:GetWidth() * w, y + self:GetHeight() * self.Y_OFFSET, col, 2, 1);
  end

end
