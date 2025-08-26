part of 'convert_bloc.dart';

@immutable
sealed class ConvertEvent {}

final class CurrencyConvertEvent extends ConvertEvent{
  final Currency from;
  final Currency to;
  final double amount;
  final String fromFlag;
  final String toFlag;

  CurrencyConvertEvent({
    required this.from,
    required this.to,
    required this.amount,
    required this.fromFlag,
    required this.toFlag
  });
} 


final class CurrencyOfflineConvertEvent extends ConvertEvent {
  final CurrencyPair pair;
  final double amount;
  final Currency from;
  final Currency to;

  CurrencyOfflineConvertEvent({
    required this.pair,
    required this.amount,
    required this.from,
    required this.to,
  });
}
