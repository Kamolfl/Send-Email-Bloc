import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_2/repositories/email_repository.dart';
import 'package:meta/meta.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc({required this.repository}) : super(EmailInitial()) {
    on<SendEmailEvent>((event, emit) async {
     emit(EmailLoadingState());
     try{
       await repository.sendEmail(name: event.name, email: event.email, message: event.message);
       emit(EmailSuccessState());
     } catch(e){
       if (e is DioException) {
         emit(EmailErrorState(errorText: e.response.toString()));
       } else {
         EmailErrorState(errorText: e.toString());
       }
     }
    });
  }

  final EmailRepository repository;
}
