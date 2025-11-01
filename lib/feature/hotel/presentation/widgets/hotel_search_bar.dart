import 'package:flutter/material.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/hotel/data/models/autocomplete_request_model.dart';

class HotelAutocompleteSearchBar extends StatelessWidget {
  final Function(AutoCompleteItem) onSearch;
  final Function() onClear;
  final String initialQuery;
  final Future<List<AutoCompleteItem>> Function(String) suggestionCallback;

  const HotelAutocompleteSearchBar({
    super.key,
    required this.onSearch,
    required this.onClear,
    required this.suggestionCallback,
    this.initialQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: AppConstants.cardElevationM,
            spreadRadius: 0.5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.borderLight.withOpacity(0.8),
        ),
      ),
      child: Autocomplete<AutoCompleteItem>(
        initialValue: TextEditingValue(text: initialQuery),
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<AutoCompleteItem>.empty();
          }
          return await suggestionCallback(textEditingValue.text);
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: AppConstants.spacingM),
              child: Material(
                elevation: AppConstants.cardElevationL,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadiusL),
                  side: BorderSide(
                    color: AppColors.borderLight.withOpacity(0.3),
                    width: AppConstants.borderWidthXS,
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width -
                      AppConstants.spacingXXL * 2,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadiusL),
                  ),
                  child: options.isEmpty
                      ? _buildEmptyState()
                      : _buildSuggestionsList(options, onSelected),
                ),
              ),
            ),
          );
        },
        displayStringForOption: (AutoCompleteItem option) => option.displayText,
        onSelected: (AutoCompleteItem selection) {
          onSearch(selection);
        },
        fieldViewBuilder: (
          BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
        ) {
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: 'Search hotels, cities, or destinations...',
              hintStyle: const TextStyle(
                color: AppColors.textHint,
                fontSize: AppConstants.fontSizeM,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.only(left: AppConstants.spacingM),
                child: const Icon(
                  Icons.search_rounded,
                  color: AppColors.textHint,
                  size: AppConstants.iconSizeL,
                ),
              ),
              suffixIcon: textEditingController.text.isNotEmpty
                  ? Container(
                      margin:
                          const EdgeInsets.only(right: AppConstants.spacingS),
                      child: IconButton(
                        icon: Icon(
                          Icons.clear_rounded,
                          color: AppColors.textHint.withOpacity(0.7),
                          size: AppConstants.iconSizeM,
                        ),
                        onPressed: () {
                          textEditingController.clear();
                          onClear();
                        },
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingL,
                vertical: AppConstants.spacingL,
              ),
              isDense: true,
            ),
            style: const TextStyle(
              fontSize: AppConstants.fontSizeM,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            textInputAction: TextInputAction.search,
          );
        },
      ),
    );
  }

  Widget _buildSuggestionsList(
    Iterable<AutoCompleteItem> options,
    void Function(AutoCompleteItem) onSelected,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.05),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppConstants.borderRadiusL),
              topRight: Radius.circular(AppConstants.borderRadiusL),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.travel_explore_rounded,
                color: AppColors.primaryColor,
                size: AppConstants.iconSizeM,
              ),
              const SizedBox(width: AppConstants.spacingS),
              const Text(
                'Search Suggestions',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeS,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${options.length} found',
                style: const TextStyle(
                  fontSize: AppConstants.fontSizeXS,
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Suggestions list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.spacingS,
            ),
            shrinkWrap: true,
            itemCount: options.length,
            separatorBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstants.spacingL),
              child: Divider(
                height: 1,
                color: AppColors.borderLight.withOpacity(0.5),
              ),
            ),
            itemBuilder: (BuildContext context, int index) {
              final option = options.elementAt(index);
              return _buildSuggestionItem(option, index, onSelected);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionItem(
    AutoCompleteItem option,
    int index,
    void Function(AutoCompleteItem) onSelected,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onSelected(option),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingM,
          ),
          child: Row(
            children: [
              Container(
                width: AppConstants.iconSizeL,
                height: AppConstants.iconSizeL,
                decoration: BoxDecoration(
                  color: option.iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  option.icon,
                  color: option.iconColor,
                  size: AppConstants.iconSizeS,
                ),
              ),
              const SizedBox(width: AppConstants.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.displayText,
                      style: const TextStyle(
                        fontSize: AppConstants.fontSizeM,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (option.address != null &&
                        option.address!.formattedAddress.isNotEmpty) ...[
                      const SizedBox(height: AppConstants.spacingXS),
                      Text(
                        option.address!.formattedAddress,
                        style: const TextStyle(
                          fontSize: AppConstants.fontSizeS,
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.textHint.withOpacity(0.5),
                size: AppConstants.iconSizeS,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            color: AppColors.textHint.withOpacity(0.5),
            size: AppConstants.iconSizeXL,
          ),
          const SizedBox(height: AppConstants.spacingM),
          const Text(
            'No suggestions found',
            style: TextStyle(
              fontSize: AppConstants.fontSizeM,
              color: AppColors.textHint,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppConstants.spacingXS),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              fontSize: AppConstants.fontSizeS,
              color: AppColors.textHint.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
