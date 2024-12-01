import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> visitors;

  const MultiSelectDropdown({super.key, required this.visitors});

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedVisitors = [];

  void _showMultiSelectDialog() async {
    final List<String>? selectedValues = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return MultiSelectDialog(
          visitors: widget.visitors,
          selectedValues: _selectedVisitors,
        );
      },
    );

    if (selectedValues != null) {
      setState(() {
        _selectedVisitors = selectedValues;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Acompañantes',
            suffixIcon: Icon(Icons.arrow_drop_down),
          ),
          onTap: _showMultiSelectDialog,
          controller: TextEditingController(
            text: _selectedVisitors.isEmpty
                ? 'Seleccione acompañantes'
                : _selectedVisitors.join(', '),
          ),
        ),
      ],
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<Map<String, dynamic>> visitors;
  final List<String> selectedValues;

  const MultiSelectDialog({
    super.key,
    required this.visitors,
    required this.selectedValues,
  });

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _tempSelectedValues;

  @override
  void initState() {
    super.initState();
    _tempSelectedValues = [...widget.selectedValues];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccione los acompañantes'),
      content: SingleChildScrollView(
        child: Column(
          children: widget.visitors.map((visitor) {
            final String description = visitor['nombre'] ?? 'Sin nombre';
            return CheckboxListTile(
              value: _tempSelectedValues.contains(description),
              title: Text(description),
              onChanged: (bool? selected) {
                setState(() {
                  if (selected == true) {
                    _tempSelectedValues.add(description);
                  } else {
                    _tempSelectedValues.remove(description);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _tempSelectedValues),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
