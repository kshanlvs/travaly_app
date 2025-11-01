// lib/feature/hotel/presentation/bloc/autocomplete/autocomplete_state.dart

part of 'autocomplete_bloc.dart';

@immutable
sealed class AutocompleteState {}

class AutocompleteInitial extends AutocompleteState {}

class AutocompleteLoading extends AutocompleteState {}

class AutocompleteLoaded extends AutocompleteState {
  final List<AutoCompleteItem> suggestions;
  final String currentQuery;

  AutocompleteLoaded({
    required this.suggestions,
    required this.currentQuery,
  });

  AutocompleteLoaded copyWith({
    List<AutoCompleteItem>? suggestions,
    String? currentQuery,
  }) {
    return AutocompleteLoaded(
      suggestions: suggestions ?? this.suggestions,
      currentQuery: currentQuery ?? this.currentQuery,
    );
  }
}

class AutocompleteError extends AutocompleteState {
  final String message;

  AutocompleteError(this.message);
}

class AutocompleteSelected extends AutocompleteState {
  final AutoCompleteItem selectedItem;

  AutocompleteSelected(this.selectedItem);
}
