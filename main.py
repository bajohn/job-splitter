from combinator import CombinationMapper

print('init')
mapper = CombinationMapper(3, ['a', 'b', 'c'])
for i in range(0, 27):
    output = mapper.getCombinationFromInt(i)
    print(output)
