import json
import pandas as pd


def log_to_data_frame(filepath):
    # Read .log data first
    with open(filepath, 'r') as f:
        fund_log = []
        for line in f.readlines():
            # 1. Extract lines containing "FillField"
            if '"FillField"' in line:
                fund_log.append(line)

    # 2. Throw unuseful information & only keep json-format data
    fund_json = []
    for item in range(len(fund_log)):
        for index in range(len(fund_log[item])):
            if fund_log[item][index:index + 3] == '{"F':
                fund_json.append(fund_log[item][index:])

    # 3. Convert JSON to DataFrame format
    json_list = []
    for i in range(len(fund_json)):
        fund_dict = json.loads(fund_json[i])
        json_list.append(fund_dict['FillField'])

    fund_data_frame = pd.DataFrame(json_list)

    return fund_data_frame


if __name__ == '__main__':
    filepath =['D:\\Yangze_Investment\\broker_switch_log\\zefeng_1.log',
               'D:\\Yangze_Investment\\broker_switch_log\\zeyuan.log']

    zefeng_1_df = log_to_data_frame(filepath[0])
    zeyuan_df = log_to_data_frame(filepath[1])


