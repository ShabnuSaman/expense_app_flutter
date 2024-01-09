import 'package:expense_tracker/models/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 111, 93, 202),
      child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                expense.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text("\$${expense.amount.toStringAsFixed(2)}",style: const TextStyle(color: Colors.white,fontSize: 18),),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        categoryIcons[expense.category],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(expense.formattedDate,style: const TextStyle(fontSize: 18,color: Colors.white),),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
