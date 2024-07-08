import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final Function(String) onSelectedValue;
  final String selectedValue;
  final List<String> valueList;
  const CustomDropdown({
    super.key,
    required this.onSelectedValue,
    required this.selectedValue,
    required this.valueList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down,
              color: Theme.of(context).primaryColor),
          iconSize: 24,
          isExpanded: true,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
          ),
          onChanged: (time) => onSelectedValue(time!),
          items: valueList.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
        ),
      ),
    );
  }
}
