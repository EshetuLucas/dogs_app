import 'package:dogs_app/extensions/string_extensions.dart';
import 'package:dogs_app/ui/bottom_sheets/basic_bottom_sheet.dart';
import 'package:dogs_app/ui/common/shared_styles.dart';
import 'package:dogs_app/ui/common/widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dogs_app/ui/common/app_colors.dart';
import 'package:dogs_app/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectItemSheet extends StatefulWidget {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const SelectItemSheet({
    required this.completer,
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  _SelectItemSheetState createState() => _SelectItemSheetState();
}

class _SelectItemSheetState extends State<SelectItemSheet> {
  List<String> get items => widget.request.data;
  late List<String> _filteredItems = items;

  late final TextEditingController _controller = TextEditingController()
    ..addListener(_handleQuery);

  void _handleQuery() {
    final String query = _controller.text;

    if (query.isNotEmpty) {
      _filteredItems = items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      _filteredItems = items;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FrostedBottomSheet(
      child: SizedBox(
        height: screenHeight(context) * 0.63,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              verticalSpaceSmall,
              Text(
                widget.request.title ?? 'Select Item',
                style: ktsMediumDarkTextStyle(context).copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: kcPrimaryColor,
                ),
              ),
              verticalSpaceSmall,
              verticalSpaceTiny,
              InputField(
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: kcLightBlue,
                ),
                hasFocusedBorder: true,
                contentPadding: const EdgeInsets.fromLTRB(18, 4, 4, 4),
                fieldHeight: 49,
                controller: _controller,
                placeholder: 'Search',
                maxLine: 1,
              ),
              verticalSpaceSmall,
              verticalSpaceTiny,
              Flexible(
                child: ListView.separated(
                  separatorBuilder: (_, __) => const Divider(
                    color: kcLightBlue,
                  ),
                  itemCount: _filteredItems.length,
                  itemBuilder: (_, i) {
                    final item = _filteredItems[i];
                    return InkWell(
                      onTap: () {
                        widget.completer?.call(
                          SheetResponse(data: item),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: Text(
                          item.capitalizeFirstLetter,
                          style: ktsWhiteMediumTextStyle()
                              .copyWith(color: kcWhite, fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
