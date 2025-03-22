import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

@RoutePage()
class EmailSenderPage extends StatelessWidget {
  const EmailSenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EmailSenderView();
  }
}

class EmailSenderView extends StatefulWidget {
  const EmailSenderView({super.key});

  @override
  State<EmailSenderView> createState() => _EmailSenderViewState();
}

class _EmailSenderViewState extends State<EmailSenderView> {
  String jobBody =
      "Hello sir,\n\nI am writing to express my interest in the Flutter Developer position at your company, as advertised. With over 5 years of experience in flutter and software development, specializing in mobile application development with Flutter, API integration, and optimizing application performance, I am confident that my skill set makes me a strong candidate for this role.\n\nIn my current role as an Application Engineer at Dessot, I have developed multi-role apps, optimized app performance by 30%, and reduced bugs by 40%, ensuring robust and scalable software solutions. My proficiency extends beyond mobile app development, as I have also worked on backend APIs using Node.js and integrated real-time functionalities with WebSockets, enhancing the overall user experience.\n\nI have attached my resume for your consideration. I would welcome the opportunity to discuss how my skills and experiences can contribute to your team’s success.\n\nThank you for your time and consideration. I look forward to the possibility of discussing my qualifications in more detail.\n\nBest regards\nMaharaj Madan Mohan Behera\nmaharajmm2@gmail.com\nMobile- 6371366817";

  final TextEditingController sendingEmailController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController appPasswordController = TextEditingController();

  String jobDetails =
      "Dear Hiring Manager,\n\nI am excited to apply for the job. Attached is my resume.";
  String? resumePath;
  bool _isLoading = false;

  void pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        resumePath = result.files.single.path;
      });
    }
  }

  Future<void> sendEmail(BuildContext mcontext) async {
    if (emailController.text.isEmpty || appPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please enter email and app password")));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final smtpServer = gmail(emailController.text, appPasswordController.text);

    List<String> emails = sendingEmailController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.contains('@'))
        .toList();

    final message = Message()
      ..from = Address(emailController.text, 'Maharaj MM')
      ..recipients.addAll(emails)
      ..subject = "Flutter Job Application"
      ..text = jobBody;

    if (resumePath != null) {
      message.attachments.add(FileAttachment(File(resumePath!)));
    }

    try {
      await send(message, smtpServer);
      if (mcontext.mounted) {
        ScaffoldMessenger.of(mcontext)
            .showSnackBar(const SnackBar(content: Text("Email Sent Successfully!")));
      }
    } catch (e) {
      if (mcontext.mounted) {
        ScaffoldMessenger.of(mcontext)
            .showSnackBar(SnackBar(content: Text("Failed to send email: ${e.toString()}")));
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Job Email Sender")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: "Your Gmail Address", hintText: "example@gmail.com"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: appPasswordController,
              decoration: const InputDecoration(
                  labelText: "App Password", hintText: "Enter your Google App Password"),
              obscureText: true,
            ),
            TextField(
              controller: sendingEmailController,
              decoration: const InputDecoration(
                  labelText: "Recipient Emails (comma-separated)",
                  hintText: "recipient1@example.com, recipient2@example.com"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: pickResume, child: const Text("Pick Resume")),
            const SizedBox(height: 10),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () => sendEmail(context), child: const Text("Send Email")),
          ],
        ),
      ),
    );
  }
}
