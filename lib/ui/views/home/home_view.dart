import 'package:flutter/material.dart';
import 'package:luvit/ui/common/app_colors.dart';
import 'package:luvit/ui/common/shared_styles.dart';
import 'package:luvit/ui/common/ui_helpers.dart';
import 'package:luvit/ui/views/browse/browse_view.dart';
import 'package:luvit/ui/views/location/location_view.dart';
import 'package:luvit/ui/widgets/svg_builder.dart';
import 'package:luvit/utils/asset_helper.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.businessId});

  final String? businessId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
          body: GetViewForIndex(
            index: model.currentIndex,
            businessId: businessId,
          ),
          bottomNavigationBar: BottomAppBar(
            color: kcBackgroundColor,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 60,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: 55,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kcSecondarColor,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: kcBackgroundColor,
                            padding: appSymmetricEdgePadding,
                            margin: const EdgeInsets.only(top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FittedBox(
                                  child: BottomNavigationBarItem(
                                      label: '홈',
                                      icon: homeIcon,
                                      isSelected: model.currentIndex == 0,
                                      context: context,
                                      onTap: () => model.setIndex(0)),
                                ),
                                FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: BottomNavigationBarItem(
                                      label: '스팟',
                                      icon: locationIcon,
                                      isSelected: model.currentIndex == 2,
                                      context: context,
                                      onTap: () => model.setIndex(2),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                  width: 50,
                                ),
                                FittedBox(
                                  child: BottomNavigationBarItem(
                                    label: '채팅',
                                    icon: messageIcon,
                                    isSelected: model.currentIndex == 1,
                                    context: context,
                                    onTap: () => model.setIndex(1),
                                  ),
                                ),
                                FittedBox(
                                  child: BottomNavigationBarItem(
                                    label: '마이',
                                    icon: profileIcon,
                                    isSelected: model.currentIndex == 3,
                                    context: context,
                                    onTap: () => model.setIndex(3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: kcSecondarColor.withOpacity(0.7),
                            width: 1.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: 60,
                      height: 38,
                      color: kcBackgroundColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.6),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: 60,
                        decoration: const BoxDecoration(
                          color: kcBackgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        height: 60,
                        child: const SvgBuilder(
                          svg: actionIcon,
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class BottomNavigationBarItem extends StatelessWidget {
  const BottomNavigationBarItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.isSelected,
      required this.context,
      this.onTap})
      : super(key: key);
  final String label;
  final String icon;
  final bool isSelected;
  final BuildContext context;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpaceTiny,
          SvgBuilder(
            height: 28,
            svg: icon,
            color: isSelected ? kcPrimaryColor : kcSecondarColor,
          ),
          verticalSpace(2),
          Text(
            label,
            style: ktsWhiteSmallTextStyle().copyWith(
              color: isSelected ? kcPrimaryColor : kcSecondarColor,
            ),
          ),
        ],
      ),
    );
  }
}

class GetViewForIndex extends StatelessWidget {
  const GetViewForIndex({Key? key, required this.index, this.businessId})
      : super(key: key);
  final int index;
  final String? businessId;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const BrowseView();
      case 1:
        return const LocationView();
      case 2:
        return const LocationView();

      default:
        return const LocationView();
    }
  }
}
