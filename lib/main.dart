import 'package:eco_focus/db/dao/category_dao.dart';
import 'package:eco_focus/db/dao/session_dao.dart';
import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/features/liveSession/live_session_view_model.dart';
import 'package:eco_focus/features/settings/settings_view_model.dart';
import 'package:eco_focus/features/treeGrowth/tree_growth_view_model.dart';
import 'package:eco_focus/main_screen.dart';
import 'package:eco_focus/models/category/category_model.dart';
import 'package:eco_focus/repositories/category_repository.dart';
import 'package:eco_focus/repositories/impl/category_repository_impl.dart';
import 'package:eco_focus/repositories/impl/session_repository_impl.dart';
import 'package:eco_focus/repositories/session_repository.dart';
import 'package:eco_focus/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eco_focus/db/app_database.dart';
import 'package:eco_focus/db/dao/app_config_dao.dart';
import 'package:eco_focus/features/auth/auth_view_model.dart';
import 'package:eco_focus/repositories/auth_repository.dart';
import 'package:eco_focus/repositories/impl/app_config_respository_impl.dart';
import 'package:eco_focus/repositories/impl/auth_repository_impl.dart';
import 'package:eco_focus/router/router_generator.dart';
import 'package:eco_focus/services/rest/rest_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.getDb();
  await RestService.instance.initDio();
  runApp(MultiProvider(
    providers: [
      Provider<AppDatabase>(create: (context) => AppDatabase.instance),
      Provider<RestService>(create: (context) => RestService.instance),
      Provider<SessionDao>(
          create: (context) => SessionDao(AppDatabase.instance)),
      Provider<AuthRepository>(
        create: (context) =>
            AuthRepositoryImpl(restService: RestService.instance),
      ),
      Provider<SessionRepository>(
        create: (context) => SessionRepositoryImpl(
          SessionDao(AppDatabase.instance),
        ),
      ),
      Provider<CategoryRepository>(
        create: (context) => CategoryRepositoryImpl(
          CategoryDao(AppDatabase.instance),
        ),
      ),
      ChangeNotifierProvider<SettingsViewModel>(
        create: (context) => SettingsViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => TreeGrowthViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthViewModel(
          authRepository: AuthRepositoryImpl(restService: RestService.instance),
          appConfigRepository: AppConfigRepositoryImpl(
            appConfigDao: AppConfigDao(AppDatabase.instance),
          ),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => LiveSessionViewModel(
          sessionRepository:
              SessionRepositoryImpl(SessionDao(AppDatabase.instance)),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeScreenViewModel(
          sessionRepository:
              SessionRepositoryImpl(SessionDao(AppDatabase.instance)),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

void _seedCategoryList() async {
  var categoryList = [
    const CategoryModel(id: '1', name: 'Read', icon: 'Read'),
    const CategoryModel(id: '2', name: 'Study', icon: 'Study'),
    const CategoryModel(id: '3', name: 'Work', icon: 'Work'),
  ];
  try {
    CategoryRepository categoryRepository =
        CategoryRepositoryImpl(CategoryDao(AppDatabase.instance));

    var seededCategoryList = await categoryRepository.getAllCategory();

    if (seededCategoryList == null || seededCategoryList.isEmpty) {
      for (var element in categoryList) {
        await categoryRepository.insertCategory(element);
      }
    }
  } catch (e) {
    throw Exception(e);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MaterialTheme materialTheme = const MaterialTheme(TextTheme());

  @override
  void initState() {
    super.initState();

    _seedCategoryList();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Eco Focus',
          debugShowCheckedModeBanner: false,
          theme:
              value.isDarkTheme ? materialTheme.dark() : materialTheme.light(),
          initialRoute: '/main',
          onGenerateRoute: RouterGenerator.generateRoute,
          home: const MainScreen(),
        );
      },
    );
  }
}
