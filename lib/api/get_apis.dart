import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:luvit/api/api_client.dart';
import 'package:luvit/api/post_apis.dart';
import 'package:luvit/app/app.logger.dart';

class GetApis {
  final log = getLogger('PostApis');
  ApiClient get apiClient => ApiClient();
  Future<String> changeData(String userId) async {
    log.i('userId:$userId');
    final result = await apiClient.get<String>(
      realTimeDateBase,
    );

    return result;
  }
}
