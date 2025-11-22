import os
import shutil
from pathlib import Path

class FlutterStructureFixer:
    def __init__(self, project_root='lib'):
        self.project_root = Path(project_root)
        self.backup_dir = Path('backup_before_fix')
        self.issues_found = []
        self.fixes_applied = []
        
    def backup(self):
        """Backup trước khi sửa"""
        print("=" * 70)
        print("🔒 BACKUP DỰ ÁN")
        print("=" * 70)
        
        if self.backup_dir.exists():
            shutil.rmtree(self.backup_dir)
        shutil.copytree(self.project_root, self.backup_dir)
        print(f"✅ Đã backup vào: {self.backup_dir}\n")
    
    def analyze_structure(self):
        """Phân tích và tìm vấn đề"""
        print("=" * 70)
        print("🔍 PHÂN TÍCH CẤU TRÚC")
        print("=" * 70)
        
        # Kiểm tra screens trong widgets
        self._check_screens_in_widgets()
        
        # Kiểm tra models trong widgets
        self._check_models_in_widgets()
        
        # Kiểm tra file lạ
        self._check_wrong_files()
        
        # Kiểm tra thiếu thư mục
        self._check_missing_folders()
        
        # In báo cáo
        self._print_analysis_report()
        
    def _check_screens_in_widgets(self):
        """Tìm screens bị nhầm vào widgets"""
        widgets_path = self.project_root / 'presentation' / 'widgets'
        
        if not widgets_path.exists():
            return
            
        for root, dirs, files in os.walk(widgets_path):
            for file in files:
                if file.endswith('_screen.dart') or file.endswith('Screen.dart'):
                    full_path = Path(root) / file
                    rel_path = full_path.relative_to(self.project_root)
                    self.issues_found.append({
                        'type': 'SCREEN_IN_WIDGETS',
                        'file': str(rel_path),
                        'severity': 'HIGH'
                    })
    
    def _check_models_in_widgets(self):
        """Tìm models bị nhầm vào widgets"""
        widgets_path = self.project_root / 'presentation' / 'widgets'
        
        if not widgets_path.exists():
            return
            
        for root, dirs, files in os.walk(widgets_path):
            for file in files:
                if '_model.dart' in file or file == 'data':
                    full_path = Path(root) / file
                    rel_path = full_path.relative_to(self.project_root)
                    self.issues_found.append({
                        'type': 'MODEL_IN_WIDGETS',
                        'file': str(rel_path),
                        'severity': 'HIGH'
                    })
    
    def _check_wrong_files(self):
        """Tìm file sai định dạng"""
        for root, dirs, files in os.walk(self.project_root):
            for file in files:
                # File Java trong Flutter project
                if file.endswith('.java'):
                    full_path = Path(root) / file
                    rel_path = full_path.relative_to(self.project_root)
                    self.issues_found.append({
                        'type': 'WRONG_FILE_TYPE',
                        'file': str(rel_path),
                        'severity': 'HIGH'
                    })
                
                # File Python trong lib
                if file.endswith('.py') and Path(root) == self.project_root:
                    full_path = Path(root) / file
                    rel_path = full_path.relative_to(self.project_root)
                    self.issues_found.append({
                        'type': 'SCRIPT_IN_LIB',
                        'file': str(rel_path),
                        'severity': 'MEDIUM'
                    })
    
    def _check_missing_folders(self):
        """Kiểm tra thiếu thư mục quan trọng"""
        important_folders = [
            'core',
            'core/constants',
            'core/utils',
            'core/routes',
            'core/theme',
            'domain',
            'domain/entities',
            'domain/repositories',
            'domain/usecases',
        ]
        
        for folder in important_folders:
            if not (self.project_root / folder).exists():
                self.issues_found.append({
                    'type': 'MISSING_FOLDER',
                    'file': folder,
                    'severity': 'MEDIUM'
                })
    
    def _print_analysis_report(self):
        """In báo cáo phân tích"""
        print(f"\n📊 Tìm thấy {len(self.issues_found)} vấn đề:\n")
        
        # Nhóm theo loại
        by_type = {}
        for issue in self.issues_found:
            issue_type = issue['type']
            if issue_type not in by_type:
                by_type[issue_type] = []
            by_type[issue_type].append(issue)
        
        # In từng loại
        for issue_type, issues in by_type.items():
            print(f"\n🔸 {issue_type.replace('_', ' ')} ({len(issues)}):")
            for issue in issues[:5]:  # Chỉ show 5 đầu
                severity = issue['severity']
                emoji = "🔴" if severity == "HIGH" else "🟡"
                print(f"  {emoji} {issue['file']}")
            
            if len(issues) > 5:
                print(f"  ... và {len(issues) - 5} file khác")
        
        print("\n")
    
    def fix_all_issues(self):
        """Sửa tất cả vấn đề"""
        print("=" * 70)
        print("🔧 BẮT ĐẦU SỬA CHỮA")
        print("=" * 70)
        
        # 1. Di chuyển screens từ widgets sang screens
        self._fix_screens_location()
        
        # 2. Di chuyển models từ widgets sang data/models
        self._fix_models_location()
        
        # 3. Xóa file sai
        self._fix_wrong_files()
        
        # 4. Tạo thư mục thiếu
        self._fix_missing_folders()
        
        # 5. Tối ưu cấu trúc shipper
        self._fix_shipper_structure()
        
        # 6. Tối ưu cấu trúc seller
        self._fix_seller_structure()
        
        print(f"\n✅ Đã áp dụng {len(self.fixes_applied)} sửa chữa\n")
    
    def _move_file(self, source, destination):
        """Di chuyển file an toàn"""
        try:
            source_path = self.project_root / source
            dest_path = self.project_root / destination
            
            if not source_path.exists():
                return False
            
            dest_path.parent.mkdir(parents=True, exist_ok=True)
            
            if dest_path.exists():
                print(f"  ⚠️  File đã tồn tại: {destination}")
                return False
            
            shutil.move(str(source_path), str(dest_path))
            self.fixes_applied.append(f"Moved: {source} → {destination}")
            print(f"  ✅ {source} → {destination}")
            return True
            
        except Exception as e:
            print(f"  ❌ Lỗi: {source} - {str(e)}")
            return False
    
    def _fix_screens_location(self):
        """Di chuyển screens về đúng chỗ"""
        print("\n1️⃣ Di chuyển Screens từ widgets/")
        
        screen_moves = {
            # Shipper screens
            'presentation/widgets/shipper/analytics/daily_summary_screen.dart': 
                'presentation/screens/shipper/analytics/daily_summary_screen.dart',
            'presentation/widgets/shipper/analytics/income_summary_screen.dart': 
                'presentation/screens/shipper/analytics/income_summary_screen.dart',
            'presentation/widgets/shipper/analytics/monthly_summary_screen.dart': 
                'presentation/screens/shipper/analytics/monthly_summary_screen.dart',
            'presentation/widgets/shipper/deliveries/deliveries_list_screen.dart': 
                'presentation/screens/shipper/deliveries/deliveries_list_screen.dart',
            'presentation/widgets/shipper/deliveries/delivery_detail_screen.dart': 
                'presentation/screens/shipper/deliveries/delivery_detail_screen.dart',
            'presentation/widgets/shipper/notifications/notification_list_screen.dart': 
                'presentation/screens/shipper/notifications/notification_list_screen.dart',
            'presentation/widgets/shipper/profile/change_email_screen.dart': 
                'presentation/screens/shipper/profile/change_email_screen.dart',
            'presentation/widgets/shipper/profile/change_password_screen.dart': 
                'presentation/screens/shipper/profile/change_password_screen.dart',
            'presentation/widgets/shipper/profile/change_phone_screen.dart': 
                'presentation/screens/shipper/profile/change_phone_screen.dart',
            'presentation/widgets/shipper/profile/profile_screen.dart': 
                'presentation/screens/shipper/profile/profile_screen.dart',
            'presentation/widgets/shipper/profile/verify_otp_screen.dart': 
                'presentation/screens/shipper/profile/verify_otp_screen.dart',
            'presentation/widgets/shipper/report/reports_home_screen.dart': 
                'presentation/screens/shipper/report/reports_home_screen.dart',
            'presentation/widgets/shipper/search/search_shipment_screen.dart': 
                'presentation/screens/shipper/search/search_shipment_screen.dart',
                
            # Seller screens
            'presentation/widgets/seller/products/addproductscreen.dart': 
                'presentation/screens/seller/products/add_product_screen.dart',
            'presentation/widgets/seller/products/editproductscreen.dart': 
                'presentation/screens/seller/products/edit_product_screen.dart',
        }
        
        for source, dest in screen_moves.items():
            self._move_file(source, dest)
    
    def _fix_models_location(self):
        """Di chuyển models về data/models"""
        print("\n2️⃣ Di chuyển Models từ widgets/")
        
        model_moves = {
            'presentation/widgets/shipper/data/report_item_model.dart': 
                'data/models/shipper/report_item_model.dart',
            'presentation/widgets/shipper/data/report_statistics_item.dart': 
                'data/models/shipper/report_statistics_item.dart',
            'presentation/widgets/shipper/notifications/notification_item_model.dart': 
                'data/models/shipper/notification_item_model.dart',
        }
        
        for source, dest in model_moves.items():
            self._move_file(source, dest)
    
    def _fix_wrong_files(self):
        """Xóa hoặc di chuyển file sai"""
        print("\n3️⃣ Xử lý Files không phù hợp")
        
        # File Java
        java_file = self.project_root / 'presentation/widgets/shipper/report/ReportExportSheet.java'
        if java_file.exists():
            # Di chuyển ra ngoài lib
            dest = Path('android_files') / 'ReportExportSheet.java'
            dest.parent.mkdir(exist_ok=True)
            shutil.move(str(java_file), str(dest))
            print(f"  ✅ Di chuyển file Java ra: {dest}")
            self.fixes_applied.append(f"Moved Java file to: {dest}")
        
        # Script Python trong lib
        for py_file in ['reorganize_lib.py', 'test.py']:
            py_path = self.project_root / py_file
            if py_path.exists():
                dest = Path('scripts') / py_file
                dest.parent.mkdir(exist_ok=True)
                shutil.move(str(py_path), str(dest))
                print(f"  ✅ Di chuyển script Python ra: {dest}")
                self.fixes_applied.append(f"Moved Python script to: {dest}")
    
    def _fix_missing_folders(self):
        """Tạo thư mục còn thiếu"""
        print("\n4️⃣ Tạo thư mục còn thiếu")
        
        folders_to_create = [
            'core/constants',
            'core/utils',
            'core/routes',
            'core/errors',
            'core/network',
            'domain/entities',
            'domain/repositories',
            'domain/usecases',
            'data/repositories',
        ]
        
        for folder in folders_to_create:
            folder_path = self.project_root / folder
            if not folder_path.exists():
                folder_path.mkdir(parents=True, exist_ok=True)
                
                # Tạo file .gitkeep
                gitkeep = folder_path / '.gitkeep'
                gitkeep.touch()
                
                print(f"  ✅ Tạo: {folder}/")
                self.fixes_applied.append(f"Created folder: {folder}")
        
        # Di chuyển theme từ presentation sang core
        old_theme = self.project_root / 'presentation/theme'
        new_theme = self.project_root / 'core/theme'
        
        if old_theme.exists() and not new_theme.exists():
            shutil.move(str(old_theme), str(new_theme))
            print(f"  ✅ Di chuyển theme: presentation/theme → core/theme")
            self.fixes_applied.append("Moved theme to core")
    
    def _fix_shipper_structure(self):
        """Tối ưu cấu trúc shipper"""
        print("\n5️⃣ Tối ưu cấu trúc Shipper")
        
        # Widgets còn lại trong shipper nên là widgets thật
        widgets_to_keep = [
            'presentation/widgets/shipper/analytics/earning_chart_widget.dart',
            'presentation/widgets/shipper/deliveries/delivery_order.dart',
            'presentation/widgets/shipper/report/reports_date_picker.dart',
            'presentation/widgets/shipper/report/reports_export_sheet.dart',
            'presentation/widgets/shipper/report/reports_statistics.dart',
        ]
        
        print("  ℹ️  Giữ lại widgets hợp lệ:")
        for widget in widgets_to_keep:
            widget_path = self.project_root / widget
            if widget_path.exists():
                print(f"    ✓ {widget}")
    
    def _fix_seller_structure(self):
        """Tối ưu cấu trúc seller"""
        print("\n6️⃣ Tối ưu cấu trúc Seller")
        
        # Đổi tên thư mục sai chính tả
        wrong_name = self.project_root / 'presentation/widgets/seller/componnet'
        correct_name = self.project_root / 'presentation/widgets/seller/components'
        
        if wrong_name.exists() and not correct_name.exists():
            shutil.move(str(wrong_name), str(correct_name))
            print(f"  ✅ Sửa tên: componnet → components")
            self.fixes_applied.append("Fixed typo: componnet → components")
    
    def clean_empty_dirs(self):
        """Xóa thư mục trống"""
        print("\n7️⃣ Dọn dẹp thư mục trống")
        
        for root, dirs, files in os.walk(self.project_root, topdown=False):
            for dir_name in dirs:
                dir_path = Path(root) / dir_name
                try:
                    # Kiểm tra nếu chỉ có .gitkeep hoặc trống
                    contents = list(dir_path.iterdir())
                    if not contents or (len(contents) == 1 and contents[0].name == '.gitkeep'):
                        continue
                    
                    # Nếu trống thực sự thì xóa
                    if not any(dir_path.iterdir()):
                        dir_path.rmdir()
                        print(f"  ✅ Xóa: {dir_path.relative_to(self.project_root)}/")
                except:
                    pass
    
    def create_index_files(self):
        """Tạo index.dart cho các thư mục quan trọng"""
        print("\n8️⃣ Tạo index.dart (barrel files)")
        
        important_dirs = [
            'core/constants',
            'core/utils',
            'data/models',
            'data/models/shipper',
            'presentation/screens/admin',
            'presentation/screens/seller',
            'presentation/screens/shipper',
            'presentation/screens/user',
        ]
        
        for dir_path in important_dirs:
            full_path = self.project_root / dir_path
            index_file = full_path / 'index.dart'
            
            if full_path.exists() and not index_file.exists():
                with open(index_file, 'w', encoding='utf-8') as f:
                    f.write(f"// Barrel file for {dir_path}\n")
                    f.write(f"// Auto-export all files\n\n")
                print(f"  ✅ Tạo: {dir_path}/index.dart")
    
    def generate_final_report(self):
        """Tạo báo cáo cuối cùng"""
        print("\n" + "=" * 70)
        print("📋 BÁO CÁO HOÀN THÀNH")
        print("=" * 70)
        
        report_file = 'structure_fix_report.md'
        
        with open(report_file, 'w', encoding='utf-8') as f:
            f.write("# 📊 BÁO CÁO SỬA CHỮA CẤU TRÚC FLUTTER\n\n")
            f.write(f"## Tổng quan\n")
            f.write(f"- ❗ Vấn đề tìm thấy: **{len(self.issues_found)}**\n")
            f.write(f"- ✅ Đã sửa: **{len(self.fixes_applied)}**\n\n")
            
            f.write("## Chi tiết sửa chữa\n\n")
            for i, fix in enumerate(self.fixes_applied, 1):
                f.write(f"{i}. {fix}\n")
            
            f.write("\n## Cấu trúc mới\n\n")
            f.write("```\n")
            for root, dirs, files in os.walk(self.project_root):
                level = root.replace(str(self.project_root), '').count(os.sep)
                indent = '  ' * level
                folder_name = os.path.basename(root) or 'lib'
                f.write(f'{indent}{folder_name}/\n')
                
                sub_indent = '  ' * (level + 1)
                for file in sorted(files):
                    if not file.startswith('.'):
                        f.write(f'{sub_indent}{file}\n')
            f.write("```\n")
        
        print(f"✅ Đã tạo báo cáo: {report_file}")
    
    def run(self):
        """Chạy toàn bộ quy trình"""
        print("\n")
        print("╔" + "═" * 68 + "╗")
        print("║" + " " * 15 + "FLUTTER STRUCTURE FIXER" + " " * 30 + "║")
        print("╚" + "═" * 68 + "╝")
        print("\n")
        
        # Bước 1: Backup
        self.backup()
        
        # Bước 2: Phân tích
        self.analyze_structure()
        
        # Xác nhận
        confirm = input("⚠️  Tiếp tục sửa chữa? (y/n): ").lower()
        if confirm != 'y':
            print("❌ Đã hủy!")
            return
        
        # Bước 3: Sửa chữa
        self.fix_all_issues()
        
        # Bước 4: Dọn dẹp
        self.clean_empty_dirs()
        
        # Bước 5: Tạo index files
        self.create_index_files()
        
        # Bước 6: Báo cáo
        self.generate_final_report()
        
        print("\n" + "=" * 70)
        print("✨ HOÀN THÀNH! CẤU TRÚC ĐÃ ĐƯỢC TỐI ƯU HÓA")
        print("=" * 70)
        print(f"\n📁 Backup: {self.backup_dir}/")
        print(f"📄 Báo cáo: structure_fix_report.md")
        print("\n⚠️  QUAN TRỌNG:")
        print("1. Kiểm tra và sửa imports trong code")
        print("2. Chạy: flutter pub get")
        print("3. Chạy: flutter analyze")
        print("4. Test lại ứng dụng")
        print("\n")


if __name__ == "__main__":
    fixer = FlutterStructureFixer()
    fixer.run()