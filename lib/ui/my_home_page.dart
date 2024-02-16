import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/email_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerName = TextEditingController();
    final TextEditingController controllerMessage = TextEditingController();
    final TextEditingController controllerEmail = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Send Email', style: TextStyle(fontSize: 59)),
              const SizedBox(height: 25),
              TextField(
                controller: controllerName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Name'),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: controllerEmail,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email'),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: controllerMessage,
                maxLines: 6,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Message'),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    BlocProvider.of<EmailBloc>(context).add(SendEmailEvent(
                      name: controllerName.text,
                      email: controllerEmail.text,
                      message: controllerMessage.text,
                    ));
                  },
                  child: BlocConsumer<EmailBloc, EmailState>(
                    listener: (context, state) {
                      if (state is EmailLoadingState) {
                        showDialog(context: context, builder: (context) => AlertDialog(content: Image.asset('assets/giphy.gif')));
                      }
                      if (state is EmailSuccessState) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('200-ok')));
                      } else if (state is EmailErrorState) {
                        Navigator.pop(context);
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(50),
                              child: Text(state.errorText, style: const TextStyle(fontSize: 30),),
                            ));
                      }
                    },
                    builder: (context, state) {
                      return const Text(
                        'Send',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
