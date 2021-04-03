from threading import Thread

def square_numbers():
  out = []
  for i in range(100):
    out.append(i * i)
  print('out: ', out)
  return out

if __name__ == '__main__':
  threads = []
  num_threads = 10

  # create threads
  for i in range(num_threads):
    thread = Thread(target=square_numbers)
    threads.append(thread)

  # start
  for t in threads:
    t.start()

  # join
  for t in threads:
    t.join()

print('End main!!')