
import pandas as pd
import tushare as ts
import datetime
import time

# Set up token
# only run this line for the 1st time or when needed:
# ts.set_token("a2ecd994e3833787987ca0fc216ee1cfe42e895fd37634c21b0b322b")

# Save files to user-specified filepath
filepath = "D:\\Yangze_Investment\\Tushare_Pro_Data\\"

subpath  = ["stock_series_list_ex\\",
            "stock_series_delist_ex\\",
            "stock_series_list_pre_adjust\\",
            "stock_series_list_post_adjust\\"]

# ------------  Part 1. daily series for listed stock, ex-rights & ex-dividend  ------------

# Retrieve fundamental information on stocks
data_api       = ts.pro_api()
stock_list_pro = data_api.stock_basic(exchange="", list_status="L",
                                 fields="ts_code, symbol, name, area, industry, list_date")
stock_ts_code  = stock_list_pro["ts_code"]

# code for all stocks
time_elapse_list_ex = []  # runtime recorder

start_time_overall = datetime.datetime.now()  # starting time for all stocks

for index in range(len(stock_ts_code)):

    start_time_each = datetime.datetime.now()  # starting time for individual stocks

    daily_series    = data_api.daily(ts_code=stock_ts_code[index])  # api for daily prices

    daily_series_df = pd.DataFrame(daily_series)
    daily_series_df.to_csv(filepath + "stock_series_list_ex\\" + f"{stock_ts_code[index]}" + "_series_list_ex.csv",
                           index=True, header=True)

    end_time_each = datetime.datetime.now()  # end time for individual stocks

    print(f"{stock_ts_code[index]}   " + f"{end_time_each - start_time_each}")

    # store runtime for individual stock
    time_elapse_list_ex.append(f"{stock_ts_code[index]}   " + f"{end_time_each - start_time_each}")

    # KEY: the program will hit the retrieval restriction (200 times/minute) without this sleep time
    time.sleep(0.5)

end_time_overall = datetime.datetime.now()

print(f"Overall runtime for {len(stock_ts_code)} stocks   " + f"{end_time_overall - start_time_overall}")

# create a csv file recording runtime for individual and all stocks
time_elapse_list_ex.append(f"Overall runtime for {len(stock_ts_code)}   " + f"{end_time_overall - start_time_overall}")
time_elapse_list_ex_df = pd.DataFrame(time_elapse_list_ex, columns=["runtime in seconds"])
time_elapse_list_ex_df.to_csv(filepath + "stock_series_list_ex\\" + "time_elapse_list_ex.csv", header=True)
