local utils = {}

utils.table2str = function(t)
   local rv = ''
   for name, value in pairs(t) do
      if type(value) == 'string' then
         rv = string.format('%s%s = "%s"\n', rv, name, value)
      elseif type(value) == 'table' then
         rv = string.format('%s%s = %s\n', rv, name, value[2])
      else
         rv = string.format('%s%s = %s\n', rv, name, value)
      end
   end
   return rv
end

utils.toboolean = function(i)
   if i == 0 then return false
   else return true end
end

utils.c2lua = function(ffi, C, L, name, value)
   C.lua_getfield(L, C.LUA_GLOBALSINDEX, name)

   if type(value) == 'string' then
      local len = ffi.new('size_t[1]', value:len()) -- what if string was made longer?
      local ctype = C.lua_tolstring(L, -1, len)
      return tostring(ffi.string(ctype))
   elseif type(value) == 'number' then
      local ctype = C.lua_tointeger(L, -1)
      return tonumber(ctype)
   elseif type(value) == 'boolean' then
      local ctype = C.lua_toboolean(L, -1)
      return utils.toboolean(ctype)
   elseif type(value) == 'table' then
      -- unsure what to do here
   end
end

return utils