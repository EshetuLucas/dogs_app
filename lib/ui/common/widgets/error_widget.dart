import 'package:dogs_app/ui/common/app_colors.dart';
import 'package:dogs_app/ui/common/shared_styles.dart';
import 'package:dogs_app/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';

class RAErrorWidget extends StatelessWidget {
  const RAErrorWidget({
    Key? key,
    required this.onTap,
    this.errorMessage = 'Something went wrong.\nTap to try again',
    this.imagePath,
    required this.errorTitle,
  }) : super(key: key);

  final VoidCallback onTap;
  final String errorMessage;
  final String errorTitle;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                children: [
                  Text(
                    errorTitle,
                    textAlign: TextAlign.center,
                    style: ktsSemibold(context).copyWith(
                      color: kcLightBlue,
                      fontSize: 18,
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: ktsSmall(context).copyWith(
                      color: kcLightBlue,
                      fontSize: 13,
                    ),
                  ),
                  verticalSpaceSmall,
                  const Icon(
                    CupertinoIcons.refresh,
                    color: kcPrimaryColor,
                    size: 60,
                  ),
                  verticalSpaceMassive,
                  verticalSpaceLarge
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
