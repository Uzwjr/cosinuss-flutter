import 'package:cosinuss/screens/history/models/history_session.dart';
import 'package:flutter/material.dart';

class HistoryMultiSelect extends StatefulWidget {
  const HistoryMultiSelect({Key? key, required this.items}) : super(key: key);

  final List<HistorySession> items;

  @override
  State<HistoryMultiSelect> createState() => HistoryMultiSelectState();
}



class HistoryMultiSelectState extends State<HistoryMultiSelect> {

  final _selectedValues = Set<HistorySession>();

  void _canceled() {
    Navigator.pop(context);
  }

  void _submitted() {
    Navigator.pop(context, _selectedValues);
  }

  void _onItemCheckedChange(HistorySession historySession, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(historySession);
      } else {
        _selectedValues.remove(historySession);
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
  Widget _buildItem(HistorySession item) {
    final checked = _selectedValues.contains(item);
    return CheckboxListTile(
      value: checked,
      title: Text(item.name),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item, checked!),
    );
  }
}


