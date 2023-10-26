import 'package:dogs_app/api/dogs_api/get_apis.dart';
import 'package:dogs_app/data_model/fake/fake_breeds.dart';
import 'package:dogs_app/data_model/fake/fake_dogs.dart';
import 'package:dogs_app/exceptions/api_exceptions.dart';
import 'package:dogs_app/services/dogs_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dogs_app/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DogsService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DogsGetApis>(onMissingStub: OnMissingStub.returnDefault),
  // @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterDogsGetApis();
  getAndRegisterDogsService();
  // @stacked-mock-register
}

MockDogsGetApis getAndRegisterDogsGetApis() {
  _removeRegistrationIfExists<DogsService>();
  final service = MockDogsGetApis();
  locator.registerSingleton<DogsGetApis>(service);
  return service;
}

MockDogsService getAndRegisterDogsService({
  bool throwException = false,
  String breed = '',
  String subBreed = '',
  bool isRandom = false,
}) {
  _removeRegistrationIfExists<DogsService>();
  final service = MockDogsService();
  when(service.getAllBreeds()).thenAnswer((realInvocation) => Future(() {
        if (throwException) {
          throw ApiException(message: 'Something went wrong');
        }
        return FakeBreeds().generate();
      }));

  when(service.getDogs(
    breed,
    subBreed: subBreed,
    isRandom: isRandom,
  )).thenAnswer((realInvocation) => Future(() {
        if (throwException) {
          throw ApiException(message: 'Something went wrong');
        }
        return FakeDog().generate();
      }));
  locator.registerSingleton<DogsService>(service);
  return service;
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
