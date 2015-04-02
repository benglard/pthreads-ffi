local ffi, pt = unpack(require('pthreads.cdefs'))
local utils = require 'pthreads.utils'
local C = ffi.C

multithread = function(options)
   local options = options or {}
   local do_print = options.print or false
   local do_time  = options.time or false
   local nthreads = options.nthreads or 2
   local globals  = options.globals or {}
   local fname    = options.fname or '_'
   local f        = options.f or 'function(id) end'

   globals.total_clock_time = 0

   local L = C.luaL_newstate()
   assert(L ~= nil)
   C.luaL_openlibs(L)

   local globals_str = ''
   for name, value in pairs(globals) do
      if type(value) == 'string' then
         globals_str = string.format('%s%s = "%s"\n', globals_str, name, value)
      else
         globals_str = string.format('%s%s = %s\n', globals_str, name, value)
      end
   end

   local code = string.format(
[[local ffi = require("ffi")
require 'socket'
%s
%s = %s
local function parse(args)
   local start = socket.gettime() * 1000000
   %s(args)
   local diff = socket.gettime() * 1000000 - start
   total_clock_time = total_clock_time + diff
end
callback = tonumber(ffi.cast('intptr_t', ffi.cast('void *(*)(int)', parse)))]],
   globals_str, fname, f, fname)
   
   if do_print then print(code) end

   assert(C.luaL_loadstring(L, code) == 0)
   assert(C.lua_pcall(L, 0, 1, 0) == 0)

   C.lua_getfield(L, C.LUA_GLOBALSINDEX, 'callback')
   local func_ptr = C.lua_tointeger(L, -1)
   C.lua_settop(L, -2)

   local pthreads = ffi.new(string.format('pthread_t[%d]', nthreads))
   local start_routine = ffi.cast('thread_func', func_ptr)

   for i = 0, nthreads - 1 do
      local res = pt.pthread_create(
         pthreads + i, 
         nil, 
         start_routine,
         ffi.cast("void *", i + 1)
      )
      assert(res == 0)

      local res = pt.pthread_join(pthreads[i], nil)
      assert(res == 0)
   end

   local rv = {}
   for name, value in pairs(globals) do
      local luaval = utils.c2lua(C, L, name, value)
      if name == 'total_clock_time' and do_time then
         rv[name] = luaval / 1000000
      else
         rv[name] = luaval
      end   
   end

   C.lua_close(L)
   return rv
end