--[[
  FONTS USED
]]

if CLIENT then

  surface.CreateFont("csshud",{
      font = "Counter-Strike",
      size = ScreenScale(23.5),
      weight = 500,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_small",{
      font = "Arial",
      size = ScreenScale(11),
      weight = 600,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_ammo",{
      font = "csd",
      size = ScreenScale(35),
      weight = 500,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_ammo_hl2",{
      font = "HalfLife2",
      size = ScreenScale(26),
      weight = 500,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_ammo_hl2mp",{
      font = "HL2MP",
      size = ScreenScale(30),
      weight = 500,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_weapon_hl2",{
      font = "HalfLife2",
      size = ScreenScale(58),
      weight = 500,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_weapon_css",{
      font = "Counter-Strike",
      size = ScreenScale(58),
      weight = 500,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_icon_small",{
      font = "Counter-Strike",
      size = ScreenScale(18),
      weight = 500,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_tahoma_small",{
      font = "Tahoma",
      size = ScreenScale(7),
      weight = 1000,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_headshot",{
      font = "csd",
      size = 60,
      weight = 500,
      antialiasing = true,
      additive = true
  });

  surface.CreateFont("csshud_killfeed",{
      font = "Tahoma",
      size = 14,
      weight = 1000,
      antialiasing = true,
      additive = false
  });

end
