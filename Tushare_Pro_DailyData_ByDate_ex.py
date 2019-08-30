
import pandas as pd
import tushare as ts
import datetime
import time
from datetime import date
from matplotlib.dates import drange

# Set up token
# only run this line for the 1st time or when needed:
# ts.set_token("a2ecd994e3833787987ca0fc216ee1cfe42e895fd37634c21b0b322b")

# Save files to user-specified filepath
filepath = "D:\\Yangze_Investment\\Tushare_Pro_Data\\"

subpath  = ["stock_series_by_date_ex\\",
            "stock_series_by_date_adjust\\"
            ]

# Retrieve fundamental information on LISTED ("L") stocks
data_api       = ts.pro_api()
stock_list_pro = data_api.stock_basic(exchange="", list_status="L",
                                 fields="ts_code, symbol, name, area, industry, list_date")
stock_ts_code  = stock_list_pro["ts_code"]

# code for all stocks

# create dates list
# count one day forward from today in order to get the dates list from start date up to "today"
end = datetime.date.today() + datetime.timedelta(days=1)
start = date(2019, 8, 12)  # set date(YYYY, M, D) as the start date for data retrival
delta = datetime.timedelta(days=1) # set increment as one day
float_date_list = drange(start, end, delta)
date_list = []
for day in range(len(float_date_list)):
    # create a dates list with YYYYMMDD date format
    date_list.append(date.fromordinal(int(float_date_list[day])).strftime("%Y%m%d"))

time_elapse_list_ex = []  # runtime recorder

start_time_overall = datetime.datetime.now()  # starting time for all stocks

for date in range(len(date_list)):
    daily_series_concat = pd.DataFrame()
    for index in range(3):

        start_time_each = datetime.datetime.now()  # starting time for individual stocks

        # api for daily prices
        daily_series  = data_api.daily(ts_code=stock_ts_code[index], start_date=date_list[date], end_date=date_list[date])

        # append data from each stock together to generate data on all stocks for a given date
        daily_series_concat = pd.concat([daily_series_concat, daily_series])

        end_time_each = datetime.datetime.now()  # end time for individual stocks

        print(f"{stock_ts_code[index]}   " + f"{end_time_each - start_time_each}")

        # store runtime for individual stock
        time_elapse_list_ex.append(f"{stock_ts_code[index]}   " + f"{end_time_each - start_time_each}")

        # KEY: the program will hit the retrieval restriction (200 times/minute) without this sleep time
        time.sleep(0.5)

    daily_series_df = pd.DataFrame(daily_series_concat)
    daily_series_df.to_csv(filepath + subpath[0] + date_list[date] + "_series_all_stocks_ex.csv",
                               index=False, header=True)

    print("*" * 12 + " " + f"data for {date_list[date]}" + " " + "*" * 12)
    print("*" * 43)

end_time_overall = datetime.datetime.now()

print(f"Overall runtime for {len(stock_ts_code)} listed stocks from {date_list[0]} to {date_list[-1]}   " + f"{end_time_overall - start_time_overall}")

# create a csv file recording runtime for individual and all stocks
time_elapse_list_ex.append(f"Overall runtime for {len(stock_ts_code)} listed stocks from {date_list[0]} to {date_list[-1]}   " + f"{end_time_overall - start_time_overall}")
time_elapse_list_ex_df = pd.DataFrame(time_elapse_list_ex, columns=["runtime in seconds"])
time_elapse_list_ex_df.to_csv(filepath + subpath[0] + "time_elapse_daily_listed_by_date_ex.csv", header=True)



# Retrieve fundamental information on DELISTED ("D") stocks
# data_api       = ts.pro_api()
# stock_list_pro = data_api.stock_basic(exchange="", list_status="D",
#                                  fields="ts_code, symbol, name, area, industry, list_date")
# stock_ts_code  = stock_list_pro["ts_code"]
