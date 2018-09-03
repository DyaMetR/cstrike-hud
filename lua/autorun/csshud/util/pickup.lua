--[[
  PICKUP HISTORY
]]

if CLIENT then

  -- Parameters
  local AMMO = "ammo";
  local WEAPON = "weapon";
  local ITEM = "item";
  local FREQ = 0.02; -- How fast does the icons fade out
  local TIME = 3; -- How much time it takes for the icons to start fading out
  local XOFFSET = 10; -- How far is the HUD element from the screen X axis
  local YOFFSET = 130; -- How far is the HUD element from the screen Y axis
  local SEPARATION = 5; -- How separated are each icon
  local AMMO_OFFSET = 20; -- How extra separated is the ammo pickup icon

  -- Variables
  local count = 0;
  local history = {};
  local think = 0;

  local function GetMaxItems()
    return ScrH() / ScreenScale(82);
  end

  --[[
    Runs the history pickup fade out animation
    @void
  ]]
  local function doAnimation()
    if table.Count(history) > 0 and think < CurTime() then
      for k, entry in pairs(history) do
        if (entry.time < CurTime()) then
          if (entry.alpha - FREQ > 0) then
            entry.alpha = entry.alpha - 0.01;
          else
            entry.alpha = 0;
            table.remove(history, k);
          end
        end
      end
      think = CurTime() + FREQ;
    else
      if #history <= 0 and count > 0 then
        count = 0;
      end
    end
  end

  --[[
    Adds an entry to the pickup history
  ]]
  local function AddPickupHistory(category, itemName, amount)
    amount = amount or 0;
    table.insert(history, {count = count, category = category, itemName = itemName, amount = amount, alpha = 1, time = CurTime() + TIME});
    if (count > GetMaxItems()) then
      count = 0;
    else
      count = count + 1;
    end
  end

  --[[
    Returns the current pickup history
  ]]
  function CSSHUD:GetPickupHistory()
    doAnimation();
    return history;
  end

  --[[
    Draws an ammo pickup
    @param {number} x
    @param {number} y
    @param {string} ammoType
    @param {number} amount
    @param {number} alpha
    @void
  ]]
  function CSSHUD:DrawAmmoPickup(x, y, ammoType, amount, alpha)
    alpha = alpha or 1;
    local COLOR = self:GetPickupColor();
    local color = Color(COLOR.r, COLOR.g, COLOR.b, COLOR.a * alpha);
    local iconData = self:GetAmmoIcon(ammoType);
    draw.SimpleText(iconData.letter, iconData.font, x, y + ScreenScale(4.5), color, 2, 1);
    draw.SimpleText(amount, "csshud_small", x, y, color);
  end

  --[[
    Draws an item pickup
    @param {number} x
    @param {number} y
    @param {string} item
    @param {number} alpha
  ]]
  function CSSHUD:DrawItemPickup(x, y, item, alpha)
    alpha = alpha or 1;
    local COLOR = self:GetPickupColor();
    local color = Color(COLOR.r, COLOR.g, COLOR.b, COLOR.a * alpha);
    local iconData = self:GetItemIcon(item);
    draw.SimpleText(iconData.letter, iconData.font, x, y, color, 2, 1);
  end

  --[[
    Selects and draws the corresponding pickup icon
    @param {number} x
    @param {number} y
    @param {table} pickup
  ]]
  function CSSHUD:DrawPickup(x, y, pickup)
    if (pickup.category == AMMO) then
      self:DrawAmmoPickup(x - AMMO_OFFSET, y, pickup.itemName, pickup.amount, pickup.alpha);
    elseif (pickup.category == WEAPON) then
      self:DrawWeaponIcon(pickup.itemName, x, y, pickup.alpha);
    elseif (pickup.category == ITEM) then
      self:DrawItemPickup(x, y, pickup.itemName, pickup.alpha);
    end
  end

  --[[
    Adds an ammo icon to the item pickup history
    @void
  ]]
  local function AddAmmoIcon(itemName, amount)
    AddPickupHistory(AMMO, itemName, amount);
  end

  --[[
    Adds a weapon icon to the pickup history
    @void
  ]]
  local function AddWeaponIcon(weapon)
    AddPickupHistory(WEAPON, weapon);
  end

  --[[
    Adds a item icon to the pickup history
    @void
  ]]
  local function AddItemIcon(itemName)
    AddPickupHistory(ITEM, itemName);
  end

  --[[
   HOOKS
 ]]
 hook.Add("HUDAmmoPickedUp", "csshud_ammo_pickup", function(itemName, amount)
   if (CSSHUD:IsEnabled() and CSSHUD:IsPickupEnabled()) then
     AddAmmoIcon(itemName, amount);
     return true;
   end
 end);

 hook.Add("HUDWeaponPickedUp", "csshud_weapon_pickup", function(weapon)
   if (CSSHUD:IsEnabled() and CSSHUD:IsPickupEnabled()) then
     AddWeaponIcon(weapon);
     return true;
   end
 end);

 hook.Add("HUDItemPickedUp", "csshud_item_pickup", function(itemName)
   if (CSSHUD:IsEnabled() and CSSHUD:IsPickupEnabled()) then
     AddItemIcon(itemName);
     return true;
   end
 end);

end
