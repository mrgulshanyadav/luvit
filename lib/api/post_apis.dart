import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:luvit/api/api_client.dart';
import 'package:luvit/app/app.logger.dart';

String realTimeDateBase = dotenv.env['REAL_TIME_DATEBASE']!;
String changeDataUrl = dotenv.env['CHANGES_URL']!;

class PostApis {
  final log = getLogger('PostApis');
  ApiClient get apiClient => ApiClient();

  Future<String> changeData(String userId) async {
    log.i('userId:$userId');
    final result = await apiClient.post<String>(
      changeDataUrl,
      {},
    );

    return result;
  }
}
