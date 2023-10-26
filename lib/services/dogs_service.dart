import 'package:dogs_app/api/dogs_api/get_apis.dart';
import 'package:dogs_app/app/app.locator.dart';
import 'package:dogs_app/app/app.logger.dart';
import 'package:dogs_app/data_model/breed/breeds.dart';
import 'package:dogs_app/data_model/dogs/dogs.dart';
import 'package:dogs_app/ui/common/app_strings.dart';

class DogsService {
  final log = getLogger('DogsService');
  final _getApi = locator<DogsGetApis>();

  Future<Breeds> getAllBreeds() async {
    return await _getApi.getAllBreeds();
  }

  Future<Dogs> getDogs(
    String breed, {
    String subBreed = '',
    bool isRandom = false,
  }) async {
    return await _getApi.getDogs(
      breed,
      isRandom: isRandom,
      subBreed: subBreed == all ? '' : subBreed,
    );
  }
}
