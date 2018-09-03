--[[
  VARIANT FUNCTIONALITIES
]]

if CLIENT then

  -- Database
  CSSHUD.Variants = {};

  --[[
    Adds a value display variant for an element
    @param {string} id
    @param {string} label
    @param {function} func
    @void
  ]]
  function CSSHUD:AddVariant(id, label, func)
    if (self.Variants[id] == nil) then self.Variants[id] = {}; end
    table.insert(self.Variants[id], {label = label, value = func});
  end

  --[[
    Returns a variant's data
    @param {string} id
    @param {string} var
    @return {table} variant
  ]]
  function CSSHUD:GetVariant(id, var)
    var = var or 1;
    return self.Variants[id][math.Clamp(var, 1, table.Count(self.Variants[id]))];
  end

  --[[
    Returns an element's variants
    @param {string} id
    @return {table} variants
  ]]
  function CSSHUD:GetVariants(id)
    return self.Variants[id];
  end

end
