import unittest
import pandas as pd
from yzutil import YzDataClient
from indexYz import Index


class TestIndexYz(unittest.TestCase):

    def test_constant_addition(self):

        yz = YzDataClient("bruce@yangzeinvest.com", "bruce123")

        index_f30131 = Index('F30131').load_data(yz)
        add_constant = index_f30131 + 4.2

        self.assertEqual(add_constant.data_frame["index_value"][0], 1604.2)

    def test_index_addition(self):

        yz = YzDataClient("bruce@yangzeinvest.com", "bruce123")
        data = pd.read_csv("D:\\Yangze_Investment\\index_manipulation\\add_index_new_4.0.csv")

        index_f30131 = Index('F30131').load_data(yz)
        index_f30141 = Index('F30141').load_data(yz)
        add_index = index_f30131 + index_f30141

        self.assertEqual(add_index.data_frame["index_value"][1], data["index_value"][1])

        self.assertTrue(add_index.data_frame["index_value"][-1] == data["index_value"][12])


if __name__ == "__main__":
    unittest.main()
