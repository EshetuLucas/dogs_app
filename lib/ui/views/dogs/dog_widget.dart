import 'package:dogs_app/ui/common/app_colors.dart';
import 'package:dogs_app/ui/common/widgets/image_builder.dart';
import 'package:dogs_app/ui/common/widgets/placeholder_image.dart';
import 'package:dogs_app/ui/common/widgets/ra_skeleton_loader.dart';
import 'package:dogs_app/utils/asset_helper.dart';
import 'package:flutter/material.dart';

class DogListItem extends StatelessWidget {
  final bool busy;
  final String imageUrl;
  const DogListItem({
    Key? key,
    required this.imageUrl,
    required this.busy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: Card(
        elevation: 5,
        color: kcBlue.withOpacity(0.1),
        shadowColor: kcLightBlue.withOpacity(0.01),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: RASkeletonLoader(
            loading: busy,
            child: PlaceholderImage(
              showGreyBackground: false,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              roundedCorners: true,
              cornerRadius: 4,
              errorWidget: (context, string, something) => const Center(
                child: ImageBuilder(imagePath: errorImage),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
