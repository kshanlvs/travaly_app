part of 'autocomplete_bloc.dart';

@immutable
sealed class AutocompleteEvent {}

class AutocompleteTextChanged extends AutocompleteEvent {
  final String query;

  AutocompleteTextChanged(this.query);
}

class AutocompleteSuggestionSelected extends AutocompleteEvent {
  final AutoCompleteItem selectedItem;

  AutocompleteSuggestionSelected(this.selectedItem);
}

class AutocompleteCleared extends AutocompleteEvent {}
