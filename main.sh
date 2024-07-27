#!/bin/bash

# main.sh

# 定义Python脚本
python_script=$(cat << 'ENDPYTHON'
import re

replace_str = """
pre-creating -> xiepre-creatingsss
Key exists -> xieKey existsss
ADB -> adb
xiao -> xie
sksda -> sndalsdn
snd,sds -> sdjkalsdan
vold_prepare_subdirs.*\r\n.*prepare -> prepare
B.*\\r?\\nE -> xietian
C.*\\r?\\nE -> KK
"""

def load_replacements(replace_str):
    replacements = {}
    for line in replace_str.strip().split('\n'):
        parts = line.strip().split('->')
        if len(parts) == 2:
            old, new = parts
            # 生成正确的正则表达式模式
            pattern = r'(?m)' + re.escape(old)
            replacements[pattern] = new.strip()
    return replacements

def replace_text(text, replacements):
    for pattern, new in replacements.items():
        # 使用正确的正则表达式模式进行替换
        text = re.sub(pattern, new, text)
    return text

def main(replace_str, result_file):
    replacements = load_replacements(replace_str)
    with open(result_file, 'r', encoding='utf-8') as file:
        text = file.read()
    updated_text = replace_text(text, replacements)
    with open(result_file, 'w', encoding='utf-8') as file:
        file.write(updated_text)

if __name__ == "__main__":
    result_file = "result.txt"
    main(replace_str, result_file)
ENDPYTHON
)

echo "$python_script" | python
