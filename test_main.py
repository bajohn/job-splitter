from combinator import CombinationMapper
import pytest


def test_max_idx():
    mapper = CombinationMapper(3, ['a', 'b', 'c'])
    assert mapper.getMaxIdx() == 27


def test_idx_out_of_bounds():
    mapper = CombinationMapper(3, ['a', 'b', 'c'])
    with pytest.raises(ValueError):
        mapper.getCombinationFromInt(100)

