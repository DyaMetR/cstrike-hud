--[[
  CONFIGURATION MENU
]]

if CLIENT then


  --[[
    Menu options
  ]]
  CSSHUD.ReloadPreset = true;
  local combobox, label;
  local function menuComposition( panel )
  	panel:ClearControls();

    -- General
    panel:AddControl( "Label" , { Text = "General"} );

    panel:AddControl( "CheckBox", {
  		Label = "Enabled",
  		Command = "csshud_enabled",
  		}
  	);

    panel:AddControl( "Button", {
  		Label = "Reset settings to default",
  		Command = "csshud_reset",
  		}
  	);

    -- Presets
    panel:AddControl( "Label" , { Text = "\nPresets"} );
    local combobox1, label1 = panel:ComboBox("Load preset", "csshud_preset_load");

    panel:AddControl( "TextBox", {
      Label = "Force load preset",
      Command = "csshud_preset_load"
    });

    panel:AddControl( "TextBox", {
      Label = "Save preset",
      Command = "csshud_preset_save"
    });

    combobox, label = panel:ComboBox("Remove preset", "csshud_preset_remove");
    combobox.Think = function()
      if (CSSHUD.ReloadPreset) then
        combobox:Clear();
        combobox1:Clear();
        for preset, _ in pairs(CSSHUD:GetPresets()) do
      		combobox:AddChoice(preset);
          combobox1:AddChoice(preset);
        end
        CSSHUD.ReloadPreset = false;
      end
    end

    -- General colouring
    panel:AddControl( "Label" , { Text = "\nGeneral colouring"} );
    panel:AddControl( "Label" , { Text = "Base colour"} );
    panel:AddControl( "TextBox", {
      Label = "Red",
      Command = "csshud_color_r",
      Text = CSSHUD:GetDefaultColor().r
      }
    );
    panel:AddControl( "TextBox", {
      Label = "Green",
      Command = "csshud_color_g",
      Text = CSSHUD:GetDefaultColor().g
      }
    );
    panel:AddControl( "TextBox", {
      Label = "Blue",
      Command = "csshud_color_b",
      Text = CSSHUD:GetDefaultColor().b
      }
    );

    panel:AddControl( "Color", {
      Label = "Background colour",
      Red = "csshud_color_background_r",
      Green = "csshud_color_background_g",
      Blue = "csshud_color_background_b",
      Alpha = "csshud_color_background_a"
      }
    );

    -- Composition
    panel:AddControl( "Label" , { Text = "\nHealth"} );

    panel:AddControl( "CheckBox", {
  		Label = "Health panel enabled",
  		Command = "csshud_health_enabled",
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Health colour",
  		Red = "csshud_color_health_r",
      Green = "csshud_color_health_g",
      Blue = "csshud_color_health_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Health damage colour",
  		Red = "csshud_color_health_crit_r",
      Green = "csshud_color_health_crit_g",
      Blue = "csshud_color_health_crit_b"
  		}
  	);

    panel:AddControl( "Label" , { Text = "\nArmor"} );

    panel:AddControl( "CheckBox", {
  		Label = "Armor panel enabled",
  		Command = "csshud_armor_enabled",
  		}
  	);

    panel:AddControl( "TextBox", {
  		Label = "Amount to show helmet",
  		Command = "csshud_armor_helmet",
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Armor colour",
  		Red = "csshud_color_armor_r",
      Green = "csshud_color_armor_g",
      Blue = "csshud_color_armor_b"
  		}
  	);

    panel:AddControl( "Label" , { Text = "\nAmmunition"} );

    panel:AddControl( "CheckBox", {
  		Label = "Ammo panel enabled",
  		Command = "csshud_ammo_enabled",
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Ammunition colour",
  		Red = "csshud_color_ammo_r",
      Green = "csshud_color_ammo_g",
      Blue = "csshud_color_ammo_b"
  		}
  	);

    panel:AddControl( "Label" , { Text = "\nTime"} );
    -- Time panel
    panel:AddControl( "CheckBox", {
  		Label = "Time panel enabled",
  		Command = "csshud_time_enabled",
  		}
  	);

    local combobox, label = panel:ComboBox("Time panel value", "csshud_time_variant");
    for id, variant in pairs(CSSHUD:GetVariants("time")) do
  		combobox:AddChoice(variant.label, id);
    end

    panel:AddControl( "TextBox", {
  		Label = "Custom output",
  		Command = "csshud_time_input",
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Time colour",
  		Red = "csshud_color_time_r",
      Green = "csshud_color_time_g",
      Blue = "csshud_color_time_b"
  		}
  	);

    panel:AddControl( "Label" , { Text = "\nMoney"} );

    -- Money panel
    panel:AddControl( "CheckBox", {
  		Label = "Money panel enabled",
  		Command = "csshud_money_enabled",
  		}
  	);

    panel:AddControl( "TextBox", {
  		Label = "Maximum money amount",
  		Command = "csshud_money_max",
  		}
  	);

    local combobox, label = panel:ComboBox("Money panel value", "csshud_money_variant");
    for id, variant in pairs(CSSHUD:GetVariants("money")) do
  		combobox:AddChoice(variant.label, id);
    end

    panel:AddControl( "TextBox", {
  		Label = "Money value multiplier",
  		Command = "csshud_money_multiplier",
  		}
  	);

    panel:AddControl( "TextBox", {
  		Label = "Custom output",
  		Command = "csshud_money_input",
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Money base colour",
  		Red = "csshud_color_money_r",
      Green = "csshud_color_money_g",
      Blue = "csshud_color_money_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Money add colour",
  		Red = "csshud_color_money_add_r",
      Green = "csshud_color_money_add_g",
      Blue = "csshud_color_money_add_b"
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Money subtract colour",
  		Red = "csshud_color_money_sub_r",
      Green = "csshud_color_money_sub_g",
      Blue = "csshud_color_money_sub_b"
  		}
  	);

    panel:AddControl( "Label" , { Text = "\nPickup history"} );

    panel:AddControl( "CheckBox", {
  		Label = "Enable item pickup history",
  		Command = "csshud_pickup_enabled",
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Pickup history colour",
  		Red = "csshud_color_pickup_r",
      Green = "csshud_color_pickup_g",
      Blue = "csshud_color_pickup_b"
  		}
  	);

    panel:AddControl( "Label" , { Text = "\nDeath overlay"} );

    panel:AddControl( "CheckBox", {
  		Label = "Enable death overlay",
  		Command = "csshud_death_enabled",
  		}
  	);

    panel:AddControl( "Color", {
  		Label = "Death overlay foreground colour",
  		Red = "csshud_color_death_r",
      Green = "csshud_color_death_g",
      Blue = "csshud_color_death_b"
  		}
  	);

    panel:AddControl( "Label" , { Text = "\nMiscellaneous"} );

    panel:AddControl( "CheckBox", {
  		Label = "Enable damage indicators",
  		Command = "csshud_damage_enabled",
  		}
  	);

    panel:AddControl( "CheckBox", {
  		Label = "Enable killfeed",
  		Command = "csshud_killfeed_enabled",
  		}
  	);

    -- Credits
    panel:AddControl( "Label",  { Text = ""});
    panel:AddControl( "Label",  { Text = "Version " .. CSSHUD.Version});
    panel:AddControl( "Label",  { Text = ""});
  	panel:AddControl( "Label",  { Text = "Credits"});
    panel:AddControl( "Label",  { Text = "Main script: DyaMetR"});
    panel:AddControl( "Label",  { Text = "Fonts and original design: Valve Software"});
    panel:AddControl( "Label",  { Text = ""});
  end

  local function menuCreation()
  	spawnmenu.AddToolMenuOption( "Options", "DyaMetR", "CSSHUD", "Counter-Strike: Source HUD", "", "", menuComposition );
  end
hook.Add( "PopulateToolMenu", "csshud_menu", menuCreation );

  --[[
    Gets the current selected preset from the combobox
    @return {string} preset
  ]]
  function CSSHUD:GetSelectedPreset()
    return combobox:GetSelected();
  end

end
