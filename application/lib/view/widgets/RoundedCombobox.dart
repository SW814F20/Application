import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/Output.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedCombobox<T> extends StatefulWidget {
  RoundedCombobox(this.options,
      {this.padding = const EdgeInsets.fromLTRB(0, 10, 0, 10), this.fontSize = 30, this.label = false, this.labelText = ''});
  final double fontSize;
  final EdgeInsets padding;
  final bool label;
  final String labelText;
  final List<KeyValuePair<T, String>> options;
  final Output<T> _output = Output<T>(null);

  T getValue() => _output.getOutput();

  @override
  RoundedComboboxState createState() => RoundedComboboxState<T>(options, _output);
}

class RoundedComboboxState<T> extends State<RoundedCombobox<T>> {
  RoundedComboboxState(this.options, this.output);
  Output<T> output;

  List<DropdownMenuItem<T>> _dropDownMenuItems() => getDropDownMenuItems();
  List<KeyValuePair<T, String>> options;

  T _selectedItem;

  List<DropdownMenuItem<T>> getDropDownMenuItems() {
    return widget.options
        .map((option) => DropdownMenuItem<T>(
            value: option.key,
            child: Text(
              option.value,
              style: TextStyle(fontSize: widget.fontSize),
            )))
        .toList();
  }

  Widget _dropdownButton;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        widget.label
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Text(
                  widget.labelText,
                  style: TextStyle(fontSize: widget.fontSize),
                ),
              )
            : Container(),
        Expanded(
          flex: 100,
          child: Container(
            child: Padding(
              padding: widget.padding,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white),
                  padding: const EdgeInsets.all(8.0),
                  child: _dropdownButton),
            ),
          ),
        ),
      ],
    );
  }

  void changedDropDownItem(T selectedTopic) {
    setState(() {
      output.setOutput(selectedTopic);
      _dropdownButton = DropdownButton<T>(
        value: output.getOutput(),
        items: _dropDownMenuItems(),
        onChanged: changedDropDownItem,
      );
    });
  }

  T getValue() {
    return _selectedItem;
  }

  @override
  void initState() {
    /// defaults the selected item to the first item in the provided items
    output.setOutput(options[0].key);
    _dropdownButton = DropdownButton<T>(
      value: output.getOutput(),
      items: _dropDownMenuItems(),
      onChanged: changedDropDownItem,
    );
    super.initState();
  }
}
