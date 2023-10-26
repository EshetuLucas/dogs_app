import 'dart:ui';

import 'package:dogs_app/ui/common/app_colors.dart';
import 'package:dogs_app/ui/common/widgets/decorated_container.dart';
import 'package:flutter/material.dart';

class FrostedBottomSheet extends StatelessWidget {
  final Widget? child;
  final double blurValue;
  final bool hasDraggableIndicator;
  final BorderRadius borderRadius;
  final Color? backgroundColor;

  const FrostedBottomSheet({
    Key? key,
    this.child,
    this.hasDraggableIndicator = true,
    this.blurValue = 6,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: kcDarkBlueBlack.withOpacity(0.85),
        borderRadius: borderRadius,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurValue,
          sigmaY: blurValue,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasDraggableIndicator)
              const Center(
                child: _DraggableBottomSheetIndicator(),
              ),
            if (child != null) Flexible(child: child!),
          ],
        ),
      ),
    );
  }
}

class _DraggableBottomSheetIndicator extends StatelessWidget {
  const _DraggableBottomSheetIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: DecoratedContainer(
        shadowColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 1,
        child: const SizedBox(
          width: 48,
          height: 4,
        ),
      ),
    );
  }
}
