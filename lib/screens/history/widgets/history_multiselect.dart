import 'package:cosinuss/screens/history/models/history_session.dart';
import 'package:flutter/material.dart';

class HistoryMultiSelect<V> extends StatefulWidget {
  const HistoryMultiSelect({Key? key, required this.items, required this.initialSelectedValues}) : super(key: key);

  final List<HistorySession<V>> items;
  final Set<V> initialSelectedValues;

  @override
  State<HistoryMultiSelect> createState() => HistoryMultiSelectState<V>();
}



class HistoryMultiSelectState<V> extends State<HistoryMultiSelect<V>> {

  final _selectedValues = Set<V>();

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _canceled() {
    Navigator.pop(context);
  }

  void _submitted() {
    Navigator.pop(context, _selectedValues);
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("select training session(s)"),
      content: SingleChildScrollView(
        child: ListTileTheme(
            child: ListBody(
              children: widget.items.map(_buildItem).toList(),
            )
        ),
      ),
      actions: <Widget> [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: _canceled,
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: _submitted,
        )
      ],
    );
  }
  Widget _buildItem(HistorySession<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked!),
    );
  }
}


