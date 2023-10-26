import 'package:dogs_app/app/app.bottomsheets.dart';
import 'package:dogs_app/app/app.router.dart';
import 'package:dogs_app/enums/fetch_type.dart';
import 'package:dogs_app/ui/common/app_strings.dart';
import 'package:dogs_app/ui/views/dogs/dogs_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dogs_app/app/app.locator.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

import '../helpers/test_helpers.dart';

const String breed = 'breed';
const String subBreed = 'subBreed';

void main() {
  DogsViewModel _getModel() => DogsViewModel();
  group('DogsViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('setSelectedBreed -', () {
      test(
          'When called with a given Breed name, should set the selected Breed name',
          () {
        final viewModel = _getModel();
        String breedName = 'Breed1';
        viewModel.setSelectedBreed(breedName);
        expect(viewModel.selectedBreed, breedName);
      });

      test(
          'When called with a given Breed name, should set the selected sub Breed name to all (default)',
          () {
        final viewModel = _getModel();
        String breedName = 'Breed1';
        viewModel.setSelectedBreed(breedName);
        expect(viewModel.selectedSubBreed, 'All');
      });
    });

    group('setSelectedSubBreed -', () {
      test(
          'When called with a given sub Breed name, should the set selected sub Breed name',
          () {
        final viewModel = _getModel();
        String subBreedName = 'SubBreed1';
        viewModel.setSelectedSubBreed(subBreedName);
        expect(viewModel.selectedSubBreed, subBreedName);
      });

      test(
          'When called with a given Breed name, should set the selected sub Breed name to all (default)',
          () {
        final viewModel = _getModel();
        String breedName = 'Breed1';
        viewModel.setSelectedBreed(breedName);
        expect(viewModel.selectedSubBreed, 'All');
      });
    });

    group('setErrorForAnObject -', () {
      test(
          'When called with a given key and value, should set the errorValue for a given key',
          () {
        final viewModel = _getModel();
        String key = 'errorKey';
        viewModel.setErrorForAnObject(key: key, value: true);
        expect(viewModel.hasErrorForObject(key), true);
      });

      test(
          'When called with [dogsError] key and [true] value, dogsError value should be true',
          () {
        final viewModel = _getModel();
        String key = 'ErrorKeyForDogs';
        viewModel.setErrorForAnObject(key: key, value: true);
        expect(viewModel.hasDogsError, true);
      });

      test(
          'When called with [dogsError] key and [false] value, dogsError error value should be false',
          () {
        final viewModel = _getModel();
        String key = 'ErrorKeyForDogs';
        viewModel.setErrorForAnObject(key: key, value: false);
        expect(viewModel.hasDogsError, false);
      });

      test(
          'When called with [breedsError] key and [true] value, breedsError value should be true',
          () {
        final viewModel = _getModel();
        String key = 'ErrorKeyForBreeds';
        viewModel.setErrorForAnObject(key: key, value: true);
        expect(viewModel.hasBreedsError, true);
      });

      test(
          'When called with [breedsError] key and [true] value, breedsError value should be false',
          () {
        final viewModel = _getModel();
        String key = 'ErrorKeyForBreeds';
        viewModel.setErrorForAnObject(key: key, value: false);
        expect(viewModel.hasBreedsError, false);
      });
    });

    group('setFetchType -', () {
      test(
          'When called with a [random] FetchType, should set the selected fetchType to [FetchType.random]',
          () {
        final viewModel = _getModel();
        FetchType randomFetchType = FetchType.random;
        viewModel.setFetchType(randomFetchType);
        expect(viewModel.selectedFetchType, randomFetchType);
      });

      test(
          'When called with [all] FetchType, should set the selected fetchType to [FetchType.all]',
          () {
        final viewModel = _getModel();
        FetchType allFetchType = FetchType.all;
        viewModel.setFetchType(allFetchType);
        expect(viewModel.selectedFetchType, allFetchType);
      });

      test(
          'When called with any fetchType while fetching dogs, should return without setting fetchType',
          () {
        final viewModel = _getModel();
        // Lets set the initial value for fetchType before fetching dogs
        FetchType allFetchType = FetchType.all;
        viewModel.setFetchType(allFetchType);
        // Fetching dogs
        viewModel.setBusyForObject('BusyKeyForDogs', true);

        FetchType randomFetchType = FetchType.random;
        viewModel.setFetchType(randomFetchType);
        // The selected fetch type should be [FetchType.all] not [FetchType.random]
        expect(viewModel.selectedFetchType, allFetchType);
      });
    });

    group('onDogCardTap -', () {
      test(
          'When called with a dog imageUrl, should navigate to show full image veiw and show full image of a dog',
          () {
        final navigationService = getAndRegisterNavigationService();
        final viewModel = _getModel();
        viewModel.onDogCardTap('imageUrl');
        verify(navigationService.navigateToShowFullImageView(
            imagePath: 'imageUrl'));
      });
    });

    group('getAllBreeds -', () {
      test(
          'When called, should call getAllBreeds function of dogsService and get all breeds list',
          () {
        final _dogsService = getAndRegisterDogsService();
        final viewModel = _getModel();
        viewModel.getAllBreeds();
        verify(
          _dogsService.getAllBreeds(),
        );
      });

      test('When called and fails, should set hasBreedsError [true]', () async {
        getAndRegisterDogsService(throwException: true);
        final viewModel = _getModel();
        await viewModel.getAllBreeds();
        expect(viewModel.hasBreedsError, true);
      });
    });

    group('getDogs -', () {
      test(
          'When called with breed, without sub breed and [all] fetchType, should call getDogs function of dogsService and get all dogs for a breed',
          () {
        final _dogsService = getAndRegisterDogsService();
        final viewModel = _getModel();
        viewModel.setSelectedBreed(breed);
        viewModel.setFetchType(FetchType.random);
        viewModel.getDogs();
        verify(
          _dogsService.getDogs(
            viewModel.selectedBreed,
            subBreed: viewModel.selectedSubBreed,
            isRandom: viewModel.isRandomFetchType,
          ),
        );
      });

      test('When called and fails, should set hasDogsError [true]', () async {
        getAndRegisterDogsService(throwException: true, subBreed: all);
        final viewModel = _getModel();
        await viewModel.getDogs();
        expect(viewModel.hasDogsError, true);
      });

      test(
          'When called with breed, without sub breed and [random] fetchType, should call getDogs function of dogsService and get random dogs for a breed',
          () {
        final _dogsService = getAndRegisterDogsService();
        final viewModel = _getModel();
        viewModel.setSelectedBreed(breed);
        viewModel.setFetchType(FetchType.random);
        viewModel.getDogs();
        verify(
          _dogsService.getDogs(
            viewModel.selectedBreed,
            subBreed: viewModel.selectedSubBreed,
            isRandom: viewModel.isRandomFetchType,
          ),
        );
      });

      test(
          'When called with breed, sub breed and [all] fetchType, should call getDogs function of dogsService and get all sub breed dogs of a breed',
          () {
        final _dogsService = getAndRegisterDogsService();
        final viewModel = _getModel();
        viewModel.setSelectedBreed('breed');
        viewModel.setSelectedBreed('subBreed');
        viewModel.setFetchType(FetchType.all);
        viewModel.getDogs();
        verify(
          _dogsService.getDogs(
            viewModel.selectedBreed,
            subBreed: viewModel.selectedSubBreed,
            isRandom: viewModel.isRandomFetchType,
          ),
        );
      });

      test(
          'When called with breed, sub breed and [random] fetchType, should call getDogs function of dogsService and get random sub breed dogs of a breed',
          () {
        final _dogsService = getAndRegisterDogsService();
        final viewModel = _getModel();
        viewModel.setSelectedBreed(breed);
        viewModel.setSelectedBreed(subBreed);
        viewModel.setFetchType(FetchType.random);
        viewModel.getDogs();
        verify(
          _dogsService.getDogs(
            viewModel.selectedBreed,
            subBreed: viewModel.selectedSubBreed,
            isRandom: viewModel.isRandomFetchType,
          ),
        );
      });
    });

    group('onSelectBreed -', () {
      test('When called, should show a bottom sheet with a list of breeds name',
          () async {
        final bottomSheetService = getAndRegisterBottomSheetService();
        final viewModel = _getModel();
        await viewModel.getAllBreeds();
        await viewModel.onSelectBreed();

        verify(
          await bottomSheetService.showCustomSheet(
            title: selectBreed,
            variant: BottomSheetType.selectItem,
            data: viewModel.breedsName,
          ),
        );
      });

      test(
          'When user selects a breed from a bottom sheet list, should set selected breed value to bottom sheet\'s result ',
          () async {
        getAndRegisterBottomSheetService(
            showCustomSheetResponse: SheetResponse(data: breed));
        final viewModel = _getModel();
        await viewModel.getAllBreeds();
        await viewModel.onSelectBreed();
        expect(viewModel.selectedBreed, breed);
      });

      test(
          'When user selects a breed from a bottom sheet list, should set selected breed value to bottom sheet\'s result and call get dogs ',
          () async {
        final _dogsService = getAndRegisterDogsService();
        getAndRegisterBottomSheetService(
            showCustomSheetResponse: SheetResponse(data: breed));

        final viewModel = _getModel();
        await viewModel.getAllBreeds();
        await viewModel.onSelectBreed();
        verify(
          _dogsService.getDogs(
            viewModel.selectedBreed,
            subBreed: viewModel.selectedSubBreed,
            isRandom: viewModel.isRandomFetchType,
          ),
        );
      });
    });

    group('onSelectSubBreed -', () {
      test(
          'When called, should show a bottom sheet with a list of sub breeds name of selected breed',
          () async {
        final bottomSheetService = getAndRegisterBottomSheetService();
        final viewModel = _getModel();
        await viewModel.getAllBreeds();
        await viewModel.onSelectSubBreed();

        verify(
          await bottomSheetService.showCustomSheet(
            title: selectSubBreed,
            variant: BottomSheetType.selectItem,
            data: viewModel.subBreedsName,
          ),
        );
      });

      test(
          'When user selects a sub breed from a bottom sheet list, should set selected sub breed value to bottom sheet\'s result ',
          () async {
        getAndRegisterBottomSheetService(
            showCustomSheetResponse: SheetResponse(data: subBreed));
        final viewModel = _getModel();
        await viewModel.getAllBreeds();
        await viewModel.onSelectSubBreed();
        expect(viewModel.selectedSubBreed, subBreed);
      });

      test(
          'When user selects a sub breed from a bottom sheet list, should set selected sub breed value to bottom sheet\'s result and call get dogs ',
          () async {
        final _dogsService = getAndRegisterDogsService();
        getAndRegisterBottomSheetService(
            showCustomSheetResponse: SheetResponse(data: breed));

        final viewModel = _getModel();
        await viewModel.getAllBreeds();
        await viewModel.onSelectSubBreed();
        verify(
          _dogsService.getDogs(
            viewModel.selectedBreed,
            subBreed: viewModel.selectedSubBreed,
            isRandom: viewModel.isRandomFetchType,
          ),
        );
      });
    });

    group('onTryAgainBreeds -', () {
      test('When called, should call getBreeds function', () async {
        final _dogsService = getAndRegisterDogsService();
        final viewModel = _getModel();
        await viewModel.onTryAgainBreeds();
        verify(
          await _dogsService.getAllBreeds(),
        );
      });
    });

    group('onTryAgainDogs -', () {
      test('When called, should call getDogs function', () async {
        final _dogsService = getAndRegisterDogsService();
        final viewModel = _getModel();
        await viewModel.onTryAgainDogs();
        verify(
          await _dogsService.getDogs(
            viewModel.selectedBreed,
            subBreed: viewModel.selectedSubBreed,
            isRandom: viewModel.isRandomFetchType,
          ),
        );
      });
    });

    group('onTryAgainDogs -', () {
      test('When f, should call getDogs function', () async {
        getAndRegisterDogsService(throwException: true);
        final viewModel = _getModel();
        await viewModel.getAllBreeds();
        expect(viewModel.hasBreedsError, true);
      });
    });
  });
}
