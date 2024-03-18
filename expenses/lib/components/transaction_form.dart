import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {

  final Function (String, double, DateTime) onAddTransaction;

  TransactionForm({
    required this.onAddTransaction
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0.0 || _selectedDate == null) {
      return;
    }

    widget.onAddTransaction(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now()
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _selectedDate = selectedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título'
              ),
            ),
            TextField(
              controller: _valueController,
              decoration: InputDecoration(
                labelText: 'Valor (R\$)'
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (value) => _submitForm(),
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null ? 
                      'Nenhuma data selecionada!' :
                      'Data selecionada: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker, 
                    child: Text('Selecionar data')
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitForm, 
              child: Text('Nova Transação'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white
              )
            )
          ],
        ),
      ),
    );
  }
}