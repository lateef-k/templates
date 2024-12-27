import pytest
from example.app import sum

def test_sum_positive_numbers():
    assert sum(1, 2) == 3

def test_sum_negative_numbers():
    assert sum(-1, -2) == -3

def test_sum_positive_and_negative():
    assert sum(-1, 1) == 0

def test_sum_zeros():
    assert sum(0, 0) == 0
