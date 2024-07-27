import 'package:eco_focus/db/app_database.dart';
import 'package:eco_focus/db/dao/category_dao.dart';
import 'package:eco_focus/models/category/category_model.dart';
import 'package:eco_focus/repositories/category_repository.dart';
import 'package:eco_focus/repositories/impl/category_repository_impl.dart';
import 'package:eco_focus/router/router_generator.dart';
import 'package:eco_focus/shared/widgets/custom_dropdown.dart';
import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartSessionScreen extends StatefulWidget {
  const StartSessionScreen({super.key});

  @override
  State<StartSessionScreen> createState() => _StartSessionScreenState();
}

class _StartSessionScreenState extends State<StartSessionScreen> {
  List<CategoryModel> categoryList = [];
  List<String> timerList = [
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    // "05:00",
    // "10:00",
    // "15:00",
    // "20:00",
    // "25:00",
    // "30:00",
    // "35:00",
    // "40:00",
    // "45:00",
    // "50:00",
    // "55:00",
    // "60:00",
  ];
  String selectedTimer = "";
  String selectedCategory = "";

  void getCategoryList() async {
    CategoryRepository categoryRepository =
        CategoryRepositoryImpl(CategoryDao(AppDatabase.instance));

    var seededCategoryList = await categoryRepository.getAllCategory();
    if (seededCategoryList != null) {
      setState(
        () {
          categoryList = seededCategoryList;
          selectedCategory = categoryList.first.name;
          selectedTimer = timerList.first;
        },
      );
      print("SEEDED CATEGORY LIST: $seededCategoryList");
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.only(top: 100.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidgets.titleText(text: 'Start Focus Session'),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.recycling, size: 100.0),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 5),
                if (categoryList.isNotEmpty) ...[
                  TextWidgets.secondaryTitleText(text: 'Select Category:'),
                  const SizedBox(height: 8),
                  CustomDropdown(
                      onSelectedValue: (val) =>
                          setState(() => selectedCategory = val),
                      selectedValue: selectedCategory,
                      valueList: categoryList.map((e) => e.name).toList()),
                ],
                const SizedBox(height: 20.0),
                if (selectedTimer.isNotEmpty) ...[
                  TextWidgets.secondaryTitleText(text: 'Select Focus Time:'),
                  const SizedBox(height: 8),
                  CustomDropdown(
                    onSelectedValue: (val) =>
                        setState(() => selectedTimer = val),
                    selectedValue: selectedTimer,
                    valueList: timerList,
                  ),
                ],
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/live-session',
                    arguments: LiveSessionArguments(
                      selectedCategory: categoryList
                          .firstWhere((val) => val.name == selectedCategory),
                      selectedFocusTime: selectedTimer,
                    ),
                  ),
                  child: const Text('Start'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
