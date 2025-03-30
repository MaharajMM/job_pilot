import 'package:flutter/material.dart';
import 'package:job_pilot/const/colors/app_colors.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';
import 'package:job_pilot/shared/widget/custom_card.dart';

class AttachmentSelectorWidget extends StatefulWidget {
  const AttachmentSelectorWidget({super.key});

  @override
  State<AttachmentSelectorWidget> createState() => _AttachmentSelectorWidgetState();
}

class _AttachmentSelectorWidgetState extends State<AttachmentSelectorWidget> {
  String? _attachmentPath;
  String? _attachmentName;
  Future<void> _selectAttachment() async {
    // try {
    // final path = await FileUploadHelper.uploadFile();
    // if (path != null) {
    //   setState(() {
    //     _attachmentPath = path;
    //     _attachmentName = path.split('/').last;
    //   });
    // }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_attachmentPath == null) ...[
            Text(
              'Attach your resume or other document',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                isIcon: true,
                icon: const Icon(Icons.upload_file),
                labelText: 'Select File',
                freeSize: true,
                onPressed: _selectAttachment,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
              ),
            ),
          ] else ...[
            Row(
              children: [
                const Icon(Icons.insert_drive_file),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(_attachmentName ?? 'Attached file'),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _attachmentPath = null;
                      _attachmentName = null;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                isIcon: true,
                icon: const Icon(Icons.upload_file),
                labelText: 'Change File',
                freeSize: true,
                onPressed: _selectAttachment,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
