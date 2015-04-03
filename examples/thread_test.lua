require '../pthreads'

print(
  multithread{
    print=true,
    time=true,
    nthreads=10,
    globals={
      sum = 0,
      strtest = 'hi',
      booltest = true,
      tabletest1 = {'table', [[{}]]},
      tabletest2 = {'table', [[{test = true, test2 = 'hi'}]]},
      tabletest3 = {'table', [[{test = {}, test2 = {}}]]},
      ftest = {'function', [[function() print('hi') end]]}
    },
    fname='hello',
    f=[[function(id) sum = sum + id; end]],
  }
)