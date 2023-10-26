import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogs_app/ui/common/app_colors.dart';
import 'package:dogs_app/utils/asset_helper.dart';
import 'package:flutter/material.dart';
import 'package:dogs_app/ui/common/shared_styles.dart';
import 'package:dogs_app/ui/common/widgets/ra_skeleton_loader.dart';
import '../ui_helpers.dart';

class PlaceholderImage extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final bool showGreyBackground;
  final BoxFit fit;
  final bool roundedCorners;
  final double cornerRadius;
  final String errorImageUrl;
  final Widget placeHolder;

  const PlaceholderImage({
    Key? key,
    required this.imageUrl,
    this.errorWidget,
    this.showGreyBackground = true,
    this.roundedCorners = true,
    this.fit = BoxFit.contain,
    this.cornerRadius = 100,
    this.placeHolder = const RASkeletonLoader(
      child: SizedBox(height: double.maxFinite, width: double.maxFinite),
      loading: true,
    ),
    this.errorImageUrl = errorImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(roundedCorners ? cornerRadius : 0),
      child: Container(
        decoration: const BoxDecoration(color: kcDarkBlueBlack),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _image((imageUrl).contains('assets/')),
        ),
      ),
    );
  }

  Widget _image(bool isFromFile) {
    if (isFromFile) {
      return Image.asset(
        imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: fit,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: double.infinity,
        placeholder: (context, url) => placeHolder,
        errorWidget: errorWidget ??
            (context, url, error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    verticalSpaceTiny,
                    Text(
                      'Unable to load image',
                      style: ktsSmall(context).copyWith(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    )
                  ],
                ),
        fit: fit,
      );
    }
  }
}
