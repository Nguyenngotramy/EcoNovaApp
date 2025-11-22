import os
import shutil
from pathlib import Path

class FlutterProjectReorganizer:
    def __init__(self, project_root='lib'):
        self.project_root = Path(project_root)
        self.backup_dir = Path('backup_lib')
        
    def create_standard_structure(self):
        """Tạo cấu trúc thư mục chuẩn cho Flutter"""
        standard_dirs = [
            'core/constants',
            'core/utils',
            'core/errors',
            'core/network',
            'data/datasources',
            'data/repositories',
            'data/models',
            'domain/entities',
            'domain/repositories',
            'domain/usecases',
            'presentation/screens',
            'presentation/widgets',
            'presentation/providers',
            'presentation/theme',
            'config',
        ]
        
        for dir_path in standard_dirs:
            (self.project_root / dir_path).mkdir(parents=True, exist_ok=True)
            print(f"✓ Đã tạo: {dir_path}")
    
    def backup_current_structure(self):
        """Backup cấu trúc hiện tại"""
        if self.project_root.exists():
            if self.backup_dir.exists():
                shutil.rmtree(self.backup_dir)
            shutil.copytree(self.project_root, self.backup_dir)
            print(f"✓ Đã backup vào: {self.backup_dir}")
    
    def move_file_safe(self, source, destination):
        """Di chuyển file an toàn"""
        try:
            source_path = Path(source)
            dest_path = Path(destination)
            
            if not source_path.exists():
                print(f"⚠ File không tồn tại: {source}")
                return False
            
            dest_path.parent.mkdir(parents=True, exist_ok=True)
            
            if dest_path.exists():
                print(f"⚠ File đã tồn tại tại đích: {destination}")
                return False
                
            shutil.move(str(source_path), str(dest_path))
            print(f"✓ Đã di chuyển: {source} -> {destination}")
            return True
        except Exception as e:
            print(f"✗ Lỗi khi di chuyển {source}: {str(e)}")
            return False
    
    def reorganize_models(self):
        """Sắp xếp lại models"""
        print("\n=== Sắp xếp Models ===")
        models_mapping = {
            'models/payment_method.dart': 'data/models/payment_method.dart',
            'models/product.dart': 'data/models/product.dart',
            'models/Product1.dart': 'data/models/product_v1.dart',
            'models/promotion.dart': 'data/models/promotion.dart',
        }
        
        for old_path, new_path in models_mapping.items():
            self.move_file_safe(
                self.project_root / old_path,
                self.project_root / new_path
            )
    
    def reorganize_screens(self):
        """Sắp xếp lại screens"""
        print("\n=== Sắp xếp Screens ===")
        # Screens đã được tổ chức tốt, chỉ cần di chuyển vào presentation
        screens_dir = self.project_root / 'screens'
        new_screens_dir = self.project_root / 'presentation/screens'
        
        if screens_dir.exists() and screens_dir != new_screens_dir:
            # Di chuyển từng thư mục con
            for role_dir in ['admin', 'auth', 'onboarding', 'seller', 'shipper', 'user']:
                old_role_path = screens_dir / role_dir
                new_role_path = new_screens_dir / role_dir
                
                if old_role_path.exists():
                    new_role_path.parent.mkdir(parents=True, exist_ok=True)
                    if not new_role_path.exists():
                        shutil.move(str(old_role_path), str(new_role_path))
                        print(f"✓ Đã di chuyển: screens/{role_dir} -> presentation/screens/{role_dir}")
    
    def reorganize_widgets(self):
        """Sắp xếp lại widgets"""
        print("\n=== Sắp xếp Widgets ===")
        widgets_dir = self.project_root / 'widgets'
        new_widgets_dir = self.project_root / 'presentation/widgets'
        
        if widgets_dir.exists() and widgets_dir != new_widgets_dir:
            # Di chuyển từng thư mục con
            widget_types = ['admin', 'dialogs', 'seller', 'shipper', 'user']
            for widget_type in widget_types:
                old_widget_path = widgets_dir / widget_type
                new_widget_path = new_widgets_dir / widget_type
                
                if old_widget_path.exists():
                    new_widget_path.parent.mkdir(parents=True, exist_ok=True)
                    if not new_widget_path.exists():
                        shutil.move(str(old_widget_path), str(new_widget_path))
                        print(f"✓ Đã di chuyển: widgets/{widget_type} -> presentation/widgets/{widget_type}")
    
    def reorganize_theme(self):
        """Sắp xếp lại theme"""
        print("\n=== Sắp xếp Theme ===")
        theme_files = [
            ('theme/app_theme.dart', 'presentation/theme/app_theme.dart'),
            ('theme/index.dart', 'presentation/theme/index.dart'),
        ]
        
        for old_path, new_path in theme_files:
            self.move_file_safe(
                self.project_root / old_path,
                self.project_root / new_path
            )
    
    def reorganize_data(self):
        """Sắp xếp lại data"""
        print("\n=== Sắp xếp Data ===")
        self.move_file_safe(
            self.project_root / 'data/mock_data.dart',
            self.project_root / 'data/datasources/mock_data.dart'
        )
    
    def reorganize_root_files(self):
        """Sắp xếp các file ở root"""
        print("\n=== Sắp xếp Root Files ===")
        
        # Cart.dart có thể là model hoặc provider
        if (self.project_root / 'Cart.dart').exists():
            self.move_file_safe(
                self.project_root / 'Cart.dart',
                self.project_root / 'presentation/providers/cart_provider.dart'
            )
        
        # main.dart giữ nguyên
        print("✓ main.dart giữ nguyên tại root")
    
    def clean_empty_directories(self):
        """Xóa các thư mục trống"""
        print("\n=== Dọn dẹp thư mục trống ===")
        for dirpath, dirnames, filenames in os.walk(self.project_root, topdown=False):
            dir_path = Path(dirpath)
            if not any(dir_path.iterdir()) and dir_path != self.project_root:
                try:
                    dir_path.rmdir()
                    print(f"✓ Đã xóa thư mục trống: {dir_path.relative_to(self.project_root)}")
                except Exception as e:
                    print(f"⚠ Không thể xóa: {dir_path.relative_to(self.project_root)}")
    
    def create_barrel_files(self):
        """Tạo các file barrel (index.dart) để export"""
        print("\n=== Tạo Barrel Files ===")
        
        important_dirs = [
            'data/models',
            'presentation/screens',
            'presentation/widgets',
            'presentation/theme',
        ]
        
        for dir_path in important_dirs:
            full_path = self.project_root / dir_path
            barrel_file = full_path / 'index.dart'
            
            if full_path.exists() and not barrel_file.exists():
                with open(barrel_file, 'w', encoding='utf-8') as f:
                    f.write(f"// Barrel file for {dir_path}\n")
                    f.write("// Export all files in this directory\n\n")
                print(f"✓ Đã tạo: {dir_path}/index.dart")
    
    def generate_structure_report(self):
        """Tạo báo cáo cấu trúc mới"""
        print("\n=== Cấu trúc mới ===")
        report_file = 'new_structure_report.txt'
        
        with open(report_file, 'w', encoding='utf-8') as f:
            f.write("CẤU TRÚC THƯ MỤC FLUTTER SAU KHI TỔ CHỨC\n")
            f.write("=" * 50 + "\n\n")
            
            for root, dirs, files in os.walk(self.project_root):
                level = root.replace(str(self.project_root), '').count(os.sep)
                indent = ' ' * 2 * level
                folder_name = os.path.basename(root)
                f.write(f'{indent}{folder_name}/\n')
                
                sub_indent = ' ' * 2 * (level + 1)
                for file in sorted(files):
                    if not file.startswith('.'):
                        f.write(f'{sub_indent}{file}\n')
        
        print(f"✓ Đã tạo báo cáo: {report_file}")
    
    def run(self):
        """Chạy toàn bộ quá trình tổ chức lại"""
        print("=" * 60)
        print("FLUTTER PROJECT REORGANIZER")
        print("=" * 60)
        
        # Backup trước
        print("\n1. Backup dự án hiện tại...")
        self.backup_current_structure()
        
        # Tạo cấu trúc chuẩn
        print("\n2. Tạo cấu trúc thư mục chuẩn...")
        self.create_standard_structure()
        
        # Sắp xếp lại từng phần
        print("\n3. Bắt đầu sắp xếp lại...")
        self.reorganize_models()
        self.reorganize_data()
        self.reorganize_theme()
        self.reorganize_screens()
        self.reorganize_widgets()
        self.reorganize_root_files()
        
        # Dọn dẹp
        print("\n4. Dọn dẹp...")
        self.clean_empty_directories()
        
        # Tạo barrel files
        print("\n5. Tạo barrel files...")
        self.create_barrel_files()
        
        # Tạo báo cáo
        print("\n6. Tạo báo cáo...")
        self.generate_structure_report()
        
        print("\n" + "=" * 60)
        print("✓ HOÀN THÀNH!")
        print("=" * 60)
        print(f"\n📁 Backup tại: {self.backup_dir}")
        print("📄 Xem báo cáo chi tiết: new_structure_report.txt")
        print("\n⚠ LƯU Ý:")
        print("- Kiểm tra lại các import trong code")
        print("- Chạy 'flutter pub get' sau khi tổ chức xong")
        print("- Kiểm tra và sửa các đường dẫn import bị lỗi")


# Chạy script
if __name__ == "__main__":
    reorganizer = FlutterProjectReorganizer()
    reorganizer.run()