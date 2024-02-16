import 'package:dio/dio.dart';
import 'package:flutter_application_2/consts/app_consts.dart';

class EmailRepository {
  final Dio dio;

  EmailRepository({required this.dio});

  Future<void> sendEmail(
      {required String name,
        required String email,
        required String message}) async {
    await dio.post(
      'https://api.emailjs.com/api/v1.0/email/send',
      data: {
        "service_id": AppsConsts.serviceId,
        "template_id": AppsConsts.templateId,
        "user_id": AppsConsts.userId,
        "accessToken": AppsConsts.accessToken,
        "template_params": {
          "name": name,
          "email": email,
          "message": message,
        },
      },
    );
  }
}
