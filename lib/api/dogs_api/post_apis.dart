import 'package:dogs_app/api/common/api_client.dart';
import 'package:dogs_app/app/app.logger.dart';

class DogsPostApis {
  final log = getLogger('PostApis');
  ApiClient get apiClient => ApiClient();
}
