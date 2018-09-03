--[[
  AMMUNITION PANEL
]]

if CLIENT then

  -- Parameters
  local AMMO_SEPARATOR_Y = 0.804;
  local AMMO_SEPARATOR_X = 0.375;
  local AMMO_SEPARATOR_W = 0.025;
  local AMMO_CLIP_X = 0.325;
  local AMMO_RESERVE_X = 0.715;
  local AMMO_ICON_X = 0.954;
  local AMMO_ICON_Y = 0.93;
  local TEXTURE = surface.GetTextureID("csshud/white_additive");

  --[[
    Draws the clip indicator
    @param {number} x
    @param {number} y
    @param {number} clip1
    @param {number} reserve
    @void
  ]]
  function CSSHUD:DrawClip(x, y, clip1, reserve)
    local COLOR = self:GetAmmoColor();
    local mul = 1.77;
    x = x - self:GetWidth() * mul;
    y = y - self:GetHeight();
    self:DrawBackground(x, y, mul);

    local width = mul * self:GetWidth();
    local separatorHeight = self:GetHeight() * AMMO_SEPARATOR_Y;
    draw.SimpleText(clip1, "csshud", x + AMMO_CLIP_X * width, y + self:GetHeight() * self.Y_OFFSET, COLOR, 2, 1);

    -- Separator
    surface.SetTexture(TEXTURE);
    surface.SetDrawColor(COLOR);
    surface.DrawTexturedRect(x + self:GetWidth() * mul * AMMO_SEPARATOR_X, y + (self:GetHeight() - separatorHeight) * 0.5, self:GetWidth() * AMMO_SEPARATOR_W, separatorHeight);

    -- Reserve ammo
    draw.SimpleText(reserve, "csshud", x + AMMO_RESERVE_X * width, y + self:GetHeight() * self.Y_OFFSET, COLOR, 2, 1);
    local ammoIcon = self:GetAmmoIcon(game.GetAmmoName(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()));
    draw.SimpleText(ammoIcon.letter, ammoIcon.font, x + AMMO_ICON_X * width * ammoIcon.x, y + self:GetHeight() * AMMO_ICON_Y * self:GetAmmoIconOffset(ammoIcon.font), COLOR, 2, 1);
  end

  --[[
    Draws the reserve ammo indicator
    @param {number} x
    @param {number} y
    @param {number} reserve
    @void
  ]]
  function CSSHUD:DrawReserveAmmo(x, y, reserve)
    local COLOR = self:GetAmmoColor();
    local mul = 1.1;
    x = x - self:GetWidth() * mul;
    y = y - self:GetHeight();
    local width = self:GetWidth() * mul;
    self:DrawBackground(x, y, mul);
    draw.SimpleText(reserve, "csshud", x + 0.54 * width, y + self:GetHeight() * self.Y_OFFSET, COLOR, 2, 1);
    local ammoIcon = self:GetAmmoIcon(game.GetAmmoName(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()));
    draw.SimpleText(ammoIcon.letter, ammoIcon.font, x + 0.925 * width * ammoIcon.x, y + self:GetHeight() * AMMO_ICON_Y * self:GetAmmoIconOffset(ammoIcon.font), COLOR, 2, 1);
  end

  --[[
    Draws the primary ammo panel
    @param {number} x
    @param {number} y
    @void
  ]]
  function CSSHUD:DrawPrimaryAmmo(x, y)
    local weapon = LocalPlayer():GetActiveWeapon();
    local primary = weapon:GetPrimaryAmmoType();
    local reserve = LocalPlayer():GetAmmoCount(primary);
    if (primary <= 0) then return end;
    if (weapon:Clip1() > -1) then
        self:DrawClip(x, y, weapon:Clip1(), reserve);
    else
        self:DrawReserveAmmo(x, y, reserve);
    end
  end

  --[[
    Draws the secondary ammo panel
    @param {number} x
    @param {number} y
    @void
  ]]
  function CSSHUD:DrawSecondaryAmmo(x, y)
    local COLOR = self:GetAmmoColor();
    local weapon = LocalPlayer():GetActiveWeapon();
    local secondary = weapon:GetSecondaryAmmoType();
    if (secondary <= 0) then return end;
    local alt = LocalPlayer():GetAmmoCount(secondary);
    local mul = 0.9;
    x = x - self:GetWidth() * mul;
    y = y - self:GetHeight();
    self:DrawBackground(x, y, mul);

    local width = mul * self:GetWidth();
    draw.SimpleText(alt, "csshud", x + 0.44 * width, y + self:GetHeight() * self.Y_OFFSET, COLOR, 2, 1);
    local ammoIcon = self:GetAmmoIcon(game.GetAmmoName(LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType()));
    draw.SimpleText(ammoIcon.letter, ammoIcon.font, x + 0.91 * width * ammoIcon.x, y + self:GetHeight() * AMMO_ICON_Y * self:GetAmmoIconOffset(ammoIcon.font), COLOR, 2, 1);
  end

  --[[
    Draws the ammo panel
    @param {number} x
    @param {number} y
    @void
  ]]
  function CSSHUD:DrawAmmo(x, y)
    if (not IsValid(LocalPlayer():GetActiveWeapon())) then return end;
    local hasPrimary = 1;
    if (LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() < 0) then hasPrimary = 0 end;
    self:DrawPrimaryAmmo(x, y);
    self:DrawSecondaryAmmo(x - (self:GetWidth() * 1.85) * hasPrimary, y);
  end

  --[[
    Draws the ammo panel on its default position
    @void
  ]]
  function CSSHUD:AmmoPanel()
    if (not CSSHUD:IsAmmoEnabled()) then return end;
    if (not LocalPlayer():Alive()) then return end;
    local x, y = CSSHUD:GetDefaultScreenOffset();
    CSSHUD:DrawAmmo(ScrW() - x, ScrH() - y);
  end

end
