part of 'convert_bloc.dart';

@immutable
sealed class ConvertEvent {}

final class CurrencyConvertEvent extends ConvertEvent{
  final String from;
  final String to;
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

