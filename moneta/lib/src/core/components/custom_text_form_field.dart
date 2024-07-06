import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final bool readOnly;
  final String? initialValue;
  final TextEditingController? textEditingController;
  final String labelText;
  final int? maxLines;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final String? prefix;
  final IconButton? sufixIcon;
  final String? sufix;
  // final FocusNode? textFieldFocusNode;

  final bool enabled;

  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    // this.textFieldFocusNode,
    this.readOnly = false,
    this.initialValue,
    this.textEditingController,
    required this.labelText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.prefix,
    this.sufixIcon,
    this.sufix,
    this.inputFormatters,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: readOnly,
      initialValue: initialValue,
      controller: textEditingController,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      enabled: enabled,
      maxLines: maxLines,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        isDense: true,
        border: const OutlineInputBorder(),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 12),
        prefix: prefix == null ? null : Text(prefix.toString()),
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
        suffix: sufix == null ? null : Text(sufix.toString()),
        suffixIcon: sufixIcon,
        errorStyle: const TextStyle(fontSize: 0, height: 0),
      ),
      style: const TextStyle(fontSize: 12.0),
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
    );
  }
}
