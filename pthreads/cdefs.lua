local ffi = require 'ffi'
local pt = ffi.load('pthread')

ffi.cdef[[
typedef uint64_t pthread_t;

typedef struct {
    uint32_t flags;
    void * stack_base;
    size_t stack_size;
    size_t guard_size;
    int32_t sched_policy;
    int32_t sched_priority;
} pthread_attr_t;

typedef void *(*thread_func)(void *);

int pthread_create(
  pthread_t *thread,
  const pthread_attr_t *attr,
  void *(*start_routine)(void *),
  void *arg
);

int pthread_join(
  pthread_t thread,
  void **value_ptr
);
]]

ffi.cdef[[
typedef struct lua_State lua_State;
lua_State *luaL_newstate(void);
void luaL_openlibs(lua_State *L);
void lua_close(lua_State *L);
int luaL_loadstring(lua_State *L, const char *s);
int lua_pcall(lua_State *L, int nargs, int nresults, int errfunc);

static const int LUA_GLOBALSINDEX = -10002;
void lua_getfield(lua_State *L, int index, const char *k);
void lua_settop(lua_State *L, int index);

typedef ptrdiff_t lua_Integer; 
void lua_pushinteger(lua_State *L, lua_Integer n);

ptrdiff_t lua_tointeger(lua_State *L, int index);
const char *lua_tolstring(lua_State *L, int index, size_t *len);
int lua_toboolean(lua_State *L, int index);
typedef int (*lua_CFunction) (lua_State *L);
lua_CFunction lua_tocfunction(lua_State *L, int index);
]]

return {ffi, pt}