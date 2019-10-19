--[[
  DEATH SCREEN
]]

if CLIENT then

  --[[
    Draws the death overlay
    @void
  ]]
  function CSSHUD:DeathPanel()
    if (not CSSHUD:IsDeathOverlayEnabled()) then return end;
    if (LocalPlayer():Alive()) then return end;
    local h = ScrH() * 0.107;
    local x1, x2 = ScrW() * 0.8798, ScrW() * 0.8597;
    local y1, y2 = ScrH() * 0.034, ScrH() * 0.06;
    local background = Color(0, 0, 0, 200);
    local COLOR = CSSHUD:GetDeathOverlayColor();

    -- Draw bars
    draw.RoundedBox(0, 0, 0, ScrW() , h, background);
    draw.RoundedBox(0, 0, ScrH() - h, ScrW() , h, background);

    -- Draw text
    draw.SimpleText("Ping:   "..LocalPlayer():Ping(), "csshud_tahoma_small", x2, y1, COLOR, 2);
    draw.SimpleText("Deaths:   "..LocalPlayer():Deaths(), "csshud_tahoma_small", x2, y2, COLOR, 2);
    draw.SimpleText("$"..CSSHUD:GetOverride("money") or CSSHUD:GetMoney(), "csshud_tahoma_small", x1, y1, COLOR);

    draw.SimpleText("e", "csshud_icon_small", ScrW() * 0.878, ScrH() * 0.046, COLOR);
    draw.SimpleText(CSSHUD:GetOverride("time") or CSSHUD:GetTime(), "csshud_tahoma_small", ScrW() * 0.899, ScrH() * 0.061, COLOR);

  end

end
