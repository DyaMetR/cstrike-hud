# Counter-Strike: Source HUD
This addon for Garry's Mod attempts to replicate the Heads Up Display feature from the 2004 game Counter-Strike: Source.

## Features
+   Health indicator
+   Armor indicator
+   Ammunition indicator
+   Damage effect
+   Death overlay
+   Item pickup history
+   Money indicator
+   Time indicator
+   Custom killfeed

## Customization includes
+   Toggle each feature separately
+   Element colouring
+   Presets support
+   Selectable outputs for supported elements

## Let's get down to business: Custom content
First of all it's _highly recommended_ to use the built-in **add-ons** folder that comes with the addon. This is because the script will load any files inside that folder just after loading the HUD resources so no errors will appear.

To do this, you've got to put your custom scripts in the folder:

`lua/autorun/csshud/add-ons`

Inside your own addon folder, or just directly into the garrysmod folder, but it's recommended to separate your scripts in addons.

### Ammunition icons
You can add a certain icon for an ammo type, so the default one doesn't load.

`CSSHUD:AddAmmoIcon(ammoType, font, character);`
> ammoType: The name of the ammunition type (e.g. Pistol, SMG1, etc.)
>
> font: A font for the icon. (e.g. default, HUDNumbers, etc.)
>
> character: The character in the font representating the icon.

### Weapon icons
If you don't want the SWEP icon to show, you can add a custom one instead.

`CSSHUD:AddWeaponIcon(weaponClass, font, character);`
> weaponClass: The class of the weapon. (e.g. weapon_pistol)
>
> font: A font for the icon. (e.g. default, HUDNumbers, etc.)
>
> character: The character in the font representating the icon.

### Item icons
This is probably not going to be used too much, but still.

`CSSHUD:AddItemIcon(itemClass, font, character);`
> itemClass: The class of the item. (e.g. item_healthkit)
>
> font: A font for the icon. (e.g. default, HUDNumbers, etc.)
>
> character: The character in the font representating the icon.

### Gamemode override
This allows gamemodes to load specific behaviours on some HUD elements.

Right now the elements supported are:
+   Money indicator (`"money"`)
+   Time indicator (`"time"`)

`CSSHUD:AddOverride(element, gamemode, function);`
> element: The HUD element to override.
>
> gamemode: The gamemode id.
>
> function: A function that **must return a value**.

### Element behaviour variants
This allows multiple behaviours for some HUD elements.

Right now the elements supported are:
+   Money indicator (`"money"`)
+   Time indicator (`"time"`)

`CSSHUD:AddVariant(element, name, function);`
> element: The HUD element to override.
>
> name: The name of the variant (displayed on the selection list).
>
> function: A function that **must return a value**.

### HUD elements
At last but not least: Adding elements that will show only if the HUD is enabled.

`CSSHUD:AddDrawElement(function);`
> function: The function itself. It'll get called when displaying the HUD.
