import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'location_viewmodel.dart';

class LocationView extends StackedView<LocationViewModel> {
  const LocationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LocationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  LocationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LocationViewModel();
}
