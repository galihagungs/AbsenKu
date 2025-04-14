import 'package:absenku/service/UserService.dart';
import 'package:absenku/utils/utils.dart';
import 'package:flutter/material.dart';

TextField textFieldCustomIcon({
  required Icon prefixIcon,
  required String hint,
  required bool isPasword,
  TextEditingController? controller,
}) {
  return TextField(
    controller: controller,
    style: kanit16normal,
    obscureText: isPasword,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 2, color: Colors.grey.shade500),
      ),

      hintStyle: kanit16normal,
      hintText: hint,
      prefixIcon: prefixIcon,
    ),
  );
}

SizedBox uniButton(
  BuildContext context, {
  required Text title,
  required VoidCallback func,
  required Color warna,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(warna),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      onPressed: func,
      // child: Text(title, style: kanit16semiBoldMainWhite),
      child: title,
    ),
  );
}
