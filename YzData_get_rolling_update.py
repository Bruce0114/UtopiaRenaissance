import pandas as pd
import datetime
from yzutil import YzDataClient

# account login and initialize the DataClient object
yz = YzDataClient("bruce@yangzeinvest.com", "bruce123")

# self-defined path
filepath = "D:\\Yangze_Investment\\roll\\data\\"

# generate  4 file types:
# main instrument with (1) & without (0) shift
# sub-main instrument with (1) & without (0) shift
file_type_tuple = [(1, 0, "Main_0"), (1, 1, "Main_1"),
                   (2, 0, "Sub_0"), (2, 1, "Sub_1")]

# a list of 5 rolling schemes
schemes = ["TEZA1", "TEZA1_1", "YANGZE_D15", "YANGZE_D25", "STX1"]

# a list of 29 rolling features
features = ["open", "high", "low", "close",
            "settle", "volume", "turnover", "deal_num",
            "change", "pct_change", "chg_settle", "pct_chg_settle",
            "swing", "vwap", "open_interest", "chg_open_interest",
            "day_open", "day_high", "day_low", "day_close",
            "day_twap", "chg_open", "chg_close", "chg_vwap",
            "chg_day_open", "chg_day_close", "chg_day_twap",
            "instrument_id", "trade_code"]

# runtime recorder
start_time_overall = datetime.datetime.now()

# looping structure
for instrument, shift, file in file_type_tuple:

    for scheme in schemes:

        start_time_scheme = datetime.datetime.now()

        for feature in features:
            start_time_feature = datetime.datetime.now()

            # check for the existence of historical data file before continue
            # print error & guiding messages and stop running the rest of the code if target file does not exist
            try:
                # read data from .h5 files
                rolling_data_df = pd.read_hdf(filepath + file + "_" + scheme + ".h5", key=feature)
            except FileNotFoundError as error:
                print(error)
                print("File containing historical data does not exist. \nRun 'YzData_get_rolling_history.py' program to obtain historical data first.")
            else:
                # identify the lastest trading day of the existing dataset
                last_date_time = datetime.datetime.strptime(rolling_data_df.index.values[-1], "%Y-%m-%d")
                # generate the date string for the next day of the lastest trading day
                next_date_time = last_date_time + datetime.timedelta(days=1)
                # convert 'datetime' type to 'str' type by calling 'strftime()'
                next_date_str = next_date_time.strftime("%Y-%m-%d")

                # update historical dataset using data API by rolling the start date 1 day forward
                rolling_data_update_df = yz.get_roll_feature(scheme, feature,
                                                             start_date=next_date_str, shift=shift,
                                                             instrument=instrument)
                # append/concatenate the updated part of dataset to historical/existing dataset
                rolling_data_df = pd.concat([rolling_data_df, rolling_data_update_df])

                end_time_feature = datetime.datetime.now()
                # print runtime for each feature
                print(f"runtime for {file}, {scheme}, {feature}:     " + f"{end_time_feature - start_time_feature}")

                # save each dataframe to hdf5 file with each rolling feature as the "key"
                rolling_data_df.to_hdf(filepath + file + "_" + scheme + ".h5", key=feature, format="table")

        end_time_scheme = datetime.datetime.now()
        print("*" * 80)
        # print runtime for each scheme
        print(f"runtime for {file}, {scheme} scheme:     " + f"{end_time_scheme - start_time_scheme}")
        print("*" * 80)

end_time_overall = datetime.datetime.now()
print("*" * 80)
# print runtime for the entire program
print(f"runtime for entire program:     " + f"{end_time_overall - start_time_overall}")
