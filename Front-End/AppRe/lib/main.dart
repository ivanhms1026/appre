import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:appre/administrator_module/administratorModule.dart';
import 'package:appre/colors.dart';
import 'package:appre/menu_app/login/login.dart';
import 'package:appre/menu_app/login/session.dart';
import 'package:appre/menu_app/profile/profile_menu.dart';
import 'package:appre/super_administrator_module/superModule.dart';
import 'package:appre/menu_app/textScalefactor/RehabilitationZoneScalefactor.dart';

/// This "main" function is the entry point of the Flutter application.
///
/// It is responsible for initializing the application and determining the initial page
/// based on the values stored in SharedPreferences.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Session.initialize();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final int? id = sharedPreferences.getInt('id');
  final String? name = sharedPreferences.getString('name');
  final String? lastname = sharedPreferences.getString('lastname');
  final String? document = sharedPreferences.getString('document');
  final String? phone = sharedPreferences.getString('phone');
  final String? user = sharedPreferences.getString('user');
  final String? pass = sharedPreferences.getString('pass');
  final int? userLevel = sharedPreferences.getInt('userLevel');
  final int? userState = sharedPreferences.getInt('userState');

  Widget initialPage;

  if (id != null && user != null && pass != null && userLevel != null && userState != null) {
    UserCredentials credentials =
        UserCredentials(id!, name!, lastname!, document!, phone!, user, pass, userLevel, userState);
    if (userLevel == 1) {
      initialPage = SuperModule(credentials: credentials);
    } else if (userLevel == 2) {
      initialPage = AdministratorModule(credentials: credentials);
    } else if (userLevel == 3 && userState == 1) {
      initialPage = Main(credentials: credentials);
    } else {
      initialPage = const Login();
    }
  } else {
    initialPage = const Login();
  }

  runApp(MyApp(initialPage: initialPage, user: user, pass: pass));
}

/// The `MyApp` class is a main widget of the Flutter application that configures its overall structure.
/// Defines the home page, theme, and other settings required for the application.
class MyApp extends StatelessWidget {
  final Widget initialPage;
  final String? user;
  final String? pass;
  final int? userLevel;

  const MyApp({Key? key, required this.initialPage, this.user, this.pass, this.userLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 823),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black,
          ),
          home: initialPage,
        );
      },
    );
  }
}

/// The `Main` class is a widget that represents the main screen of the application.
/// Receives the user's credentials and creates its state (_MainState).
class Main extends StatefulWidget {
  final UserCredentials credentials;

  const Main({super.key, required this.credentials});

  @override
  _MainState createState() => _MainState(credentials);
}

/// The `_MainState` class is the state of the application's main screen (Main).
/// Controls the view and user interaction on this screen.
class _MainState extends State<Main> {
  int _selectedIndex = 0;
  final UserCredentials credentials;

  _MainState(this.credentials);

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const RehabilitationZoneScalefactor(),
      ProfileMenu(credentials: credentials),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black12),
    );

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColor.colorBlack,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: AppColor.colorTextOne.withOpacity(.0),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            child: GNav(
              rippleColor: AppColor.colorWhite.withOpacity(0.4),
              hoverColor: AppColor.colorWhite.withOpacity(0.4),
              gap: 5,
              activeColor: AppColor.colorBlack,
              iconSize: 22.h,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
              duration: const Duration(milliseconds: 500),
              tabBackgroundColor: AppColor.colorWhite.withOpacity(0.8),
              color: AppColor.colorWhite.withOpacity(0.8),
              tabs: const [
                GButton(
                  icon: Icons.favorite_border_outlined,
                  text: 'Rehabilitación',
                ),
                GButton(
                  icon: Icons.manage_accounts_outlined,
                  text: 'Perfil',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
