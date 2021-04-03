from multiprocessing import Process
import os
import time

processes = []
num_process = os.cpu_count()

def square_numbers():
  out = []
  for i in range(100):
    out.append(i * i)
    time.sleep(0.1)
  print('out: ', out)
  return out

if __name__ == '__main__':
  # create processes
  for i in range(num_process):
    p = Process(target=square_numbers)
    processes.append(p)

  # start
  for p in processes:
    p.start()

  # join
  for p in processes:
    p.join()

print('End main!!')