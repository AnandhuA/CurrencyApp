import 'dart:async';

import 'package:currency_rate_calculator/models/responce_model.dart';
import 'package:currency_rate_calculator/repository/currency_repo.dart';
import 'package:currency_rate_calculator/repository/recent_pairs_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'convert_event.dart';
part 'convert_state.dart';

class ConvertBloc extends Bloc<ConvertEvent, ConvertState> {
  final CurrencyRepository repository;
  ConvertBloc(this.repository) : super(ConvertInitial()) {
    on<CurrencyConvertEvent>(_currencyConvertEvent);
  }

  FutureOr<void> _currencyConvertEvent(
    CurrencyConvertEvent event,
    Emitter<ConvertState> emit,
  ) async {
    emit(ConvertLoadingState()); // show loading
    try {
      final result = await repository.convert(
        from: event.from,
        to: event.to,
        amount: event.amount,
      );
      await RecentPairsRepository().addRecentPair(
        fromCode: event.from,
        fromFlag: event.fromFlag,
        toCode: event.to,
        toFlag: event.toFlag,
      );
      emit(ConvertLoadedState(result: result)); // success
    } catch (e) {
      emit(ConvertErrorState(error: e.toString())); // error
    }
  }
}
