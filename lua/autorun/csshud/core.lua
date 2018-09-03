--[[
  CORE
]]

if CLIENT then
  -- Hide default HUD
  local hide = {
  	CHudHealth = true,
  	CHudBattery = true,
    CHudDamageIndicator = true,
    CHudAmmo = true,
    CHudSecondaryAmmo = true,
    CHudHistoryResource = true
  }

  hook.Add( "HUDShouldDraw", "csshud_hide_default_hud", function( name )
    hide.CHudHealth = CSSHUD:IsHealthEnabled();
    hide.CHudBattery = CSSHUD:IsArmorEnabled();
    hide.CHudDamageIndicator = CSSHUD:IsDamageIndicatorEnabled();
    hide.CHudAmmo = CSSHUD:IsAmmoEnabled();
    hide.CHudSecondaryAmmo = CSSHUD:IsAmmoEnabled();
    hide.CHudHistoryResource = CSSHUD:IsPickupEnabled();
  	if ( hide[ name ] and CSSHUD:IsEnabled() ) then return false end;
  end );
end

-- Configuration
CSSHUD:IncludeFile("config/config.lua");
CSSHUD:IncludeFile("config/convars.lua");
CSSHUD:IncludeFile("config/variant.lua");
CSSHUD:IncludeFile("config/menu.lua");
CSSHUD:IncludeFile("config/gamemode.lua");
CSSHUD:IncludeFile("config/presets.lua");

-- Util
CSSHUD:IncludeFile("util/fonts.lua");
CSSHUD:IncludeFile("util/element.lua");
CSSHUD:IncludeFile("util/queue.lua");
CSSHUD:IncludeFile("util/damage.lua");
CSSHUD:IncludeFile("util/ammo.lua");
CSSHUD:IncludeFile("util/weapon.lua");
CSSHUD:IncludeFile("util/items.lua");
CSSHUD:IncludeFile("util/pickup.lua");
CSSHUD:IncludeFile("util/killfeed.lua");

-- Elements
CSSHUD:IncludeFile("elements/health.lua");
CSSHUD:IncludeFile("elements/ammunition.lua");
CSSHUD:IncludeFile("elements/time.lua");
CSSHUD:IncludeFile("elements/money.lua");
CSSHUD:IncludeFile("elements/death.lua");
CSSHUD:IncludeFile("elements/damage.lua");
CSSHUD:IncludeFile("elements/pickup.lua");
CSSHUD:IncludeFile("elements/killfeed.lua");

-- Data
CSSHUD:IncludeFile("data/elements.lua");
CSSHUD:IncludeFile("data/ammo.lua");
CSSHUD:IncludeFile("data/weapons.lua");
CSSHUD:IncludeFile("data/item.lua");
CSSHUD:IncludeFile("data/variants.lua");
CSSHUD:IncludeFile("data/gamemode.lua");

-- Load add-ons
local files, directories = file.Find("autorun/csshud/add-ons/*.lua", "LUA");
for _, file in pairs(files) do
  CSSHUD:IncludeFile("add-ons/"..file);
end

-- Load presets
if CLIENT then
  CSSHUD:LoadPresets();
end
