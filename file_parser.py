import struct
import os

def read_upgrade_bin(file_path):
    with open(file_path, 'rb') as f:
        # 读取 total_size 和 Component_count
        total_size = struct.unpack('i', f.read(4))[0]
        component_count = struct.unpack('i', f.read(4))[0]
        
        # 读取 hash_value
        hash_value = f.read(32)

        print(f'Total Size: {total_size}')
        print(f'Component Count: {component_count}')
        print(f'Hash Value: {hash_value.hex()}')

        components = []

        for i in range(component_count):
            # 读取 ComponentN_name
            component_name = f.read(32).decode('utf-8').strip('\x00')
            # 读取 ComponentN_id
            component_id = struct.unpack('i', f.read(4))[0]
            # 读取 ComponentN_hash_value
            component_hash_value = f.read(32)
            # 读取 ComponentN_size
            component_size = struct.unpack('i', f.read(4))[0]
            # 读取 ComponentN_content
            component_content = f.read(component_size)

            # 保存组件信息
            components.append({
                'name': component_name,
                'id': component_id,
                'hash_value': component_hash_value,
                'size': component_size,
                'content': component_content
            })

            # 将每个组件写入单独的文件
            component_file_path = f'Component{i + 1}.bin'
            with open(component_file_path, 'wb') as component_file:
                component_file.write(component_content)

            print(f'Component {i + 1}:')
            print(f' - Name: {component_name}')
            print(f' - ID: {component_id}')
            print(f' - Hash Value: {component_hash_value.hex()}')
            print(f' - Size: {component_size}')
            print(f' - Content saved to: {component_file_path}')

if __name__ == '__main__':
    file_path = 'upgrade.bin'
    read_upgrade_bin(file_path)
