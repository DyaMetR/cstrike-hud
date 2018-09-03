--[[
  PRESETS
]]

if CLIENT then

  -- Parameters
  local DIR = "csshud/";

  -- Loaded preset database
  CSSHUD.Presets = {};

  --[[
    Searches for the preset files and loads them
    @void
  ]]
  function CSSHUD:LoadPresets()
    print("Loading CS:S HUD presets...")
    local files, directories = file.Find(DIR.."*.txt", "DATA");
    for _, filename in pairs(files) do
      print("Loading '"..filename.."'...");
      local preset = util.JSONToTable(file.Read(DIR..filename, "DATA"));
      self.Presets[preset.name] = preset.config;
      print("Done.");
    end
    print("All presets loaded!");
  end

  --[[
    Saves a preset into a file
    @param {string} name
    @void
  ]]
  function CSSHUD:SavePreset(name)
    if (name == nil or string.len(name) <= 0) then return end;
    if (not file.Exists(DIR, "DATA")) then
      print("Creating base dir...");
      file.CreateDir(DIR);
      print("Done.");
    end

    print("Saving preset '"..name.."'...");
    local preset = {name = name, config = {}};
    for name, value in pairs(self.Configuration.Values) do
      if (type(value:GetDefault()) == "number") then
        preset.config[name] = value:GetFloat();
      else
        preset.config[name] = value:GetString();
      end
    end
    file.Write(DIR..name..".txt", util.TableToJSON(preset));
    self.Presets[name] = preset;
    LocalPlayer():ChatPrint("Preset '"..name.."' saved successfully!");
  end

  --[[
    Loads a preset's configuration
    @param {string} name
    @void
  ]]
  function CSSHUD:LoadPreset(name)
    if (self.Presets[name] == nil) then print("Error: Attempted to load an unexisting preset."); return; end
    for convar, _ in pairs(CSSHUD.Configuration.Default) do
      RunConsoleCommand(convar, self.Presets[name][convar]);
    end
  end

  --[[
    Returns all of the presets
    @return {table} presets
  ]]
  function CSSHUD:GetPresets()
    return self.Presets;
  end

  -- Concommands
  concommand.Add("csshud_preset_load", function(player, com, args)
    CSSHUD:LoadPreset(args[1]);
  end);

  concommand.Add("csshud_preset_save", function(player, com, args)
    CSSHUD:SavePreset(args[1]);
  end);

end
