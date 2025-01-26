import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CustomUploadFile extends StatelessWidget {
  final String label;
  final Function(PlatformFile?) onFilePicked;
  final TextEditingController controller;
  final IconData? uploadIcon;
  final FormFieldValidator<String>? validator; // Added validator parameter

  const CustomUploadFile({
    Key? key,
    required this.label,
    required this.onFilePicked,
    required this.controller,
    this.uploadIcon = Icons.upload_file,
    this.validator, // Initialize validator
  }) : super(key: key);

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'], // Specify allowed file types
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      onFilePicked(file);
      controller.text = file.name; // Set the file name in the text field.
    } else {
      onFilePicked(null); // Handle file picking cancellation.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xff19649E),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            readOnly: true, // Prevent user from typing manually.
            textAlign: TextAlign.start,
            // textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: GestureDetector(
                onTap: _pickFile,
                child: Icon(uploadIcon, color: const Color(0xff737373)),
              ),
            ),
            validator: validator, // Apply the validator
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
