local utils = {}

utils.toboolean = function(i)
   if i == 0 then return false
   else return true end
end

utils.to_funcs = {
   number = {'lua_tointeger', tonumber},
   string = {'lua_tolstring', tostring},
   boolean = {'lua_toboolean', utils.toboolean}
}

utils.c2lua = function(C, L, name, value)
   local funcs = utils.to_funcs[type(value)]
   C.lua_getfield(L, C.LUA_GLOBALSINDEX, name)

   if type(value) == 'string' then
      local len = ffi.new('size_t[1]', value:len())
      local ctype = C[funcs[1]](L, -1, len)
      return funcs[2](ffi.string(ctype))
   else
      local ctype = C[funcs[1]](L, -1)
      return funcs[2](ctype)
   end
end

return utils