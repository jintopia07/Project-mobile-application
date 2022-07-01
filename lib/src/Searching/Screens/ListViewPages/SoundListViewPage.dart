// @dart=2.9
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nat/Config/WebSite_Config.dart';
import 'package:nat/src/Member/Screens/THMember/launcherUser.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Searching/Screens/DetailViewPages/SoundDetailViewPage.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';
import 'package:nat/src/Searching/Services/NATSearcherProvider.dart';
import 'package:nat/widgets/chewie_list_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:video_player/video_player.dart';

class SoundListViewPage extends StatefulWidget {
  const SoundListViewPage({Key key}) : super(key: key);

  @override
  SoundListViewPageState createState() => SoundListViewPageState();
}

class SoundListViewPageState extends State<SoundListViewPage> {
  NATSearcher natSearcher;
  Widget _body = Center(child: const CircularProgressIndicator());
  final ScrollController _scrollController = ScrollController();
  MemberInfo memberInfo;
  List<DigitalFile> digitalFiles = List<DigitalFile>.empty();

  int quantityOfSound;

  Future<void> loadMoreData() async {
    natSearcher = NATSearcherProvider().natSearcher;
    //Update the page number of searcher
    natSearcher.isearchStructure.pageNumber += 1;
    var loadDigitalFiles = await natSearcher.searchSounds();
    if (mounted) {
      setState(() {
        digitalFiles.addAll(loadDigitalFiles);
        showlistSounds();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSoundSearcher().then((value) => {showlistSounds()});
    //Add handle.
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreData();
      }
    });
  }

  Future<void> initializeSoundSearcher() async {
    natSearcher = NATSearcherProvider().natSearcher;

    // //Get archives data quantity.
    natSearcher.getArchivesDataQuantity();

    digitalFiles = await natSearcher.searchSounds();
    quantityOfSound = await natSearcher.countSound();
  }

  showlistSounds() async {
    setState(() => {
          _body = Scaffold(
            appBar: AppBar(
              title: const Text('รายละเอียดการค้นหา'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.white),
                  onPressed: (() {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LauncherUser(memberInfo),
                        ),
                        (Route<dynamic> route) => false);
                  }),
                ),
              ],
              backgroundColor: Colors.teal[600],
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    _WordSearch(),
                    SizedBox(height: 20),
                    Text(
                      "รายการค้นหาทั้งหมด ${quantityOfSound} รายการ",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: FutureBuilder(
                        future: null,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: digitalFiles.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300],
                                      blurRadius: 4,
                                      offset:
                                          const Offset(4, 8), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Card(
                                  margin: EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         SoundDetailViewPage(
                                      //             digitalFile:
                                      //                 digitalFiles[index]),
                                      //   ),
                                      // );

                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SoundDetailViewPage(
                                              digitalFile: digitalFiles[index],
                                            ),
                                          ),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: defaultPadding * 1,
                                        ),
                                        _playmediaSectionCard(
                                            digitalFiles[index]),
                                        _headerSectionCard(digitalFiles[index]),
                                        _namegroupsSectionCard(
                                            digitalFiles[index]),
                                        _nameinfoSectionCard(
                                            digitalFiles[index]),
                                        _infofromSectionCard(
                                            digitalFiles[index]),
                                        _instituteSectionCard(
                                            digitalFiles[index]),
                                        _documentSectionCard(
                                            digitalFiles[index]),
                                        const SizedBox(
                                          height: defaultPadding * 1.5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        });
  }

  Widget _WordSearch() => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: Text("คำค้นที่กรอก",
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text("คำค้น :"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      "",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _playmediaSectionCard(DigitalFile digitalFile) => Container(
        height: 200,
        width: 400,
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

  Widget _headerSectionCard(DigitalFile digitalFile) => Container(
        padding: const EdgeInsets.symmetric(
          //horizontal: defaultPadding,
          vertical: defaultPadding / 1,
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: ListTile(
          title: Text(
            "รหัสเอกสาร :",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(digitalFile.nameArachiveDigitalFile),
          ),
        ),
      );

  Widget _namegroupsSectionCard(DigitalFile digitalFile) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: ListTile(
          title: Text(
            "ชื่อชุดเอกสาร :",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
                digitalFile.content.archiveDocumentAccount.ownerDocumentName),
          ),
        ),
      );

  Widget _nameinfoSectionCard(DigitalFile digitalFile) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding / 1,
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: ListTile(
          title: Text(
            "ชื่อเรื่อง :",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(digitalFile.content.archiveDocumentAccount.accountName),
          ),
        ),
      );

  Widget _infofromSectionCard(DigitalFile digitalFile) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: ListTile(
          title: Text(
            "ชื่อไฟล์ :",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(digitalFile.digitalFileName),
          ),
        ),
      );

  Widget _instituteSectionCard(DigitalFile digitalFile) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding / 1,
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: ListTile(
          title: Text(
            "หน่วยงาน :",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(digitalFile.branchName),
          ),
        ),
      );

  Widget _documentSectionCard(DigitalFile digitalFile) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: ListTile(
          title: Text(
            "ประเภทเอกสาร :",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(digitalFile.originSourceTypeName),
          ),
        ),
      );
}
