import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:luvit/model/user/user_model.dart';
import 'package:luvit/ui/common/app_colors.dart';
import 'package:luvit/ui/common/shared_styles.dart';
import 'package:luvit/ui/common/ui_helpers.dart';
import 'package:luvit/ui/widgets/image_builder.dart';
import 'package:luvit/ui/widgets/svg_builder.dart';
import 'package:luvit/utils/asset_helper.dart';
import 'package:stacked/stacked.dart';
import 'browse_viewmodel.dart';

class BrowseView extends StackedView<BrowseViewModel> {
  const BrowseView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(BrowseViewModel viewModel) {
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => viewModel.onInit());
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    BrowseViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              verticalSpaceSmall,
              Row(
                children: [
                  const SvgBuilder(
                    svg: locationLightIcon,
                    height: 28,
                    width: 28,
                  ),
                  horizontalSpaceTiny,
                  Expanded(
                    child: Text(
                      '목이길어슬픈기린님의 새로운 스팟',
                      style: ktsWhiteSmallTextStyle()
                          .copyWith(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kcVeryLightGrey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          horizontalSpace(2),
                          const SvgBuilder(
                            svg: starIcon,
                            height: 15,
                            width: 15,
                            color: kcPrimaryColor,
                          ),
                          horizontalSpaceTiny,
                          Text(
                            '323,233',
                            style: ktsWhiteSmallTextStyle().copyWith(
                                fontWeight: FontWeight.w500, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          ),
                          horizontalSpace(2),
                        ],
                      ),
                    ),
                  ),
                  const SvgBuilder(
                    svg: notificationIcon,
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
              verticalSpaceSmall,
              verticalSpaceSmall,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: viewModel.images.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '추천 드릴 친구들을 준비 중이에요',
                                style: ktsWhiteMediumTextStyle().copyWith(
                                  fontSize: 24,
                                ),
                              ),
                              verticalSpaceSmall,
                              Text(
                                '매일 새로운 친구들을 소개시켜드려요',
                                style: ktsWhiteMediumTextStyle()
                                    .copyWith(fontSize: 16, color: kcLightGrey),
                              ),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _BookPreviewCarousel(
                                user: viewModel.fakeUser,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 14, left: 33, right: 33),
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < viewModel.images.length;
                                      i++)
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: 2.5,
                                          decoration: BoxDecoration(
                                              color:
                                                  viewModel.isImageOnScreen(i)
                                                      ? kcPrimaryColor
                                                      : kcSecondarColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(100))),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: viewModel.onTapTopLeft,
                                    child: const SizedBox(
                                      height: 60,
                                      width: 40,
                                    ),
                                  ),
                                ),
                                horizontalSpaceLarge,
                                horizontalSpaceLarge,
                                Expanded(
                                  child: InkWell(
                                    onTap: viewModel.onTapTopRight,
                                    child: const SizedBox(
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                ),
              ),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }

  @override
  BrowseViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BrowseViewModel();
}

class _BookPreviewCarousel extends ViewModelWidget<BrowseViewModel> {
  final UserModel user;

  const _BookPreviewCarousel({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, BrowseViewModel model) {
    return CarouselSlider(
      key: Key(model.imageOnScreenIndex.toString()),
      carouselController: model.carouselController,
      options: CarouselOptions(
        clipBehavior: Clip.antiAlias,
        viewportFraction: 0.93,
        enableInfiniteScroll: false,
        initialPage: model.imageOnScreenIndex,
        enlargeFactor: 0.14,
        height: screenHeight(context),
        scrollPhysics: const NeverScrollableScrollPhysics(),
        enlargeCenterPage: true,
      ),
      items: model.images.map((imagePath) {
        return Container(
          decoration: BoxDecoration(
            border: model.imageOnScreenIndex == 0
                ? Border.all(color: kcSecondarColor)
                : null,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                25,
              ),
            ),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  Draggable(
                    onDragCompleted: () => model.onDragComplete(),
                    onDragEnd: (_) => model.onDragComplete(),
                    onDragUpdate: (details) => model.onDragUpdate(details),
                    feedback: Stack(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: ImageBuilder(
                            imagePath: imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: ImageBuilder(
                            imagePath: imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                        _ImageCard(
                          user: user,
                          imagePath: imagePath,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      }).toList(),
    );
  }
}

class _ImageCard extends ViewModelWidget<BrowseViewModel> {
  const _ImageCard({required this.user, required this.imagePath});

  final UserModel user;
  final String imagePath;

  @override
  Widget build(BuildContext context, BrowseViewModel model) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kcBackgroundColor.withOpacity(0.3),
              spreadRadius: 9,
              blurRadius: 14,
              offset: const Offset(
                0, // This is from X direction
                70, // This is from Y direction
              ), // changes position of the shadow to the given direction
            ),
            BoxShadow(
              color: kcBackgroundColor.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 90,
              offset: const Offset(
                1, // This is from X direction
                50, // This is from Y direction
              ), // changes position of the shadow to the given direction
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kcBackgroundColor.withOpacity(0.01),
              kcBackgroundColor.withOpacity(0.02),
              kcBackgroundColor.withOpacity(0.03),
              kcBackgroundColor.withOpacity(0.08),
              kcBackgroundColor.withOpacity(0.15),
              kcBackgroundColor.withOpacity(0.2),
              kcBackgroundColor.withOpacity(0.25),
              kcBackgroundColor.withOpacity(0.3),
              kcBackgroundColor.withOpacity(0.35),
              kcBackgroundColor.withOpacity(0.4),
              kcBackgroundColor.withOpacity(0.45),
              kcBackgroundColor.withOpacity(0.5),
              kcBackgroundColor.withOpacity(0.55),
              kcBackgroundColor.withOpacity(0.6),
              kcBackgroundColor.withOpacity(0.65),
              kcBackgroundColor.withOpacity(0.7),
              kcBackgroundColor.withOpacity(0.73),
              kcBackgroundColor.withOpacity(0.77),
              kcBackgroundColor.withOpacity(0.8),
              kcBackgroundColor.withOpacity(0.8),
              kcBackgroundColor.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: kcBackgroundColor,
                            border: Border.all(color: kcBackgroundColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              horizontalSpace(2),
                              const SvgBuilder(
                                svg: starIcon,
                                height: 15,
                                width: 15,
                                color: kcSecondarColor,
                              ),
                              horizontalSpaceTiny,
                              Text(
                                user.rating.toString(),
                                style: ktsWhiteSmallTextStyle().copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                              horizontalSpace(2),
                            ],
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Row(
                        children: [
                          Text(
                            user.fullName,
                            style: ktsWhiteMediumTextStyle(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          ),
                          horizontalSpaceTiny,
                          Text(
                            user.age.toString(),
                            style: ktsWhiteMediumTextStyle().copyWith(
                                fontSize: 24, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      verticalSpaceTiny,
                      Flexible(
                        child: image3 == imagePath
                            ? Wrap(
                                spacing: 10,
                                runSpacing: 8,
                                children: user.hobbies
                                    .map(
                                      (hobby) => Container(
                                        decoration: BoxDecoration(
                                          color: model.hasHeartEmoji(hobby)
                                              ? kcLightPrimary.withOpacity(0.6)
                                              : kcBackgroundColor,
                                          border: Border.all(
                                              color: model.hasHeartEmoji(hobby)
                                                  ? kcPrimaryColor
                                                  : kcBackgroundColor),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              100,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Text(
                                            hobby,
                                            style: ktsWhiteMediumTextStyle()
                                                .copyWith(
                                              fontSize: 15,
                                              color: model.hasHeartEmoji(hobby)
                                                  ? kcPrimaryColor
                                                  : kcWhite,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList())
                            : Row(
                                children: [
                                  if (image1 == imagePath) ...[
                                    Text(
                                      '서울 ',
                                      style: ktsWhiteMediumTextStyle().copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const Icon(
                                      Icons.circle,
                                      size: 3,
                                      color: kcWhite,
                                    ),
                                  ],
                                  Flexible(
                                    child: Text(
                                      model.getDescription(imagePath),
                                      style: ktsWhiteMediumTextStyle().copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                horizontalSpaceSmall,
                const Align(
                    alignment: Alignment.centerRight,
                    child: SvgBuilder(svg: favoriteIcon))
              ],
            ),
            verticalSpaceSmall,
            verticalSpaceSmall,
            const Icon(
              Icons.expand_more,
              color: kcWhite,
            ),
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }
}
