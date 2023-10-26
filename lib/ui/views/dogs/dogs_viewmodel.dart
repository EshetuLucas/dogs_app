import 'package:dogs_app/app/app.bottomsheets.dart';
import 'package:dogs_app/app/app.locator.dart';
import 'package:dogs_app/app/app.router.dart';
import 'package:dogs_app/data_model/breed/breeds.dart';
import 'package:dogs_app/enums/fetch_type.dart';
import 'package:dogs_app/exceptions/api_exceptions.dart';
import 'package:dogs_app/services/dogs_service.dart';
import 'package:dogs_app/ui/common/app_strings.dart';
import 'package:dogs_app/app/app.logger.dart';
import 'package:dogs_app/data_model/dogs/dogs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

const String _busyKeyForDogs = 'BusyKeyForDogs';
const String _errorKeyForDogs = 'ErrorKeyForDogs';
const String _errorKeyForBreeds = 'ErrorKeyForBreeds';

class DogsViewModel extends BaseViewModel {
  final log = getLogger('BrowseViewModel');
  final _dogsService = locator<DogsService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  Breeds _breeds = Breeds();
  Breeds get breeds => _breeds;

  Dogs _dogs = Dogs();

  String _selectedBreed = '';
  String get selectedBreed => isBusy ? '' : _selectedBreed;

  String errorText = '';
  String _selectedSubBreed = all;
  String get selectedSubBreed => isBusy ? '' : _selectedSubBreed;

  FetchType _selectedFetchType = FetchType.all;
  FetchType get selectedFetchType => _selectedFetchType;

  bool get isFetchingDogs => isBusy || busy(_busyKeyForDogs);
  bool get hasDogsError => hasErrorForObject(_errorKeyForDogs);
  bool get hasBreedsError => hasErrorForObject(_errorKeyForBreeds);
  bool get isRandomFetchType => _selectedFetchType == FetchType.random;
  bool get hasSubBreed => isBusy ? false : subBreeds(_selectedBreed).length > 1;
  bool isFetchTypeSelected(FetchType type) => _selectedFetchType == type;
  bool hasErrorForObject(String key) => errors[key] ?? false;

  List<String> get dogs => _dogs.imageUrls;
  List<String> get breedsName => breeds.allBreeds.keys.toList();
  List<String> get subBreedsName => [all, ...subBreeds(_selectedBreed)];
  List<String> subBreeds(String breed) => breeds.allBreeds[breed] ?? [];

  Map<String, bool> errors = {};

  void setSelectedBreed(String name) {
    _selectedBreed = name;
    // Set sub breed value to default when breed value changed.
    _selectedSubBreed = all;
    notifyListeners();
  }

  void setSelectedSubBreed(String name) {
    _selectedSubBreed = name;
    notifyListeners();
  }

  void setErrorForAnObject({
    required String key,
    required bool value,
  }) {
    errors[key] = value;
    notifyListeners();
  }

  void setFetchType(FetchType value) {
    // Do nothing if the view is fetching dogs
    if (isFetchingDogs) return;
    _selectedFetchType = value;
    notifyListeners();

    // We don't have to await this kinda calls because the function sets the view to load and shows
    // the loading animation till get the data.
    if (hasDogsError) {
      onTryAgainDogs();
    } else {
      getDogs();
    }
  }

  void onDogCardTap(String imagePath) =>
      _navigationService.navigateToShowFullImageView(
        imagePath: imagePath,
      );

  Future<void> getAllBreeds() async {
    try {
      setBusy(true);
      _breeds = await _dogsService.getAllBreeds();
      _selectedBreed = breedsName.first;
      await getDogs();
    } on ApiException catch (e) {
      errorText = e.message ?? someThingWentWrong;
      setErrorForAnObject(
        key: _errorKeyForBreeds,
        value: true,
      );
      log.e('Unable to fetch all breeds:$e');
    } catch (e) {
      errorText = someThingWentWrong;
      setErrorForAnObject(key: _errorKeyForBreeds, value: true);
      log.e('Unkown:$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> getDogs() async {
    try {
      setBusyForObject(_busyKeyForDogs, true);
      _dogs = await _dogsService.getDogs(
        _selectedBreed,
        isRandom: isRandomFetchType,
        subBreed: _selectedSubBreed,
      );
    } on ApiException catch (e) {
      errorText = e.message ?? someThingWentWrong;
      setErrorForAnObject(
        key: _errorKeyForDogs,
        value: true,
      );
      log.e('Unable to fetch selected breed\'s images:$e');
    } catch (e) {
      errorText = someThingWentWrong;
      setErrorForAnObject(key: _errorKeyForDogs, value: true);
      log.e('Unkown:$e');
    } finally {
      setBusyForObject(_busyKeyForDogs, false);
    }
  }

  Future<void> onSelectBreed() async {
    final result = await _bottomSheetService.showCustomSheet(
      title: selectBreed,
      variant: BottomSheetType.selectItem,
      data: breedsName,
    );
    if (result?.data == null) return;
    setSelectedBreed(result!.data);
    getDogs();
  }

  Future<void> onSelectSubBreed() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.selectItem,
      title: selectSubBreed,
      data: subBreedsName,
    );

    if (result?.data == null) return;
    setSelectedSubBreed(result!.data);
    getDogs();
  }

  // We could have called getDogs when user taps on Try again,
  // But we need to add some delay for the sake of UX.
  // And after showing loading effect we will call [getDogs]
  Future<void> onTryAgainDogs() async {
    setErrorForAnObject(key: _errorKeyForDogs, value: false);
    setBusyForObject(_busyKeyForDogs, true);
    await Future.delayed(const Duration(
      milliseconds: 500,
    ));
    await getDogs();
  }

  Future<void> onTryAgainBreeds() async {
    setErrorForAnObject(key: _errorKeyForBreeds, value: false);
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 500));
    await getAllBreeds();
  }
}
