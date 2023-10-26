import 'package:dogs_app/app/app.locator.dart';
import 'package:dogs_app/app/app.logger.dart';
import 'package:dogs_app/ui/views/dogs/dogs_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final log = getLogger('StartupViewModel');
  final _navigationService = locator<NavigationService>();

  /// This is the function where we run starup logics like checking if the user
  /// is logged in or not, set any locally stored users preferences, dark mode - light mode
  /// and etc.
  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    _navigationService.clearStackAndShowView(const DogsView());
  }
}
