require '../pthreads'

print(
  multithread{
    print=true,
    time=true,
    nthreads=10,
    globals={
      sum = 0,
      --strtest = 'hi',
      --booltest = true
    },
    fname='hello',
    f=[[function(id) sum = sum + id end]],
  }.sum
)