import 'package:expense/models/expense.dart';
import 'package:expense/widget/expenses_List/expnses.item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.exp, required this.onRemove});

  final List<Expense> exp;
  final void Function(Expense expense) onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exp.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(exp[index]),
        onDismissed: (direction) {
          onRemove(exp[index]);
        },
        child: ExpenseItem(exp[index]),
      ),
    );
  }
}
