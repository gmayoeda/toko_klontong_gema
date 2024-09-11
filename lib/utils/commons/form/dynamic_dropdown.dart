import 'package:flutter/material.dart';
import 'package:toko_klontong_gema/utils/config/theme/themes.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final bool isShowTitle;
  final String value;
  final String? itemData;
  final String? itemDataView;
  final List<dynamic> items;
  final bool? needValidate;
  final Function? functionValidate;
  final void Function(dynamic value)? onChanged;
  final bool hasBorder;
  final bool needBottom;
  final bool? textCenter;

  const CustomDropdown({
    super.key,
    required this.title,
    this.isShowTitle = true,
    required this.value,
    required this.items,
    this.itemData,
    this.itemDataView,
    this.needValidate = true,
    this.functionValidate,
    required this.onChanged,
    this.hasBorder = true,
    this.needBottom = true,
    this.textCenter = false,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
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
        if (widget.isShowTitle) const SizedBox(height: 8),
        DropdownButtonFormField(
          isExpanded: true,
          borderRadius: BorderRadius.circular(10),
          menuMaxHeight: 400,
          hint: Text(
            "Pilih ${widget.title}",
            style: TextStyle(color: Colors.grey[400]),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hoverColor: mainColors.withOpacity(0.05),
            focusColor: mainColors.withOpacity(0.05),
            helperStyle: const TextStyle(color: Colors.black87, fontSize: 10.5),
            helperMaxLines: null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
          value: widget.value == "" || widget.value == "null"
              ? null
              : widget.value,
          onChanged: widget.onChanged,
          items: widget.items
              .map((label) => DropdownMenuItem(
                    alignment: widget.textCenter == true
                        ? Alignment.center
                        : Alignment.centerLeft,
                    value: label,
                    child: Text(label,
                        // widget.itemDataView == null
                        //     ? label[widget.itemData]
                        //     : label[widget.itemDataView],
                        overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          validator: widget.needValidate == true
              ? (value) {
                  if (value == null) {
                    return "${widget.title} Tidak boleh kosong.";
                  }
                  return null;
                }
              : null,
        ),
        SizedBox(height: widget.needBottom ? 15 : 0),
      ],
    );
  }
}
