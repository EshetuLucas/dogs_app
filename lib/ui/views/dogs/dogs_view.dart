import 'package:dogs_app/data_model/fake/fake_dogs.dart';
import 'package:dogs_app/enums/fetch_type.dart';
import 'package:dogs_app/extensions/string_extensions.dart';
import 'package:dogs_app/ui/common/app_colors.dart';
import 'package:dogs_app/ui/common/shared_styles.dart';
import 'package:dogs_app/ui/common/ui_helpers.dart';
import 'package:dogs_app/ui/common/widgets/error_widget.dart';
import 'package:dogs_app/ui/views/dogs/dog_widget.dart';
import 'package:dogs_app/ui/views/dogs/dogs_viewmodel.dart';
import 'package:dogs_app/ui/common/widgets/ra_skeleton_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

part 'dogs_body.dart';
part 'dogs_header.dart';

class DogsView extends StackedView<DogsViewModel> {
  const DogsView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(DogsViewModel viewModel) {
    viewModel.getAllBreeds();

    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    DogsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkBlueBlack,
      body: AbsorbPointer(
        absorbing: viewModel.isFetchingDogs,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _DogsHeader(),
              verticalSpaceSmall,
              if (!viewModel.hasBreedsError)
                const Expanded(
                  child: _DogsBody(),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  DogsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DogsViewModel();
}
