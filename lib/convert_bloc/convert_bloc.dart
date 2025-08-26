import 'dart:async';
import 'dart:developer';

import 'package:currency_rate_calculator/models/currency_model.dart';
import 'package:currency_rate_calculator/models/currency_pair_model.dart';
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
    on<CurrencyOfflineConvertEvent>(_onOfflineConvert);
  }

  FutureOr<void> _currencyConvertEvent(
    CurrencyConvertEvent event,
    Emitter<ConvertState> emit,
  ) async {
    emit(ConvertLoadingState()); // show loading
    try {
      final result = await repository.convert(
        from: event.from.code,
        to: event.to.code,
        amount: event.amount,
      );
      await RecentPairsRepository().addRecentPair(
        fromCurrency: event.from,

        toCurrency: event.to,

        result: result,
      );
      emit(ConvertLoadedState(result: result));
    } catch (e) {
      log("$e");
      emit(ConvertErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _onOfflineConvert(
    CurrencyOfflineConvertEvent event,
    Emitter<ConvertState> emit,
  ) {
    emit(ConvertLoadingState());
    try {
      // final rate = double.tryParse(event.pair.rate) ?? 0;
      // final converted = event.amount * rate;

      emit(
        ConvertOfflineLoadedState(
          pair: event.pair,
          convertedAmount: event.pair.result.amount,
          from: event.from,
          to: event.to,
          result: event.pair.result,
        ),
      );
    } catch (e) {
      emit(ConvertErrorState(error: "Offline conversion failed"));
    }
  }
}
