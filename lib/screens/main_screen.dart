import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profle_screeen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:expenz/services/expence_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageInex = 0;

  List<Expense> expensesList = [];
  List<Income> incomeList = [];

// function to fetch expenses
  void fetchExpenses() async {
    List<Expense> loadedExpenses = await ExpenceService().loadExpenses();
    setState(() {
      expensesList = loadedExpenses;
    });
  }

  // add new expense
  void addNewExpense(Expense newExpense) {
    ExpenceService().saveExpense(newExpense, context);

    // Update the list expenses
    setState(() {
      expensesList.add(newExpense);
    });
  }

  // a function to remove expense
  void removeExpense(Expense expense) {
    ExpenceService().deleteExpense(expense.id, context);

    // Update the list expenses
    setState(() {
      expensesList.remove(expense);
    });
  }

// a function to fetch income data
  void fetchIncomes() async {
    List<Income> loadedIncomes = await IncomeServices().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
    });
  }

  // add a new income to the list
  void addNewIncome(Income newIncome) {
    IncomeServices().saveIncome(newIncome, context);

    setState(() {
      incomeList.add(newIncome);
    });
  }

  void removeIncome(Income income) {
    IncomeServices().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchExpenses();
    fetchIncomes();

    setState(() {
      fetchExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    // curent page index

    // Screen list
    final List<Widget> pages = [
      HomeScreen(),
      TransactionScreen(
        expensesList: expensesList,
        incomeList: incomeList,
        onDismissedExpenses: removeExpense,
        onDismissedIncome: removeIncome,
      ),
      AddNewScreen(
        addExpense: addNewExpense,
        addIncome: addNewIncome,
      ),
      BudgetScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kWhite,
          selectedItemColor: kMainColor,
          unselectedItemColor: kGrey,
          onTap: (index) {
            setState(() {
              _currentPageInex = index;
            });
          },
          currentIndex: _currentPageInex,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.list_rounded,
                ),
                label: "Transactions"),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: kMainColor, shape: BoxShape.circle),
                child: const Icon(
                  Icons.add,
                  color: kWhite,
                  size: 30,
                ),
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.rocket,
                ),
                label: "Budget"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile"),
          ]),
      body: pages[_currentPageInex],
    );
  }
}
