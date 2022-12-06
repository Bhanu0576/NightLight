
import 'package:mailer/smtp_server.dart';

SmtpServer qq(String username, String password) => SmtpServer('smtp.office365.com',
    ssl: true, port: 465, username: username, password: password);
