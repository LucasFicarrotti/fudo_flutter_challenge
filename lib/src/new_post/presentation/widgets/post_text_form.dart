import 'package:flutter/material.dart';

class PostTextForm extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Key? formKey;
  final String? Function(String?)? validator;
  final int? maxLines;
  const PostTextForm({
    super.key,
    required this.title,
    required this.controller,
    this.formKey,
    this.validator,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: 'Escribe el ${title.toLowerCase()}...',
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
