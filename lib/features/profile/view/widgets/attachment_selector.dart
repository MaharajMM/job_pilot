// import 'package:flutter/material.dart';

// class AttachmentSelector extends StatefulWidget {
//   final String? attachmentPath;
//   const AttachmentSelector({super.key, this.attachmentPath});

//   @override
//   State<AttachmentSelector> createState() => _AttachmentSelectorState();
// }

// class _AttachmentSelectorState extends State<AttachmentSelector> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 1,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.attachmentPath == null) ...[
//               Text(
//                 'Attach your resume or other document that will be used by default',
//                 style: TextStyle(color: Colors.grey[700]),
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: _selectAttachment,
//                   icon: const Icon(Icons.upload_file),
//                   label: const Text('Select File'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
//                     foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
//                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   ),
//                 ),
//               ),
//             ] else ...[
//               Row(
//                 children: [
//                   const Icon(Icons.insert_drive_file),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(_attachmentName ?? 'Attached file'),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () {
//                       setState(() {
//                         widget.attachmentPath = null;
//                         _attachmentName = null;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: _selectAttachment,
//                   icon: const Icon(Icons.upload_file),
//                   label: const Text('Change File'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
//                     foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
//                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
