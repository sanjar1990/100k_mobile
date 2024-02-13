import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yuzk_mobile/manage_category/model/categoryModel.dart';
import 'package:yuzk_mobile/person.dart';
import 'package:yuzk_mobile/routes/route_helper.dart';
import 'package:yuzk_mobile/staff.dart';
import 'helper/dependencies.dart' as dep;
import 'boxes.dart';

final colorScheme=ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 232, 13, 13),
brightness:  Brightness.dark,
background: Colors.white
);
final theme=ThemeData().copyWith(
    scaffoldBackgroundColor: colorScheme.background,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
        titleSmall: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold
        ),
        titleMedium: GoogleFonts.ubuntuCondensed().copyWith(
            fontWeight: FontWeight.bold
        ),
        titleLarge: GoogleFonts.ubuntuCondensed().copyWith(
            fontWeight: FontWeight.bold
        )
    )
);
final fontTheme = TextTheme(
  displayLarge: GoogleFonts.openSans(fontWeight: FontWeight.w700, fontSize: 16),
  displaySmall: GoogleFonts.openSans(fontWeight: FontWeight.w700, fontSize: 12),
  displayMedium: GoogleFonts.openSans(fontWeight: FontWeight.w700, fontSize: 14),
);
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter('MyLocation');

  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(StaffAdapter());
  Hive.registerAdapter(CategoryModelAdapter());


  boxPersons = await Hive.openBox<Person>('personBox1');
  boxStaffs = await Hive.openBox<Staff>('staffBox');
  // boxStaffList = await Hive.openBox<List<Staff2>>('staffBoxList');
  boxCategory = await Hive.openBox<CategoryModel>('categoryBox');
  // boxCategoryList.clear();

  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '100 K',
      debugShowCheckedModeBanner: false,
      // home: const MainHomePage(),
      theme: theme,
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,

    );
  }
}