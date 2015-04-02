package = 'pthreads'
version = 'scm-1'

source = {
   url = 'git://github.com/benglard/pthreads-ffi',
}

description = {
   summary = 'FFI access to pthreads',
   detailed = [[A LuaJIT threading system based on C pthreads.]],
   homepage = 'https://github.com/benglard/waffle'
}

dependencies = {
   'lua >= 5.1',
   'luasocket >= 2.0.2',
}

build = {
   type = 'builtin',
   modules = {
      ['pthreads.init'] = 'pthreads/init.lua',
      ['pthreads.cdefs'] = 'pthreads/cdefs.lua',
      ['pthreads.utils'] = 'pthreads/utils.lua'
   }
}