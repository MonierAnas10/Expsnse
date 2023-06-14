import 'dart:math';

import 'package:expense/widget/chart/chart.dart';
import 'package:expense/widget/expenses_List/expenses_list.dart';
import 'package:expense/models/expense.dart';
import 'package:expense/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpences = [
    Expense(
        title: 'flutter',
        amount: 12.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'cinma',
        amount: 13.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpences.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpences.indexOf(expense);
    setState(() {
      _registeredExpences.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 3,
        ),
        content: const Text('EXPENSE DELETED !! '),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              setState(() {
                _registeredExpences.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No Expenses Found , Start Adding some !'),
    );
    if (_registeredExpences.isNotEmpty) {
      mainContent = ExpensesList(
        exp: _registeredExpences,
        onRemove: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpences),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpences),
                ),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
