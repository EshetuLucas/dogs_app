#  All UI related folders, files and codes goes here 

### If you want to add a new view(page)
1. Create a folder under views 
2. Create two files (Controller and the view ) under the folder.

   ** Create a dogs page **
   1. Create a folder called dogs 
   2. Create two files under it (dogs_view.dart and dogs_viewmodel.dart)
     -- dogs_view file should only have widgets
     -- dogs_viewmodel file should only have view controller code (No widgets related codes)
   3. Then run the command below to genrate freezed.dart and g.dart files.
    flutter pub run build_runner build --delete-conflicting-outputs



