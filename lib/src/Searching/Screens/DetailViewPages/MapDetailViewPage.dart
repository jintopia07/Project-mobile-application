// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Authentication/Models/AuthenticatedUser.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/Config/WebSite_Config.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/MemberProfile/Services/MemberProfileService.dart';
import 'package:nat/src/MemberOrder/Services/MemberOrderingService.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/src/Authentication/Services/AuthenticationService.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/MapListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/NearestMapListViewPage.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';
import 'package:nat/src/Searching/Services/NATSearcherProvider.dart';
import 'package:nat/widgets/customConfirmDialog.dart';
import 'package:nat/widgets/showprogress.dart';

class MapDetailViewPage extends StatefulWidget {
  final DigitalFile digitalFile;

  const MapDetailViewPage({Key key, this.digitalFile}) : super(key: key);

  @override
  MapDetailViewPageState createState() => MapDetailViewPageState();
}

class MapDetailViewPageState extends State<MapDetailViewPage> {
  DigitalFile currentDigitalFile = DigitalFile();
  AuthenticatedUser authenticatedUser;
  MemberInfo memberInfo;
  String memberCardID;
  NATSearcher natSearcher;

  Widget _body = Center(child: const CircularProgressIndicator());

  ArchivesDataQuantity archivesDataQuantity;

  List<DigitalFile> nearestDigitalFiles = List<DigitalFile>.empty();

  Future<void> initialize() async {
    authenticatedUser = await AuthenticationService.getAuthenticatedUser();
    memberCardID = authenticatedUser.username;

    MemberProfileService memberProfileService =
        MemberProfileService(WebAPI_Config.mainWebAPIURL);
    memberInfo = await memberProfileService.getMemberProfile(memberCardID);
  }

  Future<void> initializeInfoMaps() async {
    natSearcher = NATSearcherProvider().natSearcher;
    currentDigitalFile = widget.digitalFile;

    nearestDigitalFiles =
        await natSearcher.getNearestDigitalFiles(currentDigitalFile);
  }

  Future<void> onDigitalFileOrderClick() async {
    MemberOrderingService memberOrderingService =
        MemberOrderingService(WebAPI_Config.mainWebAPIURL, memberCardID);

    var result = await memberOrderingService.postSelectedDigitalFile(
        memberCardID, currentDigitalFile);

    if (result.statusCode == 200) {
      showMessageDialog(
              context, "NAT Archives", "เพิ่มข้อมูลรายการขอทำสำเนาเรียบร้อย")
          .then((result) =>
              {Navigator.of(context).popUntil((route) => route.isFirst)});
    } else {
      String reson = result.reasonPhrase;
      showMessageDialog(context, "NAT Archives", reson);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  @override
  void initState() {
    super.initState();
    initialize().then((value) => {
          initializeInfoMaps().then((value) => {showInfoMaps()})
        });
  }

  showInfoMaps() async {
    setState(() => {
          _body = Scaffold(
            appBar: AppBar(
              title: const Text('ระบบสืบค้นหาเอกสารจดหมายเหตุ'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.white),
                  onPressed: (() {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapListViewPage(),
                        ),
                        (Route<dynamic> route) => false);
                  }),
                ),
              ],
              backgroundColor: Colors.teal[600],
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                    top: defaultPadding * 1.5,
                    right: defaultPadding * 1,
                    left: defaultPadding * 1,
                    bottom: defaultPadding * 1.5),
                child: Column(
                  children: <Widget>[
                    _displayimage(currentDigitalFile),
                    const SizedBox(
                      height: defaultPadding * 1.5,
                    ),
                    _getinfo(currentDigitalFile),
                    SizedBox(height: defaultPadding * 1.5),
                    Container(
                      height: 800,
                      child: NearestMapListViewPage(
                        nearestDigitalFiles,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        });
  }

  Widget _displayimage(DigitalFile digitalFile) => Container(
        height: 300,
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 8, vertical: defaultPadding / 1),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  WebSite_Config.mainWebSiteURLWithSAndDigitalFileFolder +
                      digitalFile.storedPathThumnail),
              fit: BoxFit.cover),
        ),
      );

  Widget _getinfo(DigitalFile digitalFile) => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  //horizontal: defaultPadding,
                  vertical: defaultPadding / 1,
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "รหัสเอกสาร :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(digitalFile.nameArachiveDigitalFile),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "ชื่อไฟล์ดิจิทัล :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(digitalFile.digitalFileName),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "ชื่อเรื่อง :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                        digitalFile.content.archiveDocumentAccount.accountName),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "รายละเอียด :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(digitalFile
                        .content.archiveDocumentAccount.description
                        .toString()),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "ระยะเวลา :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text('ม.ท'),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "แหล่งที่มาเอกสาร :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(digitalFile.resourceDigitalFile),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 1,
                ),
                alignment: FractionalOffset.topCenter,
                child: ListTile(
                  title: const Text(
                    "หน่วยงาน :",
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(digitalFile.branchName),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: defaultPadding * 1),
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.all(defaultPadding),
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 4,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.teal[800]),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.white)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 1)),
                    ),
                    onPressed: () {
                      Future.delayed(const Duration(seconds: 1)).then(
                        (value) {
                          hideProgress().whenComplete(
                            () {
                              popDialog(context, 'ยืนยันการทำสำเนาหรือไม่');
                            },
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(6, 0, 10, 0),
                            child: Image(
                              image: const AssetImage('assets/images/cart.png'),
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            color: Colors.teal[800],
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: Text(
                              'ทำสำเนา',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Kanit"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> popDialog(BuildContext context, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
          message,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false),
                  child: const Text(
                    'ยกเลิก',
                    style: TextStyle(color: Colors.red),
                  )),
              ElevatedButton(
                  onPressed: () => {onDigitalFileOrderClick()},
                  child: Text(
                    'ตกลง',
                    style: TextStyle(color: Colors.teal[600]),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
