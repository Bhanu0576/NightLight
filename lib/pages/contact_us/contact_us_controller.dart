// import 'dart:html';

import 'package:demo1212/pages/contact_us/hotmail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
// import 'package:mailer/mailer.dart';

class ContactUsPageController extends GetxController {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  var fullnameControllermode;
  var phoneNumberControllermode;
  var emailControllermode;
  var messageControllermode;

  String website = "bhanupratapsinghnegi@gmail.com";
  

  sentEmail() async {
    final body = "Name: ${fullnameController.text}\nPhone number: ${phoneNumberController.text}\n Email: ${emailController.text}\nMessage: ${messageController.text}";
    final Email email = Email(
      body: body,
      recipients: ['support@worksdelight.org'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
  sendEmail(String emailAddress) async {
  final Email email = Email(
    body:
    'Hello World',
    subject: 'Testing email on flutter',
    recipients: [emailAddress],
    //cc: ['cc@example.com'],
    //bcc: ['bcc@example.com'],
    //attachmentPaths: ['/path/to/attachment.zip'],
    isHTML: false,
  );}

  @override
  void onInit() {
    super.onInit();
    fullnameControllermode=AutovalidateMode.disabled;
    phoneNumberControllermode=AutovalidateMode.disabled;
    emailControllermode=AutovalidateMode.disabled;
    messageControllermode=AutovalidateMode.disabled;
  }
  void sendMail(String email, String password, String name, String message) async {

  String username = "smtp.office365.com";
  String password = "password";

  final smtpServer = hotmail(username, password);
  final equivalentMessage = Message()
  ..from = Address(username, name)
  ..recipients.add(Address(email))
  // ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
  // ..bccRecipients.add('bccAddress@example.com')
  ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
  ..text = 'This is the plain text.\nThis is line 2 of the text part.'
  ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  await send(equivalentMessage, smtpServer);
  }


//   sendMail() {
//   var options = GmailSmtpOptions()
//     ..username = 'kaisellgren@gmail.com'
//     ..password = 'my gmail password'; 
//   var transport = SmtpTransport(options);

//   var envelope = Envelope()
//     ..from = 'support@yourcompany.com'
//     ..fromName = 'Your company'
//     ..recipients = ['someone@somewhere.com', 'another@example.com']
//     ..subject = 'Your subject'
//     ..text = 'Here goes your body message';

//   transport.send(envelope)
//     .then((_) => print('email sent!'))
//     .catchError((e) => print('Error: $e'));
// }

  changeMode(){
    fullnameControllermode=AutovalidateMode.disabled;
    phoneNumberControllermode=AutovalidateMode.disabled;

    emailControllermode=AutovalidateMode.disabled;

    messageControllermode=AutovalidateMode.disabled;
    update();
  }
  
  fullNameChangeMode(){
    fullnameControllermode=AutovalidateMode.always;
    update();
  }

  phoneChangeMode(){
    phoneNumberControllermode=AutovalidateMode.always;
    update();
  }

  emailChangeMode(){
    emailControllermode=AutovalidateMode.always;
    update();
  }

  messageChangeMode(){
    messageControllermode=AutovalidateMode.always;
    update();
  }


// Future sendEmail({
//   required String name,
//   required String phone,
//   required String email,
//   required String message,

// })async{
//   final serviceId = 'service_lgz7vbe';
//   final templateId = 'template_uvwpyod';
//   final userId = '';

//   final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//   final response = await http.post(url, body: {'service_id': serviceId, 'template_id': templateId, 'user_id': userId,});

// }
}