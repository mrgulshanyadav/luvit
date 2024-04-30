import 'package:luvit/api/get_apis.dart';
import 'package:luvit/api/post_apis.dart';
import 'package:luvit/services/user_service.dart';
import 'package:luvit/ui/views/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:luvit/ui/views/location/location_view.dart';
import 'package:luvit/ui/views/browse/browse_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: LocationView),
    MaterialRoute(page: BrowseView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: GetApis),
    LazySingleton(classType: PostApis),
    // @stacked-service
  ],
  bottomsheets: [
    // @stacked-bottom-sheet
  ],
  dialogs: [
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
