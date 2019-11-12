from combinator import CombinationMapper
import pytest
import logging


logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
handler = logging.FileHandler('out.log')
handler.setLevel(logging.INFO)
logger.addHandler(handler)


def test_max_idx():
    mapper = CombinationMapper(3, ['a', 'b', 'c'])
    assert mapper.getMaxIdx() == 27


def test_idx_out_of_bounds():
    mapper = CombinationMapper(3, ['a', 'b', 'c'])
    with pytest.raises(ValueError):
        mapper.getCombinationFromInt(100)


def test_generation():
    mapper = CombinationMapper(2, ['a', 'b', 'c'])
    logger.info('init')
    correctArr = [ 'aa',
    'ab',
    'ac',
    'ba',
    'bb',
    'bc',
    'ca',
    'cb',
    'cc']
    for i in range(0,mapper.getMaxIdx()):
        assert correctArr[i] == mapper.getCombinationFromInt(i)

