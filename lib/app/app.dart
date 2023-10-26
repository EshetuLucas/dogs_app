import 'package:dogs_app/api/dogs_api/get_apis.dart';
import 'package:dogs_app/services/dogs_service.dart';
import 'package:dogs_app/ui/bottom_sheets/select_item/select_item_sheet.dart';
import 'package:dogs_app/ui/views/dogs/dogs_view.dart';
import 'package:dogs_app/ui/views/show_full_image/show_full_image_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dogs_app/ui/views/startup/startup_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: DogsView),
    CustomRoute(
      page: ShowFullImageView,
      // maintainState: false,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
MaterialRoute(page: StartupView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DogsService),
    LazySingleton(classType: DogsGetApis),
  ],
  // @stacked-service

  bottomsheets: [
    StackedBottomsheet(classType: SelectItemSheet),
  ],
  // @stacked-bottom-sheet
  logger: StackedLogger(),
)
class App {}
