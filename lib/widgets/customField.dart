import 'package:flutter/material.dart';

Widget customField({
  required String hint,

  required TextEditingController controller,

  required IconData icon,

  bool isPassword = false,

  bool obscure = false,

  VoidCallback? onTap,
}) {
  return TextField(
    controller: controller,

    obscureText: obscure,

    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,

    decoration: InputDecoration(
      hintText: hint,

      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),

      prefixIcon: Icon(icon, color: Colors.grey.shade600),

      contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),

      filled: true,
      fillColor: Colors.grey.shade100,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      suffixIcon: isPassword
          ? IconButton(
              onPressed: onTap,

              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,

                color: Colors.grey.shade500,
              ),
            )
          : null,
    ),
  );
}
