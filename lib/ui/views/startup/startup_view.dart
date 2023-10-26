import 'package:dogs_app/ui/common/shared_styles.dart';
import 'package:dogs_app/ui/common/widgets/image_builder.dart';
import 'package:dogs_app/utils/asset_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
        padding: appSymmetricEdgePadding,
        child: const Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: Center(
            child: ImageBuilder(imagePath: dogsImage),
          ),
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
