import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class AppImagePicker extends StatefulWidget {
  final Function(File?) onImageSelected;

  const AppImagePicker({super.key, required this.onImageSelected});

  @override
  // ignore: library_private_types_in_public_api
  _AppImagePickerState createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
        widget.onImageSelected(image);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: DottedBorder(
        color: AppColors.primary.withOpacity(0.5),
        strokeWidth: 2,
        borderType: BorderType.RRect,
        radius: Radius.circular(10),
        dashPattern: const [6, 3],
        child: Container(
          width: double.infinity,
          height: 132,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.file(
                    image!,
                    width: double.infinity,
                    height: 132,
                    fit: BoxFit.cover,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                    image: AssetImage('assets/images/gallery-import.png')),
                    SizedBox(height: 5),
                    AppText(title: 'Upload Your Photo', color: AppColors.grey),
                  ],
                ),
        ),
      ),
    );
  }
}
