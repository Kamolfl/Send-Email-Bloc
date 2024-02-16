part of 'email_bloc.dart';

@immutable
abstract class EmailState {}

class EmailInitial extends EmailState {}

class EmailLoadingState extends EmailState {}

class EmailSuccessState extends EmailState {}

class EmailErrorState extends EmailState {
  final String errorText;
  EmailErrorState({required this.errorText});
}
