--[[
  KILLFEED REPLACEMENT
]]

local NET_STRING = "csshud_killfeed";

if CLIENT then

  -- Parameters
  local TIME = 7;

  -- Variables
  local killfeed = {};

  --[[
    Draws an entry of the killfeed
    @param {number} i
    @param {number} x
    @param {number} y
    @void
  ]]
  function CSSHUD:DrawKillfeed(i, x, y)
    if (killfeed[i] == nil) then return; end;
    if (killfeed[i].time < CurTime()) then table.remove(killfeed, i); return; end;
    local feed = killfeed[i];
    surface.SetFont("csshud_killfeed");
    local size = surface.GetTextSize(feed.victim);

    -- Draw the victim's name
    draw.SimpleText(feed.victim, "csshud_killfeed", x, y, feed.vCol, 2);

    -- Draw the headshot icon
    local offset = 0;
    if (feed.headshot) then
      offset = 55;
      draw.SimpleText("D", "csshud_headshot", x - size - 5, y - 7, Color(255, 80, 0), 2);
    end

    -- Draw the killicon
    local icon = (killicon.GetSize(feed.weapon) * 0.6);
    local kOffset = (size + icon + offset); -- Killicon offset
    if (killicon.Exists(feed.weapon)) then
      killicon.Draw(x - kOffset, y, feed.weapon, 255);
    else
      draw.SimpleText("C", "csshud_headshot", x - kOffset + 22, y - 7, Color(255, 80, 0), 2);
    end

    -- Draw the attacker's name
    draw.SimpleText(feed.attacker, "csshud_killfeed", x - kOffset - (icon * 0.9), y, feed.aCol, 2);
  end

  --[[
    Returns the current killfeed data
    @return {table} killfeed
  ]]
  function CSSHUD:GetKillfeed()
    return killfeed;
  end

  -- Override default killfeed
  hook.Add("DrawDeathNotice", "csshud_killfeed", function(x, y)
    if (not CSSHUD:IsEnabled() or not CSSHUD:IsKillfeedEnabled()) then return end;
    return false;
  end);

  net.Receive(NET_STRING, function(len)
    table.insert(killfeed, {victim = language.GetPhrase(net.ReadString()),
                            vCol = net.ReadColor(),
                            headshot = net.ReadBool(),
                            attacker = language.GetPhrase(net.ReadString()),
                            aCol = net.ReadColor(),
                            weapon = net.ReadString() or nil,
                            time = CurTime() + TIME});
  end);

end

if SERVER then

  util.AddNetworkString(NET_STRING);

  --[[
    Sends a death notice to everyone
    @param {}
  ]]
  local function SendDeathNotice(victim, attacker)
    net.Start(NET_STRING);
    -- Victim data
    if (victim:IsPlayer()) then
      net.WriteString(victim:Name());
      net.WriteColor(team.GetColor(victim:Team()));
    else
      net.WriteString(victim:GetClass());
      net.WriteColor(Color(255, 0, 0));
    end
    net.WriteBool(victim.csshud_headshot or false);

    -- Attacker data
    if (IsValid(attacker) and attacker:GetClass() != nil and attacker != victim) then
      if (attacker:IsPlayer()) then
        net.WriteString(attacker:Name());
        net.WriteColor(team.GetColor(attacker:Team()));
        if (IsValid(attacker:GetActiveWeapon())) then
          net.WriteString(attacker:GetActiveWeapon():GetClass());
        else
          net.WriteString("");
        end
      else
        net.WriteString(attacker:GetClass());
        net.WriteColor(Color(255, 0, 0));
      end
    else
      net.WriteString("");
    end

    -- Send to everyone
    net.Broadcast();
  end

  -- Detect headshots
  hook.Add("ScalePlayerDamage", "csshud_headshot", function(player, hitgroup, dmginfo)
    player.csshud_headshot = hitgroup == HITGROUP_HEAD;
  end);

  hook.Add("ScaleNPCDamage", "csshud_headshot_npc", function(npc, hitgroup, dmginfo)
    npc.csshud_headshot = hitgroup == HITGROUP_HEAD;
  end);

  -- Send death notice
  hook.Add("PlayerDeath", "csshud_death", function(player, infl, attacker)
    SendDeathNotice(player, attacker);
  end);

  hook.Add("OnNPCKilled", "csshud_death_npc", function(npc, attacker, infl)
    SendDeathNotice(npc, attacker);
  end);

  -- Reset buffer data
  hook.Add("PlayerSpawn", "csshud_spawn", function(player)
    player.csshud_headshot = nil;
  end);

end
