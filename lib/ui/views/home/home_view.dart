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
              // alignment: Alignment.bottomCenter,
              //color: kcGrey,
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
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: kcSecondarColor,
                            //   ),
                            //   borderRadius: const BorderRadius.only(
                            //     topLeft: Radius.circular(12),
                            //     topRight: Radius.circular(12),
                            //   ),
                            // ),
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



/*

import 'package:flutter/material.dart';
import 'package:luvit/ui/common/shared_styles.dart';
import 'package:luvit/ui/common/ui_helpers.dart';
import 'package:luvit/ui/views/browse/browse_view.dart';
import 'package:luvit/ui/views/location/location_view.dart';
import 'package:stacked/stacked.dart';
import 'package:get/get.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.businessId});

  final String? businessId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.initFCM(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () {
          model.killAppConfirmation();
          return Future.value(false);
        },
        child: Scaffold(
            body: GetViewForIndex(
              index: model.currentIndex,
              businessId: businessId,
            ),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).colorScheme.tertiary,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: const CircularNotchedRectangle(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: !model.showEntryBadge ? 0 : 30,
                    child: DecoratedContainer(
                        withCard: false,
                        containerColor: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.8),
                        shadowColor: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.3),
                        borderColor: !model.showEntryBadge
                            ? null
                            : Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.2),
                        shadowOpacity: 0.01,
                        borderRadius: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FittedBox(child: Icon(Icons.check)),
                              horizontalSpaceSmall,
                              FittedBox(
                                  child: Text(
                                model.entryBadgeText.tr,
                              )),
                            ],
                          ),
                        )),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          child: BottomNavigationBarItem(
                            label: 'home'.tr,
                            icon: home,
                            isSelected: model.currentIndex == 0,
                            context: context,
                            onTap: () {
                              model.onHomeIconTap();
                              model.setIndex(0);
                            },
                          ),
                        ),
                        FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: BottomNavigationBarItem(
                              label: 'notifications'.tr,
                              icon: notification,
                              isSelected: model.currentIndex == 2,
                              context: context,
                              onTap: () => model.setIndex(2),
                            ),
                          ),
                        ),
                        FittedBox(
                          child: BottomNavigationBarItem(
                            label: 'insights'.tr,
                            icon: insights,
                            isSelected: model.currentIndex == 1,
                            context: context,
                            onTap: () =>
                                model.setIndex(model.isFetchingEntries ? 0 : 1),
                          ),
                        ),
                        FittedBox(
                          child: BottomNavigationBarItem(
                            label: 'profile'.tr,
                            icon: profile,
                            isSelected: model.currentIndex == 3,
                            context: context,
                            onTap: () => model.setIndex(3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (model.showUpdateBadge)
                    Dismissible(
                      onDismissed: (_) => model.onCloseUpdateBadge(),
                      key: Key(model.showUpdateBadge.toString()),
                      child: Container(
                        margin: const EdgeInsets.only(top: 2),
                        height: 40,
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        child: Row(
                          children: [
                            horizontalSpaceSmall,
                            Icon(
                              Icons.download_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 25,
                            ),
                            horizontalSpaceSmall,
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'new_version_update'.tr,
                                    style: ktsSmall(context).copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            horizontalSpaceTiny,
                            InkWell(
                              onTap: model.onCloseUpdateBadge,
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    Icons.close,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  )),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            )),
      ),
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
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Visibility(
              //   maintainSize: true,
              //   maintainAnimation: true,
              //   maintainState: true,
              //   visible: isSelected,
              //   child: AnimatedContainer(
              //     height: 3,
              //     width: screenWidth(context) / 10,
              //     curve: Curves.easeIn,
              //     duration: const Duration(milliseconds: 300),
              //     decoration: BoxDecoration(
              //       color: Theme.of(context).colorScheme. primary,
              //       borderRadius: BorderRadius.circular(40),
              //     ),
              //   ),
              // ),
              verticalSpaceTiny,
              SvgBuilder(
                height: isSelected ? 21 : 19,
                svg: icon,
                color:
                    isSelected ? Theme.of(context).colorScheme.primary : kcGrey,
              ),
              verticalSpace(2),
              Text(
                label,
                style: ktsWhiteMediumTextStyle(context).copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiaryContainer,
                ),
              ),
            ],
          ),
        ),
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


*/