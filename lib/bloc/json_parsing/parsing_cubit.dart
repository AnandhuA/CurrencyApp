import 'dart:convert';
import 'dart:developer';

import 'package:currency_rate_calculator/data/models/currency_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'parsing_state.dart';

class ParsingCubit extends Cubit<ParsingState> {
  ParsingCubit() : super(ParsingInitial());

  Future<void> loadCurrenciesCubit() async {
    emit(ParsingLoading());
    try {
      final String response = await rootBundle.loadString(
        'assets/currencies/currencies.json',
      );
      final List<dynamic> jsonList = jsonDecode(response);
      final List<Currency> data = jsonList
          .map((e) => Currency.fromJson(e))
          .toList();
      emit(ParsingLoaded(data));
    } catch (e) {
      log("$e");
      emit(ParsingError("Failed to parse data: $e"));
    }
  }
}
