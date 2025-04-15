import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_pilot/data/models/email_model.dart';
import 'package:job_pilot/shared/exception/app_exception.dart';
import 'package:multiple_result/multiple_result.dart';

import 'i_email_repository.dart';

class EmailRepository implements IEmailRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  EmailRepository({
    required this.firestore,
    required this.auth,
  });

  String? get _currentUserId => auth.currentUser?.uid;

  @override
  Future<Result<bool, AppException>> saveEmailDetails({
    required String subject,
    required String name,
    required String email,
    required String body,
    File? attachment,
  }) async {
    try {
      if (_currentUserId == null) {
        return Result.error(AuthException('User not authenticated'));
      }

      // Upload attachment if exists
      // String? attachmentUrl;
      // if (attachment != null) {
      // }

      // Create email document
      final emailData = EmailModel(
        emailId: email,
        subject: subject,
        body: body,
        timestamp: DateTime.now(),
        name: name,
      ).toMap();

      // Save email details to Firestore
      await firestore
          .collection('users')
          .doc(_currentUserId)
          .collection('email')
          .doc('data')
          .set(emailData);

      return Result.success(true);
    } catch (e) {
      return Result.error(DatabaseException('Failed to save email details: ${e.toString()}'));
    }
  }
}
