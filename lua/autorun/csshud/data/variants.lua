--[[
  VARIANT FUNCTIONALITIES
]]

if CLIENT then

  local MPH = 0.056818181;
  local KPH = MPH * 1.6093;

  -- Time variants
  CSSHUD:AddVariant("time", "24H real time", function() return os.date("%H:%M", os.time()); end);
  CSSHUD:AddVariant("time", "12H real time", function() return os.date("%I:%M", os.time()); end);
  CSSHUD:AddVariant("time", "Current session", function()
    local time = CurTime();
    local h = math.floor(time/3600);
    local m = math.floor((time - (h * 3600))/60);

    if (m < 10) then m = "0"..m; end

    return h..":"..m;
  end);
  CSSHUD:AddVariant("time", "Ping", function() return LocalPlayer():Ping(); end);
  CSSHUD:AddVariant("time", "Speed (hU)", function() return math.Round(LocalPlayer():GetVelocity():Length()); end);
  CSSHUD:AddVariant("time", "Speed (KPH)", function() return math.Round(LocalPlayer():GetVelocity():Length() * KPH); end);
  CSSHUD:AddVariant("time", "Speed (MPH)", function() return math.Round(LocalPlayer():GetVelocity():Length() * MPH); end);
  CSSHUD:AddVariant("time", "User input", function() return CSSHUD:GetTimeInput(); end);

  -- Money variants
  CSSHUD:AddVariant("money", "Frags", function() return LocalPlayer():Frags(); end);
  CSSHUD:AddVariant("money", "Deaths", function() return LocalPlayer():Deaths(); end);
  CSSHUD:AddVariant("money", "Ping", function() return LocalPlayer():Ping(); end);
  CSSHUD:AddVariant("money", "Speed (hU)", function() return math.Round(LocalPlayer():GetVelocity():Length()); end);
  CSSHUD:AddVariant("money", "Speed (KPH)", function() return math.Round(LocalPlayer():GetVelocity():Length() * KPH); end);
  CSSHUD:AddVariant("money", "Speed (MPH)", function() return math.Round(LocalPlayer():GetVelocity():Length() * MPH); end);
  CSSHUD:AddVariant("money", "User input", function() return CSSHUD:GetMoneyInput(); end);

end
