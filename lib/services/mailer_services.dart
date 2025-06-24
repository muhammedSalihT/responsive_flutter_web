import 'dart:developer';

import 'package:mailer/mailer.dart' as mail;
import 'package:mailer/smtp_server.dart';

class MailerServices {
  Future<void> sendMail({required String recipient}) async {
    try {
      String username = 'brandscart.shop@gmail.com';
      String password = 'aaya yjqb zcrb vjgl';

// create a server for gmail
      final smtpServer = gmail(username, password);

// create a msg to share the usres as html
      const userHtmlMsg =
          "<p>This email is a receipt for your request on our application,We will contact you shortly.\nIf that was not you, please ignore this message.";

      // create mail body for user
      final userMessege = mail.Message()
        ..from = mail.Address(username, 'Motoxspace Store')
        ..recipients.add(mail.Address(recipient))
        ..subject = 'Motoxspace Store  request sucessfull'
        ..html = userHtmlMsg;
      // send mail to user
      await mail.send(userMessege, smtpServer);
    } catch (e) {
      log(e.toString());
    }
  }
}
