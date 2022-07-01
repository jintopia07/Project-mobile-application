// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nat/src/Authentication/Models/AuthenticatedUser.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/Employee/Screens/launcher_employee.dart';
import 'package:nat/src/Infomation/Screens/launcher.dart';
import 'package:nat/src/Member/Screens/THMember/launcherUser.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';
import 'package:nat/utils/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/utils/local_notification_service.dart';
import 'controllers/login-controller.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // Intl.defaultLocale = "th";
  // initializeDateFormatting();

  runApp(const MyApp());
  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Widget _body = Center(child: const CircularProgressIndicator());
  // @override
  
  @override
  Widget build(BuildContext context) => _body;

  Future<void> createLauncher() async {
    AuthenticationService authenticationService =
        AuthenticationService(WebAPI_Config.mainWebAPIURL);
    AuthenticationService.getAuthenticatedUser().then((authenticatedUser) => {
          setState(() => {
                if (authenticatedUser != null)
                  {
                    if (authenticatedUser.GetRole() == UserRole.employee)
                      {displayEmployeeLauncher()}
                    else if (authenticatedUser.GetRole() == UserRole.member)
                      {
                        MemberProfileService(WebAPI_Config.mainWebAPIURL)
                            .getMemberProfile(authenticatedUser.username)
                            .then((memberInfo) =>
                                {displayMemberLauncher(memberInfo)})
                      }
                  }
                else
                  {displayDefaultLauncher()},
              }),
        });
  }

  void displayMemberLauncher(MemberInfo memberInfo) {
    setState(() {
      _body = ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            final provider = Provider.of<LocaleProvider>(context);
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => LoginController(),
                )
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    fontFamily: "Kanit",
                    brightness: Brightness.light,
                    primaryColor: Colors.teal[600], colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors.cyan[600])),
                initialRoute: '/', // สามารถใช้ home แทนได้
                routes: <String, WidgetBuilder>{
                  Launcher.routeName: (context) => LauncherUser(memberInfo),
                  '/menulauncher': (BuildContext context) =>
                      LauncherUser(memberInfo),
                },
                locale: provider.locale,
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
              ),
            );
          });
    });
  }

  void displayEmployeeLauncher() {
    setState(() {
      _body = ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            final provider = Provider.of<LocaleProvider>(context);
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => LoginController(),
                )
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                   //text styling
                    textTheme: const TextTheme(
                      headline2: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w700 , color: Colors.brown),
                      bodyText2: TextStyle(fontSize: 14.0),
                      bodyText1: TextStyle(fontSize: 15.0 , color: Colors.brown),
                    ),
                    fontFamily: "Kanit",
                    brightness: Brightness.light,
                    primaryColor: Colors.teal[600], colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors.cyan[600])),
                initialRoute: '/', // สามารถใช้ home แทนได้
                routes: <String, WidgetBuilder>{
                  Launcher.routeName: (context) => const LauncherEmployee(),
                  '/menulauncher': (BuildContext context) => const LauncherEmployee(),
                },
                locale: provider.locale,
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
              ),
            );
          });
    });
  }

  void displayDefaultLauncher() {
    setState(() {
      _body = ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            final provider = Provider.of<LocaleProvider>(context);
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => LoginController(),
                )
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    fontFamily: "Kanit",

                    //text styling
                    textTheme: const TextTheme(
                      headline1: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w700),
                      bodyText2: TextStyle(fontSize: 12.0),
                    ),
                    brightness: Brightness.light,
                    primaryColor: Colors.teal[600], colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors.cyan[600])),
                initialRoute: '/', // สามารถใช้ home แทนได้
                routes: <String, WidgetBuilder>{
                  Launcher.routeName: (context) => const Launcher(),
                  '/menulauncher': (BuildContext context) => const Launcher(),
                },
                locale: provider.locale,
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
              ),
            );
          });
    });
  }

  @override
  void initState() {
    Future.wait([createLauncher()]);
    super.initState();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.body);
        print(message.notification.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }
}
