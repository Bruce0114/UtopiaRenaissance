import json
import pandas as pd


# Read .log data first
with open('D:\\Yangze_Investment\\broker_switch_log\\zefeng_1.log', 'r') as f:
    zefeng_1_log = []
    for line in f.readlines():
        # 1. Extract lines containing "FillField"
        if '"FillField"' in line:
            zefeng_1_log.append(line)

# 2. Throw unuseful information & only keep json-format data
zefeng_1_json = []
for item in range(len(zefeng_1_log)):
    for index in range(len(zefeng_1_log[item])):
        if zefeng_1_log[item][index:index + 3] == '{"F':
            zefeng_1_json.append(zefeng_1_log[item][index:])

# 3. Convert JSON to DataFrame format
json_list = []
for i in range(len(zefeng_1_json)):
    zefeng_1_dict = json.loads(zefeng_1_json[i])
    json_list.append(zefeng_1_dict['FillField'])

zefeng_1_dataFrame = pd.DataFrame(json_list)



