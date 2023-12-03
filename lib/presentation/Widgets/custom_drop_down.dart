import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    this.items,
    this.hint,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.icon,
    this.value,
    this.searchController,
    this.dropdownMaxHeight,
    this.isPlate = false,
  }) : super(key: key);
  /// This [items] is a List of String and your model must be a list of String to build
  /// DO NOT USE [items] WITH [modelBuilder] IN A SAME DROP DOWN WIDGET.
  final List<String>? items;
  /// this property using for hinting the client to do
  final String? hint;
  final String? Function(dynamic)? validator;
  final void Function(dynamic)? onChanged;
  final void Function(dynamic)? onSaved;
  /// this [value] is an object to understand what is your model reference and will do
  final dynamic value;
  final Widget? icon;
  /// if you want to have a search widget in your list just set a text editing controller to [searchController]
  final TextEditingController? searchController;
  final double? dropdownMaxHeight;
  /// This [isPlate] uses in plates widgets
  final bool isPlate;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField2<dynamic>(
          iconStyleData: IconStyleData(
            icon: icon ?? const Icon(Icons.arrow_drop_down),
          ),
          value: value,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            errorStyle: const TextStyle(color: Color(0xFFFF5449)),
            filled: true,
            fillColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGrey4, darkColor: CupertinoColors.systemGrey),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          isExpanded: true,
          hint: Text(hint ?? '', style: const TextStyle(fontSize: 13, fontFamily: 'iransans')),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          buttonStyleData: ButtonStyleData(
              height: 50,
            padding: const EdgeInsets.all(8.0),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: const Border.fromBorderSide(BorderSide.none)
            )
          ),
          items:items!.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(item,
                  textScaleFactor: isPlate ? 2 : null,
                  style: const TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'iransans')),
            ),
          ))
              .toSet().toList(),
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
        )
      ),
    );
  }
}
