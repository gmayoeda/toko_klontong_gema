import 'package:flutter/material.dart';
import 'package:toko_klontong_gema/utils/commons/alert/alert.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> displaySnackBar(
    BuildContext context,
    {required String message,
    required bool success,
    TextAlign? textAlign}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: success == true ? Colors.green : Colors.orange,
      content: Row(
        children: [
          success == true
              ? const Icon(
                  Icons.verified_sharp,
                  size: 23,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.warning_sharp,
                  size: 23,
                  color: Colors.white,
                ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              textAlign: textAlign ?? TextAlign.left,
              overflow: TextOverflow.visible,
              maxLines: null,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white54,
      duration: const Duration(seconds: 3),
    ),
  );
}

displayrichAlert(BuildContext context,
    {required String subtitle,
    required String type, //ERROR | WARNING | SUCCESS | CONFIRM
    String? title,
    Function? action}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return RichAlertDialog(
        alertTitle: title ??
            (type == 'WARNING'
                ? 'PERHATIAN'
                : type == 'ERROR'
                    ? 'PERINGATAN'
                    : type == 'SUCCESS'
                        ? 'BERHASIL'
                        : 'KONFIRMASI'),
        alertSubtitle: subtitle,
        alertType: type == 'WARNING'
            ? RichAlertType.WARNING
            : type == 'ERROR'
                ? RichAlertType.ERROR
                : type == 'SUCCESS'
                    ? RichAlertType.SUCCESS
                    : RichAlertType.CONFIRM,
        action: () {
          if (action == null) {
            Navigator.pop(context);
          } else {
            action();
          }
        },
      );
    },
  );
}
