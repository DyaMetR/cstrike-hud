--[[
  DAMAGE INDICATOR
]]

if CLIENT then

  -- ENUMS
  local UP = 0;
  local DOWN = 1;
  local LEFT = 2;
  local RIGHT = 3;

  -- Parameters
  local FREQ = 0.035;
  local ALPHA = 255;
  local W, H = 128, 64;
  local WR, HR = 119, 40;
  local SEPARATOR = 123;

  -- Variables
  local damage = {
    [UP] = {alpha = 0, think = 0, w = W, h = H, texture = surface.GetTextureID("csshud/pain_0")},
    [DOWN] = {alpha = 0, think = 0, w = W, h = H, texture = surface.GetTextureID("csshud/pain_2")},
    [LEFT] = {alpha = 0, think = 0, w = H, h = W, texture = surface.GetTextureID("csshud/pain_3")},
    [RIGHT] = {alpha = 0, think = 0, w = H, h = W, texture = surface.GetTextureID("csshud/pain_1")}
  };

  -- Methods
  --[[
    Animates each damage indicator
    @void
  ]]
  local function Animation()
    for _, sprite in pairs(damage) do
      if (sprite.alpha - FREQ > 0) then
        if (sprite.think < CurTime()) then
          sprite.alpha = sprite.alpha - FREQ;
          sprite.think = CurTime() + 0.01;
        end
      else
        if (sprite.alpha ~= 0) then
          sprite.alpha = 0;
        end
      end
    end
  end

  --[[
    Returns the alpha amount of a damage indicator
    @param {number} enum
    @return {number} alpha
  ]]
  local function GetIndicatorAlpha(enum)
    if (damage[enum] == nil) then return 0 end;
    return damage[enum].alpha;
  end

  --[[
    Returns the indicator scale
    @return {number} scale
  ]]
  local function GetScale()
    --return ScrW() / 1024;
    return 1;
  end

  --[[
    Draws an indicator on screen
  ]]
  local function DrawIndicator(x, y, enum)
    local w, h = damage[enum].w * GetScale(), damage[enum].h * GetScale();
    local wr, hr = 0, 0;
    if (damage[enum].w == W) then wr = WR * GetScale() else wr = HR * GetScale() end;
    if (damage[enum].h == H) then hr = HR * GetScale() else hr = WR * GetScale() end;

    surface.SetTexture(damage[enum].texture);
    surface.SetDrawColor(Color(255, 255, 255, 255 * math.ceil(damage[enum].alpha)));
    --surface.SetDrawColor(Color(255, 255, 255, 255));
    surface.DrawTexturedRect(x - (wr/2), y - (hr/2), w, h);
  end

  --[[
    Draws the damage indicators
    @void
  ]]
  function CSSHUD:DamagePanel()
    if (not CSSHUD:IsDamageIndicatorEnabled()) then return; end;
    Animation();
    DrawIndicator(ScrW()/2, (ScrH()/2) - SEPARATOR * GetScale(), UP);
    DrawIndicator(ScrW()/2, (ScrH()/2) + SEPARATOR * GetScale(), DOWN);
    DrawIndicator((ScrW()/2) - SEPARATOR * GetScale(), ScrH()/2, LEFT);
    DrawIndicator((ScrW()/2) + SEPARATOR * GetScale(), ScrH()/2, RIGHT);
  end

  --[[
    Triggers a damage indicator
    @param {number} enum
    @void
  ]]
  local function IndicateDamage(enum)
    if (damage[enum] == nil) then return false end;
    damage[enum].alpha = 1;
  end

  net.Receive("csshud_damage", function(len)
    local enums = net.ReadTable();
    for _, enum in pairs(enums) do
      IndicateDamage(enum);
    end
  end);

end
