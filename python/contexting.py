# with open('notes.txt', 'w') as file:
#   for i in range(10):
#     file.write('Some todo...\n')

class ManagedFile:
  def __init__(self, filename):
    print('init...', filename)
    self.filename = filename

  def __enter__(self):
    print('enter...')
    self.file = open(self.filename, 'w')
    return self.file
  
  def __exit__(self, exc_type, exc_value, exc_traceback):
    if self.file:
      self.file.close()
    if exc_type is not None:
      print('Exception has been handled!')
    print('exit...')
    return True

with ManagedFile('notes2.txt') as f:
  print('doing stuff...')
  for i in range(1, 10):
    f.write(f'some todo from Managed file, line {i} \n')
  f.do_something()

print('continuing...')