// ignore_for_file: constant_identifier_names

import 'dart:ui';
import 'package:flutter/material.dart';

class RichAlertDialog extends StatefulWidget {
  final String alertTitle;
  final String alertSubtitle;
  final int alertType;
  final Function? action;

  const RichAlertDialog({
    super.key,
    required this.alertTitle,
    required this.alertSubtitle,
    required this.alertType,
    this.action,
  });

  @override
  createState() => _RichAlertDialogState();
}

class _RichAlertDialogState extends State<RichAlertDialog> {
  late double deviceWidth;
  late double deviceHeight;
  late double dialogHeight;
  late double iconHeight;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size screenSize = MediaQuery.of(context).size;

    deviceWidth = orientation == Orientation.portrait
        ? screenSize.width
        : screenSize.height;
    deviceHeight = orientation == Orientation.portrait
        ? screenSize.height
        : screenSize.width;
    dialogHeight = deviceHeight / (4);
    iconHeight = deviceHeight / (3.5);

    return MediaQuery(
      data: const MediaQueryData(),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3.0,
          sigmaY: 3.0,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 210,
              width: deviceWidth * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: Column(
                            children: [
                              SizedBox(height: dialogHeight / 4),
                              Text(
                                widget.alertTitle,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: dialogHeight / 50),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                widget.alertSubtitle,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: Row(
                            mainAxisAlignment:
                                widget.alertType == RichAlertType.CONFIRM
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(100, 30),
                                  backgroundColor: _typeColor[widget.alertType],
                                ),
                                onPressed: () {
                                  widget.action != null
                                      ? widget.action!()
                                      : Navigator.pop(context);
                                },
                                child: const Text(
                                  "OK",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              widget.alertType == RichAlertType.CONFIRM
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Batal",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                            // widget.actions,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              top: -200,
              child: Center(child: Container(child: _defaultIcon())),
            ),
            Positioned(
              bottom: 0,
              top: -230,
              right: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, size: 30.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Map<int, Color> _typeColor = {
    RichAlertType.ERROR: const Color(0xfff15249),
    RichAlertType.SUCCESS: const Color(0xff32ba7c),
    RichAlertType.WARNING: const Color(0xffff9f00),
    RichAlertType.CONFIRM: const Color(0xff0c6cae),
  };

  final Map<int, AssetImage> _typeAsset = const {
    RichAlertType.ERROR: AssetImage("assets/alerts/error.png"),
    RichAlertType.SUCCESS: AssetImage("assets/alerts/success.png"),
    RichAlertType.WARNING: AssetImage("assets/alerts/warning.png"),
    RichAlertType.CONFIRM: AssetImage("assets/alerts/confirm.png"),
  };

  Image _defaultIcon() {
    return Image(
      image: _typeAsset[widget.alertType]!,
      width: 80,
      height: 80,
    );
  }
}

class RichAlertType {
  static const int ERROR = 0;
  static const int SUCCESS = 1;
  static const int WARNING = 2;
  static const int CONFIRM = 3;
}
