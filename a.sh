#!/bin/bash

# 定义Python脚本
python_script=$(cat << 'ENDPYTHON'
import re

replace_str = """
Remote Branch -> Remote Brsssanxietianch
[\\r]?\\n[^\\n]*NodeLooperThrea: type=1400 audit -> abcd: type=1400 audit
"""

def load_replacements(replace_str):
    replacements = []
    for line in replace_str.strip().split('\n'):
        parts = line.strip().split('->')
        if len(parts) == 2:
            old, new = parts
            old = old.strip()
            new = new.strip()
            pattern = re.compile(old, re.MULTILINE | re.DOTALL)
            replacements.append((pattern, new))
    return replacements

def replace_text(text, replacements):
    for pattern, new in replacements:
        text = pattern.sub(new, text)
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

