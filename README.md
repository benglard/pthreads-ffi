# pthreads-ffi

A LuaJIT threading system based on C pthreads.

Note: after writing this, I discovered that [threads-ffi](https://github.com/torch/threads-ffi) also exists.

## Example Usage:
```lua
require '../pthreads'

print(
  multithread{
    print=true,
    time=true,
    nthreads=10,
    globals={
      sum = 0,
    },
    fname='hello',
    f=[[function(id) sum = sum + id end]],
  }.sum
)
```