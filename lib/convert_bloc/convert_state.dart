part of 'convert_bloc.dart';

@immutable
sealed class ConvertState {}

final class ConvertInitial extends ConvertState {}

final class ConvertLoadingState extends ConvertState {}

final class ConvertLoadedState extends ConvertState {
  final ResponseModel result;

  ConvertLoadedState({required this.result});
}

final class ConvertErrorState extends ConvertState {
  final String error;

  ConvertErrorState({required this.error});
}



final class ConvertOfflineLoadedState extends ConvertState {
  final CurrencyPair pair;
  final String convertedAmount;
  final Currency from;
  final Currency to;
  final ResponseModel result;

  ConvertOfflineLoadedState({
    required this.pair,
    required this.convertedAmount,
    required this.from,
    required this.to,
    required this. result
  });
}