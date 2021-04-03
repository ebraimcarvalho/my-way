numbers = [1,2,3,4,5,6,7,8]

beginning, second, *middle, last = numbers

# print(beginning)
# print(second)
# print(middle)
# print(last)

my_tuple = (1,2,3,4)
my_list = [5,6,7,8]
my_set = {4,5,6,9,10}
new_list = [*my_tuple, *my_list, *my_set]
print(new_list)

dict_a = {'a': 1, 'b': 22, 'c': 32}
dict_b = {'d': 'asas', 'e': 'dalee', 'f': True}
my_dict = {**dict_a, **dict_b}
print(my_dict)