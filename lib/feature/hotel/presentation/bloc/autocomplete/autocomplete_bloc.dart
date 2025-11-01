import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/feature/hotel/data/exception/search_exception.dart';
import 'package:travaly_app/feature/hotel/data/models/autocomplete_request_model.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository.dart';

part 'autocomplete_state.dart';
part 'autocomplete_event.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final HotelSearchRepository hotelSearchRepository;
  Timer? _debounceTimer;

  AutocompleteBloc({required this.hotelSearchRepository})
      : super(AutocompleteInitial()) {
    on<AutocompleteTextChanged>(_onTextChanged);
    on<AutocompleteSuggestionSelected>(_onSuggestionSelected);
    on<AutocompleteCleared>(_onCleared);
  }

  Future<void> _onTextChanged(
    AutocompleteTextChanged event,
    Emitter<AutocompleteState> emit,
  ) async {
    _debounceTimer?.cancel();

    if (event.query.isEmpty) {
      emit(AutocompleteInitial());
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      emit(AutocompleteLoading());

      try {
        final response = await hotelSearchRepository.getAutocompleteSuggestions(
          query: event.query,
          searchTypes: [
            "byCity",
            "byState",
            "byCountry",
            "byPropertyName",
            "byStreet",
          ],
        );

        if (response.status && response.data.present) {
          emit(AutocompleteLoaded(
            suggestions: response.data.autoCompleteList.allItems,
            currentQuery: event.query,
          ));
        } else {
          emit(AutocompleteLoaded(
            suggestions: [],
            currentQuery: event.query,
          ));
        }
      } on SearchException catch (e) {
        emit(AutocompleteError(e.message));
      } catch (e) {
        emit(AutocompleteError('An unexpected error occurred'));
      }
    });
  }

  void _onSuggestionSelected(
    AutocompleteSuggestionSelected event,
    Emitter<AutocompleteState> emit,
  ) {
    emit(AutocompleteSelected(event.selectedItem));
  }

  void _onCleared(
    AutocompleteCleared event,
    Emitter<AutocompleteState> emit,
  ) {
    _debounceTimer?.cancel();
    emit(AutocompleteInitial());
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
