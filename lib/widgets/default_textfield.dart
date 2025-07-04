import 'package:appifylab_assessment/main.dart';
import 'package:flutter/material.dart';

class DefaultTextfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextStyle? style;
  final TextInputType? keyboardType;
  const DefaultTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.style,
  });

  @override
  State<DefaultTextfield> createState() => _DefaultTextfieldState();
}

class _DefaultTextfieldState extends State<DefaultTextfield> {
  bool passwordVisibility = false;
  @override
  void initState() {
    passwordVisibility = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: appTheme(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white
          ),
        ),
        SizedBox(height: 8,),
        TextFormField(
          controller: widget.controller,
          validator: (text){
            if((text??'').isEmpty){
              return '${widget.label} is required';
            }
            return null;
          },
          style: widget.style ?? appTheme(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w400
          ),
          obscureText: passwordVisibility,
          cursorColor: Colors.red,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1, color: Colors.grey)
            ),
            focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 1, color: Colors.grey)
            ),
            enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 1, color: Colors.grey)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(width: 1, color: Colors.red)
            ),
            suffixIcon: widget.obscureText ? InkWell(
              onTap: (){
                  setState(() {
                    passwordVisibility = !passwordVisibility;
                  });
              },
              child: Icon(
                !passwordVisibility ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
            ) : null
          ),
        )
      ],
    );
  }
}
