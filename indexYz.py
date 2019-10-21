import pandas as pd
from yzutil import YzDataClient


class Index:
    """Index class for retrieving data from YzDataClient and
    conducing data manipulations.
    """

    def __init__(self, index_id=None):
        """Initializer to setup the YzDataClient by identifying the yz_data_client variable
        whose username and password are inputted outside of this Class; moreover, to retrieve data (DataFrame format)
        through get_alt_data method defined in yzutil package.

        Attributes:
            data_frame (pandas DataFrame)

        Args:
            index_id (index id string, default is None)

        Returns:
            None
        """
        if index_id is None:
            self.data_frame = pd.DataFrame()
        else:
            self.index_id = index_id
            self.data_frame = pd.DataFrame()

    def load_data(self, yz_data_client):
        """Method to retrieve data from YzDataClient through get_alt_data api,
        using the index id input from  __init__

        Args:
            yz_data_client (YzDataClient object)

        Returns:
            class object itself
            """
        self.data_frame = yz_data_client.get_alt_data(self.index_id)
        return self

    def __add__(self, other):
        """Define constant and index addition."""

        if isinstance(other, (int, float)):
            new_obj = Index()
            new_obj.data_frame = self.data_frame
            new_obj.data_frame["index_value"] = new_obj.data_frame["index_value"] + other  # key line for computation
            new_obj.data_frame = new_obj.data_frame[["index_time", "index_value", "insert_time", "source_time",
                                                     "latest"]]
            return new_obj

        elif isinstance(other, Index):
            new_obj = Index()

            # call user-defined method '_join_and_manipulate' to join two data frames and
            # to conduct series manipulation before index computation
            join_df = self._join_and_manipulate(other)

            join_df["index_value"] = join_df["index_value"] + join_df["index_value2"]  # key line for computation
            join_df.drop(columns=["index_value2"], inplace=True)

            # the following lines are for setting the insert_time and source_time for the new data set
            new_obj.data_frame = join_df
            join_df["insert_time"] = new_obj._retrieve_latest_time("insert_time", "insert_time2")
            join_df["source_time"] = new_obj._retrieve_latest_time("source_time", "source_time2")
            new_obj.data_frame = join_df[["index_time", "index_value", "insert_time", "source_time", "latest"]]

            return new_obj

    def __radd__(self, other):
        """Define right constant addition."""
        if isinstance(other, (int, float)):
            new_obj = Index()
            new_obj.data_frame = self.data_frame
            new_obj.data_frame["index_value"] = new_obj.data_frame["index_value"] + other  # key line for computation
            new_obj.data_frame = new_obj.data_frame[["index_time", "index_value", "insert_time", "source_time",
                                                     "latest"]]
            return new_obj

    def __sub__(self, other):
        """Define constant and index subtraction."""

        if isinstance(other, (int, float)):
            new_obj = Index()
            new_obj.data_frame = self.data_frame
            new_obj.data_frame["index_value"] = new_obj.data_frame["index_value"] - other  # key line for computation
            new_obj.data_frame = new_obj.data_frame[["index_time", "index_value", "insert_time", "source_time",
                                                     "latest"]]
            return new_obj

        elif isinstance(other, Index):
            new_obj = Index()

            # call user-defined method '_join_and_manipulate' to join two data frames and
            # to conduct series manipulation before index computation
            join_df = self._join_and_manipulate(other)

            join_df["index_value"] = join_df["index_value"] - join_df["index_value2"]  # key line for computation
            join_df.drop(columns=["index_value2"], inplace=True)

            # the following lines are for setting the insert_time and source_time for the new data set
            new_obj.data_frame = join_df
            join_df["insert_time"] = new_obj._retrieve_latest_time("insert_time", "insert_time2")
            join_df["source_time"] = new_obj._retrieve_latest_time("source_time", "source_time2")
            new_obj.data_frame = join_df[["index_time", "index_value", "insert_time", "source_time", "latest"]]

            return new_obj

    def __rsub__(self, other):
        """Define right constant subtraction."""

        if isinstance(other, (int, float)):
            new_obj = Index()
            new_obj.data_frame = self.data_frame
            new_obj.data_frame["index_value"] = other - new_obj.data_frame["index_value"]  # key line for computation
            new_obj.data_frame = new_obj.data_frame[["index_time", "index_value", "insert_time", "source_time",
                                                     "latest"]]
            return new_obj

    def __mul__(self, other):
        """Define constant and index multiplication."""

        if isinstance(other, (int, float)):
            new_obj = Index()
            new_obj.data_frame = self.data_frame
            new_obj.data_frame["index_value"] = new_obj.data_frame["index_value"] * other  # key line for computation
            new_obj.data_frame = new_obj.data_frame[["index_time", "index_value", "insert_time", "source_time",
                                                     "latest"]]
            return new_obj

        elif isinstance(other, Index):
            new_obj = Index()

            # call user-defined method '_join_and_manipulate' to join two data frames and
            # to conduct series manipulation before index computation
            join_df = self._join_and_manipulate(other)

            join_df["index_value"] = join_df["index_value"] * join_df["index_value2"]  # key line for computation
            join_df.drop(columns=["index_value2"], inplace=True)

            # the following lines are for setting the insert_time and source_time for the new data set
            new_obj.data_frame = join_df
            join_df["insert_time"] = new_obj._retrieve_latest_time("insert_time", "insert_time2")
            join_df["source_time"] = new_obj._retrieve_latest_time("source_time", "source_time2")
            new_obj.data_frame = join_df[["index_time", "index_value", "insert_time", "source_time", "latest"]]

            return new_obj

    def __rmul__(self, other):
        """Define right constant multiplication."""

        if isinstance(other, (int, float)):
            new_obj = Index()
            new_obj.data_frame = self.data_frame
            new_obj.data_frame["index_value"] = new_obj.data_frame["index_value"] * other  # key line for computation
            new_obj.data_frame = new_obj.data_frame[["index_time", "index_value", "insert_time", "source_time",
                                                     "latest"]]
            return new_obj

    def __truediv__(self, other):
        """Define constant and index true division."""

        if isinstance(other, (int, float)):
            new_obj = Index()
            new_obj.data_frame = self.data_frame
            new_obj.data_frame["index_value"] = new_obj.data_frame["index_value"] / other  # key line for computation
            new_obj.data_frame = new_obj.data_frame[["index_time", "index_value", "insert_time", "source_time",
                                                     "latest"]]
            return new_obj

        elif isinstance(other, Index):
            new_obj = Index()

            # call user-defined method '_join_and_manipulate' to join two data frames and
            # to conduct series manipulation before index computation
            join_df = self._join_and_manipulate(other)

            join_df["index_value"] = join_df["index_value"] / join_df["index_value2"]  # key line for computation
            join_df.drop(columns=["index_value2"], inplace=True)

            # the following lines are for setting the insert_time and source_time for the new data set
            new_obj.data_frame = join_df
            join_df["insert_time"] = new_obj._retrieve_latest_time("insert_time", "insert_time2")
            join_df["source_time"] = new_obj._retrieve_latest_time("source_time", "source_time2")
            new_obj.data_frame = join_df[["index_time", "index_value", "insert_time", "source_time", "latest"]]

            return new_obj

    def __floordiv__(self, other):
        """Define constant and index floor division."""

        if isinstance(other, (int, float)):
            new_obj = Index()
            new_obj.data_frame = self.data_frame
            new_obj.data_frame["index_value"] = new_obj.data_frame["index_value"] // other  # key line for computation
            new_obj.data_frame = new_obj.data_frame[["index_time", "index_value", "insert_time", "source_time",
                                                     "latest"]]
            return new_obj

        elif isinstance(other, Index):
            new_obj = Index()

            # call user-defined method '_join_and_manipulate' to join two data frames and
            # to conduct series manipulation before index computation
            join_df = self._join_and_manipulate(other)

            join_df["index_value"] = join_df["index_value"] // join_df["index_value2"]  # key line for computation
            join_df.drop(columns=["index_value2"], inplace=True)

            # the following lines are for setting the insert_time and source_time for the new data set
            new_obj.data_frame = join_df
            join_df["insert_time"] = new_obj._retrieve_latest_time("insert_time", "insert_time2")
            join_df["source_time"] = new_obj._retrieve_latest_time("source_time", "source_time2")
            new_obj.data_frame = join_df[["index_time", "index_value", "insert_time", "source_time", "latest"]]

            return new_obj

    def _join_and_manipulate(self, other):
        """Method to join two data frames and to conduct series manipulation before index computation

        Args:
            self (class object)
            other (class object)

        Returns:
            data frame: an outer-joined data frame that has been sorted, removed duplicates, filled & dropped NaN and
                        reset index
        """
        # outer join 2 data frames based on insert_time
        join_df = self.data_frame.join(other.data_frame.set_index("index_time"),
                                       on="index_time", rsuffix="2", how="outer")

        # triple sort IN ORDER by index_time, source_time and insert_time
        # only keep the LATEST observation (and drop other observations) for each index_time
        # forward fill (ffill) data values for all columns after time sorting and observations dropping
        join_df = join_df.sort_values(by=["index_time", "source_time", "insert_time"])
        join_df.drop_duplicates("index_time", keep="last", inplace=True)
        join_df = join_df.fillna(method="ffill").dropna()

        # the following line is for generating ordered index (important)
        join_df.reset_index(drop=True, inplace=True)

        return join_df

    def _retrieve_latest_time(self, time_key1, time_key2):
        """'Protected' Method to get the datetime series containing the later time from two datetime series.
            Use/Call only INSIDE the class.

        Args:
            time_key1 (string)
            time_key2 (string)

        Returns:
            pandas.core.series.Series
        """
        index_df = self.data_frame[time_key1] > self.data_frame[time_key2]
        concat_df = self.data_frame[time_key1][index_df].append(self.data_frame[time_key2][~index_df])
        concat_df = pd.DataFrame(concat_df, columns=[time_key1])
        concat_df = concat_df.reset_index().sort_values(by="index").set_index("index")
        return concat_df[time_key1]

    def save(self, filepath, filename):
        """Method to save data (DataFrame) to user-specified file path with user-defined file name.

        Args:
            filepath (string): folder path of the file to save to
            filename (string): name of a file to save as

        Returns:
            None
        """
        self.data_frame.to_csv(filepath + filename)


# example codes for calling the class and playing around
yz = YzDataClient("bruce@yangzeinvest.com", "bruce123")
# setup the class object and get data from data api by inputting index id
test_index_F30131 = Index("YA2012857").load_data(yz)
test_index_F30141 = Index("F30141").load_data(yz)
# test_index_F30141._retrieve_latest_time()
# print(test_index_F30131)
# test = Index("F30131").load_data(yz)
# print(test.data_frame)
# print("test:\n", Index("F30131").load_data(yz).data_frame)
# # performing CONSTANT addition (also works for '-', '*', '/' and '//' operations)
# add_cons = test_index_F30131 + 3.4
# print(add_cons.data_frame.head().T)
# print(test_index_F30131.data_frame)
# # performing INDEX addition (also works for '-', '*', '/' and '//' operations)
add_index = test_index_F30131 + test_index_F30141
# add_index = test_index_F30131 + 4.2
# print(add_index)
# print(add_index.data_frame)
add_index.save("D:\\Yangze_Investment\\index_manipulation\\", "add_index_new_4.0.csv")
