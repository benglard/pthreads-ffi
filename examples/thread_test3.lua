require '../pthreads'

print(
  multithread{
    print=true,
    time=true,
    nthreads=10,
    globals={
      t = {'table', [[{}]]},
    },
    fname='hello',
    f=[[
function(id)
  t[id] = 5
  print(id, t[id])
end]],
  }
)