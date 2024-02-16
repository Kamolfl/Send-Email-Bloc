import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/email_bloc.dart';
import 'package:flutter_application_2/repositories/dio_settings.dart';
import 'package:flutter_application_2/repositories/email_repository.dart';
import 'package:flutter_application_2/ui/my_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => EmailRepository(dio: RepositoryProvider.of<DioSettings>(context).dio),
        ),
      ],
      child: BlocProvider(
        create: (context) => EmailBloc(repository: RepositoryProvider.of<EmailRepository>(context)),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

