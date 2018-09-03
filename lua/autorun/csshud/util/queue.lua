--[[
  RENDER QUEUE
]]

if CLIENT then

  -- Database
  CSSHUD.RenderQueue = {};

  --[[
    Adds a function to the draw queue
    @param {function} func
    @void
  ]]
  function CSSHUD:AddDrawElement(func)
    table.insert(self.RenderQueue, func);
  end

  --[[
    Gets an element from the draw queue
    @param {number} i
    @return {function} element
  ]]
  function CSSHUD:GetDrawElement(i)
    return self.RenderQueue[i];
  end

  --[[
    Returns the entire render queue
    @return {table} CSSHUD.RenderQueue
  ]]
  function CSSHUD:GetRenderQueue()
    return self.RenderQueue;
  end

  --[[
    Draws the entire render queue
    @void
  ]]
  function CSSHUD:DrawRenderQueue()
    for _, func in pairs(self:GetRenderQueue()) do
      func();
    end
  end

  hook.Add("HUDPaint", "csshud_draw", function()
    if (not CSSHUD:IsEnabled() or (IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_camera")) then return end;
    CSSHUD:DrawRenderQueue();
  end);

end
