import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/data/repository/email/email_repository.dart';
import 'package:job_pilot/data/repository/email/i_email_repository.dart';

final emailRepoProvider = Provider.autoDispose<IEmailRepository>(
  (ref) {
    return EmailRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    );
  },
);
