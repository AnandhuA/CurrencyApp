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
