import 'package:flutter/material.dart';
import "package:expense_tracker/models/expense_list/expense_item.dart";

class AddExpense extends StatefulWidget {
  const AddExpense({super.key,required this.addNewExpenses});
  final void Function(Expense expense) addNewExpenses;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  Category _selectedItem = Category.others;
  DateTime? _selectedDate;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _showDatePickercalender() async {
    // final now = DateTime.now();
    // final firstDate = DateTime(now.year - 5, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2030));
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void submitData() {
    var amount = double.tryParse(_amountController.text);
    var invalidAmount = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error"),
          content: const Text("please enter  complete data"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("close"))
          ],
        ),
      );
      return;
    }
    widget.addNewExpenses(Expense(title: _titleController.text, amount: amount, date: _selectedDate!, category: _selectedItem));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text("Title")),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    decoration: const InputDecoration(
                        label: Text("amount"), prefixText: '\$'),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? "no date selected"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _showDatePickercalender,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ))
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton(
                    value: _selectedItem,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedItem = value;
                      });
                    }),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancel")),
                ElevatedButton(
                    onPressed: () {
                      submitData();
                      Navigator.pop(context);
                    },
                    child: const Text("save"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
