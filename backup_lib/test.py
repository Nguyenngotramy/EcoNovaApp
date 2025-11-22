import os

def print_directory_tree(path, prefix=""):
    """
    In cây thư mục (directory tree) của path được chỉ định.
    - path: Thư mục gốc (e.g., 'lib')
    - prefix: Để in indent (dùng đệ quy)
    """
    # Lấy danh sách file/folder, bỏ qua hidden files (bắt đầu bằng .)
    contents = [d for d in os.listdir(path) if not d.startswith('.')]
    # Tạo pointers cho tree (├── hoặc └──)
    pointers = ["├── " if i < len(contents) - 1 else "└── " for i in range(len(contents))]
    
    for pointer, content in zip(pointers, contents):
        full_path = os.path.join(path, content)
        print(prefix + pointer + content)
        
        # Nếu là folder, đệ quy in nội dung bên trong
        if os.path.isdir(full_path):
            extension = "│   " if pointer == "├── " else "    "
            print_directory_tree(full_path, prefix + extension)

# Chạy với folder 'lib'
if __name__ == "__main__":
    lib_path = 'lib'  # Thay bằng path khác nếu cần, e.g., './my_project/lib'
    if os.path.exists(lib_path):
        print(f"Cấu trúc thư mục '{lib_path}':")
        print_directory_tree(lib_path)
    else:
        print(f"Không tìm thấy folder '{lib_path}'. Kiểm tra path nhé!")