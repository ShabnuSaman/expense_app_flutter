import 'package:expense_tracker/expense_card.dart';
import 'package:expense_tracker/models/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expense,required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;

  final List<Expense> expense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expense.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed:(direction){
            onRemoveExpense(expense[index]);
          },
            key: ValueKey(expense[index]), child: ExpenseCard(expense[index])));
  }
}
