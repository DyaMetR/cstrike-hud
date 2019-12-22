--[[
  AMMUNITION ICONS
]]

if CLIENT then

  -- Parameters
  CSSHUD.AmmoIconOffset = {
    ["csshud_ammo_hl2"] = 0.46,
    ["csshud_ammo_hl2mp"] = 0.9
  };

  -- Database
  CSSHUD.AmmoIcons = {};

  --[[
    Adds an ammo icon to the database
    @param {string} ammoType
    @param {string} font
    @param {string} letter
    @void
  ]]
  function CSSHUD:AddAmmoIcon(ammoType, font, letter, x)
    self.AmmoIcons[ammoType] = {font = font, letter = letter, x = x or 1};
  end

  --[[
    Returns an ammo icon's data
    @param {string} ammoType
    @return {table} iconData
  ]]
  function CSSHUD:GetAmmoIcon(ammoType)
    if (self.AmmoIcons[ammoType] == nil) then return self:GetDefaultAmmoIcon() end;
    return self.AmmoIcons[ammoType];
  end

  --[[
    Returns the default ammo icon
    @return {table} ammoData
  ]]
  function CSSHUD:GetDefaultAmmoIcon()
    return {font = "csshud_ammo_hl2", letter = "p", x = 1};
  end

  --[[
    Returns, based on font, the offset of the icon
    @param {string} font
    @return {number} offset
  ]]
  function CSSHUD:GetAmmoIconOffset(font)
    return self.AmmoIconOffset[font] or 1;
  end

end
