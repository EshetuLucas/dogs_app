part of 'dogs_view.dart';

class _DogsBody extends ViewModelWidget<DogsViewModel> {
  const _DogsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, DogsViewModel viewModel) {
    return viewModel.hasDogsError
        ? RAErrorWidget(
            errorTitle: 'Unable to fetch dogs.',
            onTap: viewModel.onTryAgainDogs,
            errorMessage: '${viewModel.errorText}.\nTap to try again',
          )
        : GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.05,
            ),
            itemCount: viewModel.isBusy ? 20 : viewModel.dogs.length,
            itemBuilder: (BuildContext context, int index) {
              final dogImageurl = viewModel.isBusy
                  ? FakeDog().generate().imageUrls.first
                  : viewModel.dogs[index];

              return Padding(
                padding: EdgeInsets.only(
                    left: 10,
                    top: index % 2 == 0 ? 18 : 0,
                    right: 8,
                    bottom: 8),
                child: IgnorePointer(
                  ignoring: viewModel.isBusy,
                  child: GestureDetector(
                    onTap: () => viewModel.onDogCardTap(dogImageurl),
                    child: DogListItem(
                      imageUrl: dogImageurl,
                      busy: viewModel.isFetchingDogs,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
