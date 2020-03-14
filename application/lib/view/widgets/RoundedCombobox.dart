import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/Output.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedCombobox<T1> extends StatefulWidget {
  RoundedCombobox(this.options,
      {this.padding = const EdgeInsets.fromLTRB(0, 10, 0, 10), this.fontSize = 30, this.label = false, this.labelText = ""});
  final double fontSize;
  final EdgeInsets padding;
  final bool label;
  final String labelText;
  final List<KeyValuePair<T1, String>> options;
  final Output<T1> _output = Output<T1>(null);

  T1 getValue() => _output.getOutput();

  @override
  RoundedComboboxState createState() => RoundedComboboxState<T1>(options, _output);
}

class RoundedComboboxState<T1> extends State<RoundedCombobox<T1>> {
  RoundedComboboxState(this.options, this.output);
  Output<T1> output;

  List<DropdownMenuItem<T1>> _dropDownMenuItems() => getDropDownMenuItems();
  List<KeyValuePair<T1, String>> options;

  T1 _selectedItem;

  List<DropdownMenuItem<T1>> getDropDownMenuItems() {
    return widget.options
        .map((option) => new DropdownMenuItem<T1>(
            value: option.key,
            child: new Text(
              option.value,
              style: TextStyle(fontSize: this.widget.fontSize),
            )))
        .toList();
  }

  Widget _dropdownButton;

  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        this.widget.label
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Text(
                  this.widget.labelText,
                  style: TextStyle(fontSize: this.widget.fontSize),
                ),
              )
            : Container(),
        Expanded(
          flex: 100,
          child: Container(
            child: Padding(
              padding: this.widget.padding,
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

  void changedDropDownItem(T1 selectedTopic) {
    setState(() {
      output.setOutput(selectedTopic);
      this._dropdownButton = DropdownButton<T1>(
        value: output.getOutput(),
        items: _dropDownMenuItems(),
        onChanged: changedDropDownItem,
      );
    });
  }

  T1 getValue() {
    return _selectedItem;
  }

  @override
  void initState() {
    /// defaults the selected item to the first item in the provided items
    output.setOutput(options[0].key);
    this._dropdownButton = DropdownButton<T1>(
      value: output.getOutput(),
      items: _dropDownMenuItems(),
      onChanged: changedDropDownItem,
    );
    super.initState();
  }
}
