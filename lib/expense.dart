import 'package:expense_tracker/add_expense.dart';
import 'package:expense_tracker/models/expense_list/expense_item.dart';
import 'package:expense_tracker/models/expense_list/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  void _addExpenseList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => AddExpense(
              addNewExpenses: addExpense,
            ));
  }

  void _onRemoveExpense(Expense expense) {
    final expenseIndex = _registeredList.indexOf(expense);
    setState(() {
      _registeredList.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text("delete expense"),
          action: SnackBarAction(
            label: "undo",
            onPressed: () {
              setState(() {
                _registeredList.insert(expenseIndex, expense);
              });
            },
          )),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      _registeredList.add(expense);
    });
  }

  final List<Expense> _registeredList = [];

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("there is nothing..add some new expenses"),
    );
    if (_registeredList.isNotEmpty) {
      mainContent = ExpenseList(
        expense: _registeredList,
        onRemoveExpense: _onRemoveExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 62, 210),
        title: Text(
          "Expense Tracker",
          style: GoogleFonts.lato(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () => _addExpenseList(context),
                icon: const Icon(Icons.add,color: Colors.white,)),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
