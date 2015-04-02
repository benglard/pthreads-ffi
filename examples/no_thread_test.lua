require 'socket'
start_time = socket.gettime() * 1000000
sum = 0
for i=1,10 do
   local x = i * 1000
   sum = sum + x
end
print((socket.gettime() * 1000000 - start_time) / 1000000)
--print(sum)