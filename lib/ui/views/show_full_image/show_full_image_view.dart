import 'package:dogs_app/ui/common/widgets/placeholder_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'show_full_image_viewmodel.dart';

class ShowFullImageView extends StackedView<ShowFullImageViewModel> {
  const ShowFullImageView({
    Key? key,
    required this.imagePath,
  }) : super(key: key);
  final String imagePath;

  @override
  Widget builder(
    BuildContext context,
    ShowFullImageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: InteractiveViewer(
              maxScale: 5,
              child: Align(
                alignment: Alignment.center,
                child: PlaceholderImage(
                  errorImageUrl: '',
                  imageUrl: imagePath,
                  fit: BoxFit.contain,
                  cornerRadius: 0,
                  showGreyBackground: false,
                  placeHolder: Container(),
                ),
              )),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  ShowFullImageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShowFullImageViewModel();
}
