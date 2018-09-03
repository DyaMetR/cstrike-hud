--[[
  CONVARS MANAGEMENT
]]

if CLIENT then

  --[[
    Adds the three color structure to the convar list
    @param {table} table
    @param {string} id
    @param {Color} color
    @void
  ]]
  function CSSHUD:AddColorConvars(table, id, color)
    table[id.."_r"] = color.r;
    table[id.."_g"] = color.g;
    table[id.."_b"] = color.b;
  end

  --[[
    Gets the three color structure from the convars
    @param {string} id
    @return {Color} color
  ]]
  function CSSHUD:GetColorConvars(table, id)
    return Color(table[id.."_r"]:GetInt(), table[id.."_g"]:GetInt(), table[id.."_b"]:GetInt());
  end

  -- Database
  CSSHUD.Configuration = {};

  -- Default configuration
  CSSHUD.Configuration.Default = {
    ["csshud_enabled"] = 1,
    ["csshud_health_enabled"] = 1,
    ["csshud_armor_enabled"] = 1,
    ["csshud_armor_helmet"] = 50,
    ["csshud_ammo_enabled"] = 1,
    ["csshud_time_enabled"] = 1,
    ["csshud_money_enabled"] = 1,
    ["csshud_killfeed_enabled"] = 1,
    ["csshud_death_enabled"] = 1,
    ["csshud_damage_enabled"] = 1,
    ["csshud_pickup_enabled"] = 1,
    ["csshud_time_variant"] = 1,
    ["csshud_time_input"] = "0:00",
    ["csshud_money_variant"] = 1,
    ["csshud_money_input"] = "800",
    ["csshud_money_multiplier"] = 300,
    ["csshud_money_max"] = 16000,
    ["csshud_color_background_a"] = CSSHUD:GetDefaultBackgroundColor().a
  };

  CSSHUD.Configuration.DefaultColors = {
    ["csshud_color_background"] = CSSHUD:GetDefaultBackgroundColor(),
    ["csshud_color_health"] = CSSHUD:GetDefaultColor(),
    ["csshud_color_health_crit"] = CSSHUD:GetDefaultCritColor(),
    ["csshud_color_armor"] = CSSHUD:GetDefaultColor(),
    ["csshud_color_time"] = CSSHUD:GetDefaultColor(),
    ["csshud_color_ammo"] = CSSHUD:GetDefaultColor(),
    ["csshud_color_money"] = CSSHUD:GetDefaultColor(),
    ["csshud_color_money_add"] = Color(0, 255, 0),
    ["csshud_color_money_sub"] = Color(255, 0, 0),
    ["csshud_color_death"] = CSSHUD:GetDefaultColor(),
    ["csshud_color_pickup"] = CSSHUD:GetDefaultPickupColor()
  };

  for name, value in pairs(CSSHUD.Configuration.DefaultColors) do
    CSSHUD:AddColorConvars(CSSHUD.Configuration.Default, name, value);
  end

  -- Configuration
  CSSHUD.Configuration.Values = {};

  for name, value in pairs(CSSHUD.Configuration.Default) do
    CSSHUD.Configuration.Values[name] = CreateClientConVar(name, value);
  end

  -- Reset all
  concommand.Add("csshud_reset", function(player, com, args)
    for name, value in pairs(CSSHUD.Configuration.Default) do
      RunConsoleCommand(name, value);
    end
  end);

  -- Set all elements' colours to a single one
  concommand.Add("csshud_color_r", function(player, com, args)
    for name, value in pairs(CSSHUD.Configuration.DefaultColors) do
      if (name != "csshud_color_background") then
        RunConsoleCommand(name.."_r", args[1]);
      end
    end
  end);

  concommand.Add("csshud_color_g", function(player, com, args)
    for name, value in pairs(CSSHUD.Configuration.DefaultColors) do
      if (name != "csshud_color_background") then
        RunConsoleCommand(name.."_g", args[1]);
      end
    end
  end);

  concommand.Add("csshud_color_b", function(player, com, args)
    for name, value in pairs(CSSHUD.Configuration.DefaultColors) do
      if (name != "csshud_color_background") then
        RunConsoleCommand(name.."_b", args[1]);
      end
    end
  end);

  --[[
    Returns whether the HUD is enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsEnabled()
    return self.Configuration.Values["csshud_enabled"]:GetInt() > 0;
  end

  --[[
    Returns whether the health panel is enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsHealthEnabled()
    return self.Configuration.Values["csshud_health_enabled"]:GetInt() > 0;
  end

  --[[
    Returns whether the armor panel is enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsArmorEnabled()
    return self.Configuration.Values["csshud_armor_enabled"]:GetInt() > 0;
  end

  --[[
    Returns the armor amount necessary to show the helmet
    @return {number} amount
  ]]
  function CSSHUD:GetArmorAmountForHelmet()
    return self.Configuration.Values["csshud_armor_helmet"]:GetInt();
  end

  --[[
    Returns whether the ammunition panel is enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsAmmoEnabled()
    return self.Configuration.Values["csshud_ammo_enabled"]:GetInt() > 0;
  end

  --[[
    Returns whether the time panel is enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsTimeEnabled()
    return self.Configuration.Values["csshud_time_enabled"]:GetInt() > 0;
  end

  --[[
    Returns whether the money panel is enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsMoneyEnabled()
    return self.Configuration.Values["csshud_money_enabled"]:GetInt() > 0;
  end

  --[[
    Returns whether the custom killfeed is enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsKillfeedEnabled()
    return self.Configuration.Values["csshud_killfeed_enabled"]:GetInt() > 0;
  end

  --[[
    Returns whether the death overlay is enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsDeathOverlayEnabled()
    return self.Configuration.Values["csshud_death_enabled"]:GetInt() > 0;
  end

  --[[
    Returns whether the damage indicators are enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsDamageIndicatorEnabled()
    return self.Configuration.Values["csshud_damage_enabled"]:GetInt() > 0;
  end

  --[[
    Returns whether the item pickup history is enabled
    @return {boolean} enabled
  ]]
  function CSSHUD:IsPickupEnabled()
    return self.Configuration.Values["csshud_pickup_enabled"]:GetInt() > 0;
  end

  --[[
    Returns the background panels color
    @return {Color} color
  ]]
  function CSSHUD:GetBackgroundColor()
    local color = self:GetColorConvars(self.Configuration.Values, "csshud_color_background");
    return Color(color.r, color.g, color.b, self.Configuration.Values["csshud_color_background_a"]:GetInt());
  end

  --[[
    Returns the health panel color
    @return {Color} color
  ]]
  function CSSHUD:GetHealthColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_health");
  end

  --[[
    Returns the health panel color when damaged/low
    @return {Color} color
  ]]
  function CSSHUD:GetHealthCritColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_health_crit");
  end

  --[[
    Returns the armor panel color
    @return {Color} color
  ]]
  function CSSHUD:GetArmorColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_armor");
  end

  --[[
    Returns the ammo panel color
    @return {Color} color
  ]]
  function CSSHUD:GetAmmoColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_ammo");
  end

  --[[
    Returns the time panel color
    @return {Color} color
  ]]
  function CSSHUD:GetTimeColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_time");
  end

  --[[
    Returns the money panel color
    @return {Color} color
  ]]
  function CSSHUD:GetMoneyColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_money");
  end

  --[[
    Returns the money add color
    @return {Color} color
  ]]
  function CSSHUD:GetMoneyAddColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_money_add");
  end

  --[[
    Returns the money subtract color
    @return {Color} color
  ]]
  function CSSHUD:GetMoneySubColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_money_sub");
  end

  --[[
    Returns the death overlay color
    @return {Color} color
  ]]
  function CSSHUD:GetDeathOverlayColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_death");
  end

  --[[
    Returns the pickup history color
    @return {Color} color
  ]]
  function CSSHUD:GetPickupColor()
    return self:GetColorConvars(self.Configuration.Values, "csshud_color_pickup");
  end

  --[[
    Returns the time value variant
    @return {number} variant
  ]]
  function CSSHUD:GetTimeVariant()
    return self.Configuration.Values["csshud_time_variant"]:GetInt();
  end

  --[[
    Returns the time value from user input
    @return {string} input
  ]]
  function CSSHUD:GetTimeInput()
    return self.Configuration.Values["csshud_time_input"]:GetString();
  end

  --[[
    Returns the money value variant
    @return {number} variant
  ]]
  function CSSHUD:GetMoneyVariant()
    return self.Configuration.Values["csshud_money_variant"]:GetInt();
  end

  --[[
    Returns the money value from user input
    @return {string} input
  ]]
  function CSSHUD:GetMoneyInput()
    return self.Configuration.Values["csshud_money_input"]:GetString();
  end

  --[[
    Returns the money multiplier
    @return {number} multiplier
  ]]
  function CSSHUD:GetMoneyMultiplier()
    return self.Configuration.Values["csshud_money_multiplier"]:GetInt();
  end

  --[[
    Returns the maximum money amount
    @return {number} max
  ]]
  function CSSHUD:GetMaxMoney()
    return self.Configuration.Values["csshud_money_max"]:GetInt();
  end

end
