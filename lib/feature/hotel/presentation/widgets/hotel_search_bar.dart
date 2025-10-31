import 'package:flutter/material.dart';

class HotelSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final Function() onClear;
  final String initialQuery;

  const HotelSearchBar({
    super.key,
    required this.onSearch,
    required this.onClear,
    this.initialQuery = '',
  });

  @override
  State<HotelSearchBar> createState() => _HotelSearchBarState();
}

class _HotelSearchBarState extends State<HotelSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialQuery;

    // Listen to focus changes
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // You can add focus-related logic here if needed
  }

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      widget.onSearch(query);
    }
  }

  void _onClear() {
    _controller.clear();
    widget.onClear();
    _focusNode.unfocus();
  }

  void _onTextChanged(String value) {
    // Perform search as user types (optional)
    // You can debounce this if you want to avoid too many API calls
    if (value.isNotEmpty) {
      widget.onSearch(value);
    } else {
      _onClear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search hotels by name, city, state, or country...',
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[600],
              size: 20,
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    onPressed: _onClear,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            isDense: true,
          ),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          onChanged: _onTextChanged,
          onSubmitted: _onSearch,
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }
}
