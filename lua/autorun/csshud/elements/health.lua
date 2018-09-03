--[[
  HEALTH AND ARMOR METERS
]]

if CLIENT then

  -- Parameters
  local ARMOR_X = 0.1819;
  local FLASH_DAMAGE = 0.14;
  local FLASH_CRITICAL = 0.043;
  local FLASH_COUNT = 5;
  local ARMOR_VEST_ICON = "a";
  local ARMOR_HELMET_ICON = "l";
  local HEALTH_ICON = "b";

  -- Variables
  local count = FLASH_COUNT;
  local flash = 0;
  local tick = 0;
  local flashed = false;
  local lastHp = 100;

  local function doAnimation()
    local speed = FLASH_DAMAGE;
    local hp = LocalPlayer():Health();

    -- Trigger animation
    if (hp <= 25) then
      speed = FLASH_CRITICAL;
      lastHp = hp;
    else
      if (lastHp != hp) then
        if (lastHp > hp) then
          count = 0;
        end
        lastHp = hp;
      end
    end

    -- Do animation
    if (count < FLASH_COUNT or hp <= 25 or (hp > 25 and flash > 0)) then
      if (tick < CurTime()) then
        if (flashed) then
          if (flash > 0) then
            flash = math.Clamp(flash - speed, 0, 1);
          else
            count = count + 1;
            flashed = false;
          end
        else
          if (flash < 1) then
            flash = math.Clamp(flash + speed, 0, 1);
          else
            flashed = true;
          end
        end
        tick = CurTime() + 0.01;
      end
    end
  end

  -- Returns the armor icon
  local function getArmorIcon()
    if (LocalPlayer():Armor() <= CSSHUD:GetArmorAmountForHelmet()) then
      return ARMOR_VEST_ICON;
    else
      return ARMOR_HELMET_ICON;
    end
  end

  -- Returns the color based on flash amount
  local function getColorAmount(i)
    local COLOR = CSSHUD:GetHealthColor();
    local CRIT = CSSHUD:GetHealthCritColor();
    return (CRIT[i] * flash) + (COLOR[i] * (1-flash));
  end

  --[[
    Draws the health panel
    @param {number} x
    @param {number} y
    @void
  ]]
  function CSSHUD:DrawHealth(x, y)
    local hpColor = Color(getColorAmount("r"), getColorAmount("g"), getColorAmount("b"), getColorAmount("a"));
    doAnimation();

    if (self:IsHealthEnabled()) then
      self:DrawBaseElement(x, y, HEALTH_ICON, math.Clamp(LocalPlayer():Health(), 0, LocalPlayer():Health()), 1, hpColor);
    end

    if (self:IsArmorEnabled()) then
      self:DrawBaseElement(x + ScrW() * ARMOR_X, y, getArmorIcon(), LocalPlayer():Armor(), 1, self:GetArmorColor());
    end
  end

  --[[
    Draws the health panel on default position
    @void
  ]]
  function CSSHUD:HealthPanel()
    if (not CSSHUD:IsHealthEnabled() and not CSSHUD:IsArmorEnabled()) then return end;
    if (not LocalPlayer():Alive()) then return end;
    local x, y = CSSHUD:GetDefaultScreenOffset();
    CSSHUD:DrawHealth(x, ScrH() - y);
  end

end
