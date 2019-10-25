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

# print(type(zefeng_1_json), len(zefeng_1_json))
# print(zefeng_1_json[1])

# with open('D:\\Yangze_Investment\\broker_switch_log\\zefeng_1.json', 'w') as file:
#     for line in zefeng_1_json:
#         file.write(line)

# 3. Convert JSON to DataFrame format
zefeng_1_df = json.loads(zefeng_1_json[0])
print(len(zefeng_1_json))
# print(zefeng_1_df['FillField'])
# print(zefeng_1_df['FillField']['Fee'])
# print(len(zefeng_1_log))
# print(zefeng_1_log[1])
# print(zefeng_1_log[1][0:12])

# # Write extracted data into .txt file
# with open('D:\\Yangze_Investment\\broker_switch_log\\zefeng_1_FillField.txt', 'w') as file:
#     for line in zefeng_1_log:
#         file.write(line)

# with open('D:\\Yangze_Investment\\broker_switch_log\\zefeng_1.log', 'r') as f:
#     zefeng_1_log = []
#     line = f.readline()
#     while line:
#         # print(line)
#         zefeng_1_log.append(line)
#         line = f.readline()

# print("read test:", type(zefeng_1_log))
# print(zefeng_1_log)

# with open('D:\\Yangze_Investment\\broker_switch_log\\zefeng_1_test_log.txt', 'w') as f:
# #     f.write(zefeng_1_log)
# zefeng_1_log = pd.DataFrame(zefeng_1_log)
# zefeng_1_log.to_csv('D:\\Yangze_Investment\\broker_switch_log\\zefeng_1_test.csv')
