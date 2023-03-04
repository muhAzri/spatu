import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:spatu/shared/theme.dart';
import 'package:spatu/view/widgets/buttons.dart';

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

showDisclaimerDialog(BuildContext context) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width - (2 * 24),
        child: AlertDialog(
          backgroundColor: backgroundColor1,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Disclaimer:',
                style: primaryTextStyle.copyWith(
                  fontSize: 24.sp,
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                'Aplikasi ini hanya untuk tujuan pembelajaran dan pengembangan keterampilan. Beberapa fiturnya dibatasi dan tidak untuk tujuan komersial atau merugikan. Pengguna bertanggung jawab atas tindakan yang dilakukan dan pengembang tidak bertanggung jawab atas kerusakan atau kerugian akibat penggunaannya. Harap baca ketentuan penggunaan sebelum menggunakan aplikasi ini.',
                style: secondaryTextStyle.copyWith(
                  fontWeight: medium,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomTextButton(
                title: 'OK',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
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
