--[[
  WEAPON ICONS
]]

if CLIENT then

  -- Database
  CSSHUD.WeaponIcons = {};

  --[[
    Adds a weapon icon to display on pickup
    @param {string} weapon
    @param {string} font
    @param {string} letter
    @void
  ]]
  function CSSHUD:AddWeaponIcon(weapon, font, letter)
    self.WeaponIcons[weapon] = {font = font, letter = letter};
  end

  --[[
    Returns a weapon icon
    @param {string} weapon
    @return {table} iconData
  ]]
  function CSSHUD:GetWeaponIcon(weapon)
    return self.WeaponIcons[weapon];
  end

  --[[
    Returns whether a custom icon exists
    @param {string} weapon
    @return {boolean} exists
  ]]
  function CSSHUD:HasWeaponIcon(weapon)
    return self.WeaponIcons[weapon] ~= nil;
  end

  --[[
    Draws a weapon icon on the screen
    @param {string} weapon
    @param {string} x
    @param {string} y
  ]]
  function CSSHUD:DrawWeaponIcon(weapon, x, y, alpha)
    if not IsValid(weapon) then return end;
    alpha = alpha or 1;
    local COLOR = self:GetPickupColor();
    local scale = 0.6 * (ScrW()/1024);
    local w, h = 256 * scale, 128 * scale;
    if (self:HasWeaponIcon(weapon:GetClass())) then
      local icon = self:GetWeaponIcon(weapon:GetClass());
      draw.SimpleText(icon.letter, icon.font, x, y, Color(COLOR.r, COLOR.g, COLOR.b, COLOR.a * alpha), 2, 1);
    else
      if weapon.DrawWeaponSelection ~= nil then -- If instead of an icon, has a custom slot rendering
        local bounce = weapon.BounceWeaponIcon;
        local info = weapon.DrawWeaponInfoBox;

        weapon.BounceWeaponIcon = false;
        weapon.DrawWeaponInfoBox = false;

        weapon:DrawWeaponSelection(x - w, y - (h/2), w, h, 255 * alpha);

        weapon.DrawWeaponInfoBox = info;
        weapon.BounceWeaponIcon = bounce;
      elseif (weapon.DrawWeaponSelection == nil and weapon.WepSelectIcon ~= nil) then
        surface.SetTexture(weapon.WepSelectIcon);
        surface.SetDrawColor(Color(255, 255, 255, 255 * alpha));
        surface.DrawTexturedRect(x - w, y - (h/2), w, h);
      end
    end
  end

end
