--[[
  DAMAGE RECEIVING
]]

if SERVER then

  -- ENUMS
  local UP = 0;
  local DOWN = 1;
  local LEFT = 2;
  local RIGHT = 3;

  util.AddNetworkString("csshud_damage");

  local DISTANCE = 100;

  hook.Add("EntityTakeDamage", "csshud_damage", function(target, dmginfo)
    if (target:IsPlayer() and IsValid(dmginfo:GetAttacker())) then
      local origin = dmginfo:GetAttacker():GetPos(); -- Position of the attacker
  		local noHeight = Vector(target:GetPos().x, target:GetPos().y, 0); -- Ignore height, this is only for the direction
  		local yaw = Angle(0, target:EyeAngles().y, 0); -- Get only the yaw, which is the only angle we need
      local worldToLocal = WorldToLocal(origin, angle_zero, noHeight, yaw); -- Get the relative angle
			local angle = worldToLocal:Angle().y; -- Take out only the yaw

      -- Show each indicator based on the direction the player is facing
      local enums = {};
      if (angle >= 295 or angle < 65) then
        table.insert(enums, UP);
      end

      if (angle >= 115 and angle < 245) then
        table.insert(enums, DOWN);
      end

      if (angle >= 205 and angle < 335) then
        table.insert(enums, RIGHT);
      end

      if (angle >= 25 and angle < 155) then
        table.insert(enums, LEFT);
      end

      -- If player self inflicts near damage or receives generic damage, show all indicators
      local selfDamage = (dmginfo:GetAttacker() == target and target:GetPos():Distance(dmginfo:GetDamagePosition()) < DISTANCE);
      if (selfDamage) then
        enums = {0,1,2,3};
      end

      net.Start("csshud_damage");
      net.WriteTable(enums);
      net.Send(target);
    end
  end);

end
