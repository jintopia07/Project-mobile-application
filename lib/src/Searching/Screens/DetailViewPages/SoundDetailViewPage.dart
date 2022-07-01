// @dart=2.9
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nat/Config/WebSite_Config.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/NearestSoundListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/SoundListViewPage.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';
import 'package:nat/src/Searching/Services/NATSearcherProvider.dart';
import 'package:nat/widgets/chewie_list_item.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

class SoundDetailViewPage extends StatefulWidget {
  final DigitalFile digitalFile;
  const SoundDetailViewPage({Key key, this.digitalFile}) : super(key: key);

  @override
  SoundDetailViewPageState createState() => SoundDetailViewPageState();
}

class SoundDetailViewPageState extends State<SoundDetailViewPage> {
  AudioPlayer advancedPlayer = AudioPlayer();

  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;

  NATSearcher natSearcher;

  DigitalFile currentDigitalFile = DigitalFile();

  Widget _body = Center(child: const CircularProgressIndicator());

  ArchivesDataQuantity archivesDataQuantity;

  List<DigitalFile> nearestDigitalFiles = List<DigitalFile>.empty();

  Future<void> initializeInfoSounds() async {
    natSearcher = NATSearcherProvider().natSearcher;
    currentDigitalFile = widget.digitalFile;

    nearestDigitalFiles =
        await natSearcher.getNearestDigitalFiles(currentDigitalFile);
  }

  intitAudio(currentDigitalFile) {
    advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    initializeInfoSounds().then((value) => {showInfoSound()});

    intitAudio(currentDigitalFile);
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดการค้นหา'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: (() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SoundListViewPage(),
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
                height: defaultPadding * 0.5,
              ),
              _body
            ],
          ),
        ),
      ),
    );
  }

  showInfoSound() async {
    setState(() => {
          _body = Container(
            margin: const EdgeInsets.only(
                top: defaultPadding * 1.5,
                right: defaultPadding * 1,
                left: defaultPadding * 1,
                bottom: defaultPadding * 1.5),
            child: Column(
              children: <Widget>[
                _getinfo(currentDigitalFile),
                const SizedBox(
                  height: defaultPadding * 1.5,
                ),
                Container(
                  height: 800,
                  child: NearestSoundListViewPage(
                    nearestDigitalFiles,
                  ),
                )
              ],
            ),
          ),
        });
  }

  Widget _playmediaSectionCard(DigitalFile digitalFile) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  changeToSecond(value.toInt());
                  value = value;
                });
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split(".")[0]),
                Text(_duration.toString().split(".")[0]),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    if (isPlaying == false) {
                      advancedPlayer.play(
                        WebSite_Config.mainWebSiteURLWithDigitalFileFolder +
                            digitalFile.storedPathTrailer,
                      );

                      setState(() {
                        isPlaying = true;
                      });
                    } else if (isPlaying == true) {
                      advancedPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    }
                  },
                  icon: isPlaying == false
                      ? Icon(
                          Icons.play_circle_fill,
                          size: 50,
                          color: Colors.blue,
                        )
                      : Icon(
                          Icons.pause_circle_filled,
                          size: 50,
                          color: Colors.greenAccent,
                        )),
            ],
          ),
        ],
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
            ],
          ),
        ),
      );
}
