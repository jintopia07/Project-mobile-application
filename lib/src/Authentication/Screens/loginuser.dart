// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Models/AuthenticatedUser.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/Authentication/Models/user_facebook.dart';
import 'package:nat/src/Authentication/Screens/ForgetPasswordPage.dart';
import 'package:nat/src/Employee/Screens/launcher_employee.dart';
import 'package:nat/src/Member/Screens/THMember/launcherUser.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';
import 'package:nat/utils/apphelper.dart';
import 'package:nat/utils/memberactivity.dart';
import 'package:nat/controllers/login-controller.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/Register/Screens/register.dart';
import 'package:nat/utils/form_helper.dart';
import 'package:provider/provider.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({Key key}) : super(key: key);

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _username = "";
  String _password = "";
  bool hidePassword = true;
  bool isApicallProcess = false;
  AccessToken _accessToken;
  UserModel _currentUser;

  void login() async {
    AuthenticationService authenticationService =
        AuthenticationService(WebAPI_Config.mainWebAPIURL);
    var authenticatedUser =
        await authenticationService.authen(_username, _password);
    if (authenticatedUser != null) {
      await authenticationService.saveAuthenticatedUser(authenticatedUser);
      if (authenticatedUser.GetRole() == UserRole.member) {
        var memberInfo = await MemberProfileService(WebAPI_Config.mainWebAPIURL)
            .getMemberProfile(authenticatedUser.username);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LauncherUser(memberInfo)),
            (route) => false);
      } else if (authenticatedUser.GetRole() == UserRole.employee) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LauncherEmployee()),
            (route) => false);
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Warning'),
              content: const Text('ไม่พบข้อมูลสมาชิก'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('เข้าสู่ระบบ'),
          backgroundColor: Colors.teal[600],
        ),
        body: Center(
          child: Container(
            height: 1000,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: _loginSetup(context),

            // child: ProgressHUD(
            //   child: _loginSetup(context),
            //   inAsyncCall: isApicallProcess,
            //   opacity: 0.3,
            // ),
          ),
        ),
      ),
    );
  }

  Widget _loginSetup(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: globalFormKey,
        child: loginGoogle(),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height / 3.8,
            child: Column(),
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding * 0.30),
            // margin: const EdgeInsets.only(left: 125, right: 125),
            height: 120,
            width: 120,
            child: Image.asset("assets/images/logo.png"),
          ),
          const SizedBox(height: defaultPadding * 2.5),
          Padding(
            //padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 1.5),
            child: FormHelper.inputFieldWidget(
                context, const Icon(Icons.verified_user), "username", "ชื่อผู้ใช้งาน",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'กรุณากรอกข้อมูล';
              }
              return null;
            }, (onSavedValue) {
              _username = onSavedValue.toString().trim();
            }),
          ),
          const SizedBox(height: defaultPadding * 1.5),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 1.5),
            child: FormHelper.inputFieldWidget(
                context, const Icon(Icons.lock), "password", "รหัสผ่าน",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'กรุณากรอกรหัสผ่าน';
              }
              return null;
            }, (onSavedValue) {
              _password = onSavedValue.toString().trim();
            },
                initialValue: "",
                obscureText: hidePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  color: Colors.tealAccent[400].withOpacity(0.4),
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                )),
          ),
          const SizedBox(height: defaultPadding * 2.5),
          Center(
            child: FormHelper.loginButton(
              "เข้าสู่ระบบ",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApicallProcess = true;
                  });
                  login();
                }
              },
            ),
          ),
          const SizedBox(height: defaultPadding * 1.5),
          Center(
            child: FormHelper.saveButton(
              "ลงทะเบียน",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: defaultPadding * 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 1.5),
            child: TextButton(
              style: TextButton.styleFrom(primary: Colors.green[900]),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgetPasswordPage(),
                  ),
                );
              },
              child: const Text('ลืมชื่อผู้ใช้งาน/รหัสผ่าน'),
            ),
          ),
          const SizedBox(height: defaultPadding * 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 1.5),
            child: const Text(
                'ลงทะเบียนสำหรับผู้ค้นคว้าที่ยังไม่มีบัญชีผู้ใช้งาน หรือเข้าใช้งานผ่าน Facebook,Google'),
          ),
          const SizedBox(height: defaultPadding * 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 1.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Image(
                    image: const AssetImage('assets/images/google.png'),
                    width: 40,
                    height: 40,
                  ),
                  onTap: () {
                    Provider.of<LoginController>(context, listen: false)
                        .googleLogin();
                  },
                ),
                const SizedBox(width: defaultPadding * 3),
                InkWell(
                  child: Image(
                    image: const AssetImage('assets/images/facebookicon.png'),
                    width: 40,
                    height: 40,
                  ),
                  onTap: () {
                    facebooklogin();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      ),
    );
  }

  Widget loginGoogle() {
    return Consumer<LoginController>(builder: (context, model, child) {
      if (model.userDetails != null) {
        return Center(
          child: loggedInUI(model),
        );
      } else {
        return _loginUI(context);
      }
    });
  }

  loggedInUI(LoginController model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        CircleAvatar(
          backgroundImage:
              Image.network(model.userDetails.photoURL ?? "").image,
          radius: 50,
        ),

        const SizedBox(height: 15),
        Text(model.userDetails.displayName ?? ""),
        const SizedBox(height: 10),
        Text(model.userDetails.email ?? ""),

        const SizedBox(height: 10),

        //logout
        ActionChip(
          avatar: const Icon(Icons.logout),
          label: const Text("Logout"),
          onPressed: () {
            Provider.of<LoginController>(context, listen: false).logout();
          },
        )
      ],
    );
  }

  Future<void> facebooklogin() async {
    final LoginResult result = await FacebookAuth.i.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final data = await FacebookAuth.i.getUserData();
      UserModel model = UserModel.fromJson(data);

     

      setState(() {
         _currentUser = model;
        
      });
    }return Center(
      child: loginFacebook(),
    );
  }

  loginFacebook() {
    UserModel user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          // CircleAvatar(
          //   backgroundImage: Image.network(user.pictureModel.url).image,
          //   radius: 50,
          // ),

          const SizedBox(height: 15),
          Text(user.name),
          const SizedBox(height: 10),
          Text(user.email),

          const SizedBox(height: 10),

          //logout
          ActionChip(
            avatar: const Icon(Icons.logout),
            label: const Text("Logout"),
            onPressed: () {
              facebooklogout();
            },
          )
        ],
      );
    }
  }


  Future<void> facebooklogout() async {
    await FacebookAuth.i.logOut();

    setState(() {
      _currentUser = null;
      _accessToken = null;
    });
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
