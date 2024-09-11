import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toko_klontong_gema/utils/config/theme/themes.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final bool obscureText;
  final double width;
  final TextEditingController? controller;
  final TextEditingController? ageDiff;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isShowTitle;
  final bool hasBorder;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final Widget? preffixIcon;
  final Widget? suffixIcon;
  final String? suffixText;
  final Function(String value)? onChanged;
  final Function(String? value)? onSaved;
  final bool needValidate;
  final Function? functionValidate;
  final bool readOnly;
  final String? initialValue;
  final AutovalidateMode autovalidateMode;
  final bool isCurrency;
  final bool isDate;
  final bool isFirstDate;
  final bool isLastYear;
  final bool isAlphabet;
  final bool isNumber;
  final bool passwordMode;
  final bool needBottom;
  final TextInputAction textInputAction;
  final VoidCallback? onTap;
  final TextAlign textAlign;
  final String? helperText;
  final bool? isReadOnly;
  final bool? textCenter;

  const CustomTextField({
    super.key,
    required this.title,
    this.obscureText = false,
    this.width = double.infinity,
    this.controller,
    this.ageDiff,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.isShowTitle = true,
    this.hasBorder = true,
    this.preffixIcon,
    this.suffixIcon,
    this.suffixText,
    this.onChanged,
    this.onSaved,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.needValidate = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.functionValidate,
    this.readOnly = false,
    this.initialValue,
    this.isCurrency = false,
    this.isDate = false,
    this.isFirstDate = false,
    this.isLastYear = false,
    this.isAlphabet = false,
    this.isNumber = false,
    this.passwordMode = false,
    this.needBottom = true,
    this.textInputAction = TextInputAction.next,
    this.onTap,
    this.textAlign = TextAlign.left,
    this.helperText,
    this.isReadOnly,
    this.textCenter,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordInVisible = true;

  // DATE PICKER ==============================================================================
  getLocalDate(TextEditingController controller, TextEditingController? ageDiff,
      DateTime startDate) {
    String startDateFormatted = DateFormat('dd-MM-yyyy').format(startDate);
    controller.text = startDateFormatted;

    // if (ageDiff != null) {
    //   ageDiff.text = "${ageDifference("$startDate")}";
    // }
  }

  Future selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.isFirstDate ? DateTime.now() : DateTime(1945, 8),
      lastDate: widget.isLastYear == true ? DateTime.now() : DateTime(2050),
    );
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          RichText(
            maxLines: null,
            text: TextSpan(
              text: widget.title,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: widget.needValidate == true ? ' *' : '',
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        if (widget.isShowTitle)
          const SizedBox(
            height: 8,
          ),
        SizedBox(
          width: widget.width,
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            obscureText: widget.passwordMode ? _passwordInVisible : false,
            controller: widget.controller,
            keyboardType: widget.isCurrency || widget.isNumber
                ? TextInputType.number
                : widget.isAlphabet
                    ? TextInputType.text
                    : widget.isDate
                        ? TextInputType.datetime
                        : widget.keyboardType,
            initialValue: widget.initialValue,
            textAlign:
                widget.textCenter == true ? TextAlign.center : TextAlign.start,
            readOnly: widget.isReadOnly == true || widget.isDate ? true : false,
            onChanged: widget.onChanged,
            onTap: widget.isDate
                ? () async {
                    var datetime = await selectDate(context);
                    if (datetime != null) {
                      startDate = datetime;
                      if (widget.ageDiff != null) {
                        getLocalDate(
                            widget.controller!, widget.ageDiff!, startDate);
                      } else {
                        getLocalDate(widget.controller!, null, startDate);
                      }

                      setState(() {});
                    }
                  }
                : widget.onTap,
            inputFormatters: widget.inputFormatters ??
                (widget.isCurrency
                    ? [RupiahInputFormatter()]
                    : widget.isNumber
                        ? [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ]
                        : widget.isAlphabet
                            ? [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-z \'., A-Z]'))
                              ]
                            : null),
            maxLength: widget.maxLength,
            minLines: widget.passwordMode ? null : widget.minLines,
            maxLines: widget.passwordMode ? 1 : widget.maxLines,
            textInputAction: widget.textInputAction,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hoverColor: mainColors.withOpacity(0.05),
              counterText: '',
              hintText: !widget.isShowTitle ? widget.title : null,
              helperText: widget.helperText,
              helperMaxLines: 2,
              helperStyle:
                  const TextStyle(fontSize: 10.5, color: Colors.black54),
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              prefixIcon: widget.isCurrency
                  ? const PrefixWidget(
                      title: "Rp.",
                    )
                  : widget.preffixIcon,
              suffixText: widget.suffixText,
              suffixIcon: widget.passwordMode
                  ? IconButton(
                      icon: Icon(
                        _passwordInVisible
                            ? Icons.visibility_off
                            : Icons
                                .visibility, //change icon based on boolean value
                        color: mainColors,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordInVisible =
                              !_passwordInVisible; //change boolean value
                        });
                      },
                    )
                  : widget.isDate
                      ? const Icon(Icons.calendar_month)
                      : widget.suffixIcon,
              suffixIconColor: mainColors,
              contentPadding: const EdgeInsets.all(12),
              enabledBorder: widget.hasBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(10))
                  : null,
              border: widget.hasBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(10))
                  : null,
              focusedBorder: widget.hasBorder
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(10))
                  : null,
            ),
            onSaved: widget.onSaved,
            validator: widget.needValidate == false
                ? widget.functionValidate != null
                    ? (value) {
                        if (widget.functionValidate != null) {
                          return widget.functionValidate!();
                        }
                        return null;
                      }
                    : null
                : (value) {
                    if (value != null && value.trim().isEmpty) {
                      return "${widget.title} cannot be empty.";
                    }
                    if (widget.functionValidate != null) {
                      return widget.functionValidate!();
                    }
                    return null;
                  },
          ),
        ),
        SizedBox(height: widget.needBottom ? 15 : 0),
      ],
    );
  }
}

class PrefixWidget extends StatelessWidget {
  const PrefixWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: const VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuffixWidget extends StatelessWidget {
  const SuffixWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // Parse the new value as an integer (remove non-digits)
    int value =
        int.tryParse(newValue.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    // Format the value as Rupiah
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);
    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
