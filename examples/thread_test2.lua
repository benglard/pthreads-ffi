require '../pthreads'

print(
  multithread{
    print=true,
    time=true,
    nthreads=10,
    globals={
      sum = 0
    },
    fname='test',
    f=
[[
function(id)
  local x = 1000 * id
  sum = sum + x
end
]]
  }
)