part of 'parsing_cubit.dart';

@immutable
sealed class ParsingState {}

final class ParsingInitial extends ParsingState {}

final class ParsingLoading extends ParsingState {}

final class ParsingLoaded extends ParsingState {
  final List<Currency> data; 
  ParsingLoaded(this.data);
}

final class ParsingError extends ParsingState {
  final String message;
  ParsingError(this.message);
}
