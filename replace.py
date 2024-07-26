def load_replacements(file_path):
    replacements = {}
    with open(file_path, 'r') as file:
        for line in file:
            # 忽略空白行
            if not line.strip():
                continue
            # 分割每一行，忽略"->"前后的空格
            parts = line.strip().split('->')
            if len(parts) == 2:
                old, new = parts
                replacements[old.strip()] = new.strip()
    return replacements

def replace_text(text, replacements):
    # 使用字典的get方法进行安全的查找和替换
    for old in replacements.keys():
        new = replacements[old]
        text = text.replace(old, new)
    return text

def main():
    replace_file = 'replace.txt'
    result_file = 'result.txt'
    
    # Load replacements from file
    replacements = load_replacements(replace_file)
    
    # Read the content of result.txt
    with open(result_file, 'r', encoding='utf-8') as file:
        result_text = file.read()
    
    # Replace text
    updated_text = replace_text(result_text, replacements)
    
    # Write the updated content back to result.txt
    with open(result_file, 'w', encoding='utf-8') as file:
        file.write(updated_text)
    
    print("Text has been updated and written back to", result_file)

if __name__ == "__main__":
    main()
