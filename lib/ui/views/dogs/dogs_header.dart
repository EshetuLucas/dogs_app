part of 'dogs_view.dart';

class _DogsHeader extends ViewModelWidget<DogsViewModel> {
  const _DogsHeader();

  @override
  Widget build(BuildContext context, DogsViewModel viewModel) {
    return Padding(
      padding: appSymmetricEdgePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceSmall,
                  Text(
                    'Welcome',
                    style: ktsBoldMeidumDarkTextStyle(context).copyWith(
                      color: kcPrimaryColor,
                      fontSize: 23,
                    ),
                  ),
                  Text(
                    'Let\'s find you a dog',
                    style: ktsBoldMeidumDarkTextStyle(context).copyWith(
                      color: kcLightBlue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (!viewModel.hasBreedsError)
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: _HeaderSlidingSegment(),
                ),
              horizontalSpaceSmall,
            ],
          ),
          verticalSpaceMedium,
          if (viewModel.hasBreedsError)
            RAErrorWidget(
              errorTitle: 'Unable to fetch breeds.',
              onTap: viewModel.onTryAgainBreeds,
              errorMessage: '${viewModel.errorText}.\nTap to try again',
            )
          else
            Row(
              children: [
                Expanded(
                  child: _Filter(
                    title: 'Breed',
                    value: viewModel.selectedBreed.capitalizeFirstLetter,
                    isBusy: viewModel.isBusy,
                    onTap: viewModel.onSelectBreed,
                  ),
                ),
                if (viewModel.hasSubBreed) ...[
                  horizontalSpaceMedium,
                  Expanded(
                    child: _Filter(
                      title: 'Sub Breed',
                      value: viewModel.selectedSubBreed.capitalizeFirstLetter,
                      isBusy: viewModel.isBusy,
                      onTap: viewModel.onSelectSubBreed,
                    ),
                  ),
                ]
              ],
            ),
        ],
      ),
    );
  }
}

class _Filter extends StatelessWidget {
  const _Filter({
    required this.onTap,
    required this.title,
    required this.isBusy,
    required this.value,
  });

  final VoidCallback? onTap;
  final String title;
  final bool isBusy;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ktsSemibold(context).copyWith(color: kcWhite, fontSize: 12),
          ),
          verticalSpaceTiny,
          RASkeletonLoader(
            loading: isBusy,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: Border.all(
                    color: kcLightBlue,
                  )),
              child: Row(
                children: [
                  horizontalSpaceTiny,
                  Text(
                    value,
                    style: ktsSmall(context)
                        .copyWith(color: kcWhite, fontSize: 14),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.expand_more_outlined,
                    color: kcLightBlue,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderSlidingSegment extends ViewModelWidget<DogsViewModel> {
  const _HeaderSlidingSegment();

  @override
  Widget build(BuildContext context, DogsViewModel viewModel) {
    return RASkeletonLoader(
      loading: viewModel.isBusy,
      child: CupertinoSlidingSegmentedControl<FetchType>(
        groupValue: viewModel.selectedFetchType,
        backgroundColor: kcLightBlueBlack,
        thumbColor: kcDarkBlueBlack,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        children: <FetchType, Widget>{
          for (var segment in FetchType.values)
            segment: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                segment.name.capitalizeFirstLetter,
                style: viewModel.isFetchTypeSelected(segment)
                    ? ktsSmallDarkTextStyle(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kcLightBlue)
                    : ktsSmallDarkTextStyle(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kcLightBlue.withOpacity(0.6)),
              ),
            ),
        },
        onValueChanged: (value) => viewModel.setFetchType(value!),
      ),
    );
  }
}
