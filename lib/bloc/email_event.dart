part of 'email_bloc.dart';

@immutable
abstract class EmailEvent {}

class SendEmailEvent extends EmailEvent {
  final String name;
  final String email;
  final String message;
  SendEmailEvent({required this.name, required this.email, required this.message});
}
