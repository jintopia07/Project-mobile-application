// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebSite_Config.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Searching/Screens/DetailViewPages/SoundDetailViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/NearestVideoListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/VideoListViewPage.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';
import 'package:nat/src/Searching/Services/NATSearcherProvider.dart';
import 'package:nat/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

class VideoDetailViewPage extends StatefulWidget {
  final DigitalFile digitalFile;
  const VideoDetailViewPage({Key key, this.digitalFile}) : super(key: key);

  @override
  SoundDetailViewPageState createState() => SoundDetailViewPageState();
}

class SoundDetailViewPageState extends State<SoundDetailViewPage> {
  NATSearcher natSearcher;

  DigitalFile currentDigitalFile = DigitalFile();

  Widget _body = Center(child: const CircularProgressIndicator());

  ArchivesDataQuantity archivesDataQuantity;

  List<DigitalFile> nearestDigitalFiles = List<DigitalFile>.empty();

  Future<void> initializeInfoVideos() async {
    natSearcher = NATSearcherProvider().natSearcher;
    currentDigitalFile = widget.digitalFile;

    nearestDigitalFiles =
        await natSearcher.getNearestDigitalFiles(currentDigitalFile);
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  @override
  void initState() {
    super.initState();
    initializeInfoVideos().then((value) => {showInfoVideos()});
  }

  showInfoVideos() async {
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
                          builder: (context) => VideoListViewPage(),
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
                    _playmediaSectionCard(currentDigitalFile),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    _getinfo(currentDigitalFile),
                    const SizedBox(
                      height: defaultPadding * 1.5,
                    ),
                    Container(
                      height: 800,
                      child: NearestVideoListViewPage(
                        nearestDigitalFiles,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        });
  }

  Widget _playmediaSectionCard(DigitalFile digitalFile) => Container(
        height: 200,
        width: 500,
        padding: const EdgeInsets.symmetric(
          //horizontal: defaultPadding,
          vertical: defaultPadding / 1,
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: ChewieListItem(
          videoPlayerController: VideoPlayerController.network(
            WebSite_Config.mainWebSiteURLWithDigitalFileFolder +
                digitalFile.storedPathTrailer,
          ),
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
                    child: Text(digitalFile.description),
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
            ],
          ),
        ),
      );
}
