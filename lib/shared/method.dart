import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:spatu/shared/theme.dart';

showMyDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width - (2 * 24),
        child: AlertDialog(
          backgroundColor: backgroundColor1,
          content: Text(
            'Mohon Maaf Fitur Belum Tersedia',
            style: primaryTextStyle.copyWith(
              fontSize: 24.sp,
              fontWeight: bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    },
  );
}

String formatCurrency({required num number, String? symbol}) {
  symbol ??= 'Rp ';
  return NumberFormat.currency(
    locale: 'id',
    symbol: symbol,
    decimalDigits: 0,
  ).format(number);
}

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: redColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

Future<XFile?> selectImage() async {
  XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  return selectedImage;
}
