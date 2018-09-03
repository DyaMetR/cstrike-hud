--[[
  ITEM PICKUP ICONS
]]

if CLIENT then

  -- Database
  CSSHUD.ItemIcons = {};

  --[[
    Adds an item icon to the database
    @param {string} item
    @param {string} font
    @param {string} letter
    @void
  ]]
  function CSSHUD:AddItemIcon(item, font, letter)
    self.ItemIcons[item] = {font = font, letter = letter};
  end

  --[[
    Returns an item icon's data
    @param {string} item
    @return {table} iconData
  ]]
  function CSSHUD:GetItemIcon(item)
    if (self.ItemIcons[item] == nil) then return self:GetDefaultAmmoIcon() end;
    return self.ItemIcons[item];
  end

  --[[
    Returns the default item icon
    @return {table} iconData
  ]]
  function CSSHUD:GetDefaultItemIcon()
    return {font = "csshud_weapon_hl2", letter = "¡"};
  end

end
