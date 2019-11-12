import math


class CombinationMapper:
    def __init__(self, strLen, chars):
        self._strLen = strLen
        self._chars = chars
        self._c = len(self._chars)
        self._maxIdx = self._c**strLen

    def getCombinationFromInt(self, i):
        if i > self._maxIdx:
            raise ValueError(f'Given index of {i} is out of range for given parameters.')
        ret = ''
        for k in range(0, self._strLen):
            charIdx = math.floor(i/(self._c**k) % self._c)
            char = self._chars[charIdx]
            ret = str(char) + ret
        return ret 

    def getMaxIdx(self):
        return self._maxIdx
