import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/shared/utility/utilities.dart';

class AttachmentSelectorWidget extends StatefulWidget {
  final String name;
  final GlobalKey<FormBuilderState> formKey;
  const AttachmentSelectorWidget({
    super.key,
    required this.name,
    required this.formKey,
  });

  @override
  State<AttachmentSelectorWidget> createState() => _AttachmentSelectorWidgetState();
}

class _AttachmentSelectorWidgetState extends State<AttachmentSelectorWidget> {
  String? _attachmentPath;
  String? _attachmentName;
  Future<void> _selectAttachment({
    required BuildContext mcontext,
    required FormFieldState<File> field,
  }) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      var pickedFile = result.files.first;
      setState(() {
        _attachmentPath = pickedFile.path;
        _attachmentName = pickedFile.name;
      });
      field.didChange(File(pickedFile.path!));
    } else {
      if (mcontext.mounted) {
        Utilities.flushBarErrorMessage(
          message: 'Please pick any file correctly',
          context: mcontext,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final savedFile = widget.formKey.currentState?.fields[widget.name]?.value;

      if (savedFile != null) {
        setState(() {
          _attachmentPath = savedFile.path;
          _attachmentName = savedFile.path.split('/').last;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.attach_file,
                ),
                const SizedBox(width: 8),
                Text(
                  'Default Attachment',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Attach your resume or other document',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey700,
                  ),
            ),
            const SizedBox(height: 16),
            FormBuilderField<File>(
              name: widget.name,
              builder: (field) {
                return Column(
                  children: [
                    if (_attachmentPath != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.kwhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.insert_drive_file, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                maxLines: 3,
                                _attachmentName ?? 'Selected file',
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              child: const Icon(Icons.close, size: 20),
                              onTap: () {
                                setState(() {
                                  _attachmentPath = null;
                                  _attachmentName = null;
                                });
                                field.reset();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    ElevatedButton.icon(
                      onPressed: () {
                        _selectAttachment(field: field, mcontext: context);
                      },
                      icon: const Icon(Icons.upload_file),
                      label: Text(_attachmentPath == null ? 'Select File' : 'Change File'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimaryBgColor,
                        foregroundColor: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
