import 'package:luvit/api/get_apis.dart';
import 'package:luvit/api/post_apis.dart';
import 'package:luvit/app/app.locator.dart';
import 'package:luvit/app/app.logger.dart';

class UserService {
  final log = getLogger('UserService');
  final _postApi = locator<PostApis>();
  final _getApi = locator<GetApis>();

  ///TODO: Change change user data here.
  Future<void> changeUserData() async {
    await _postApi.changeData('userId');
  }

  ///TODO: Change change user data here.
  Future<void> checkData() async {
    await _getApi.changeData('userId');
  }
}
