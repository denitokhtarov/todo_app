import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/themes/set_system_ui_overlay_style.dart';
import 'package:todo_app/themes/theme_checker.dart';
import 'package:todo_app/themes/dark_theme.dart';
import 'package:todo_app/themes/light_theme.dart';
import 'package:todo_app/widgets/group_form/group_form_widget_model.dart';
import 'package:todo_app/widgets/groups/group_widget.dart';
import 'package:todo_app/widgets/groups/groups_widget_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GroupFormWidgetModel>(
          create: (context) => GroupFormWidgetModel(),
        ),
        ChangeNotifierProvider<GroupsWidgetModel>(
          create: (context) => GroupsWidgetModel(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle(context);
    return CupertinoApp(
      theme: isDarkTheme(context) ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/groups': (context) => const GroupWidget(),
      },
      home: const GroupWidget(),
    );
  }
}
