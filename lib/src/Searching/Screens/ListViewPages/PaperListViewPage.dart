// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Member/Screens/THMember/launcherUser.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/src/Searching/Screens/DetailViewPages/PaperDetailViewPage.dart';
import 'package:nat/src/Searching/Screens/DetailViewPages/SoundDetailViewPage.dart';
import 'package:nat/src/Searching/Screens/DetailViewPages/VideoDetailViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/MapListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/SoundListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/VideoListViewPage.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';
import 'package:nat/src/Searching/Services/NATSearcherProvider.dart';

import 'ImageListViewPage.dart';

class PaperListViewPage extends StatefulWidget {
  const PaperListViewPage({Key key}) : super(key: key);

  @override
  PaperListViewPageState createState() => PaperListViewPageState();
}

class PaperListViewPageState extends State<PaperListViewPage> {
  NATSearcher natSearcher;
  Widget _body = Center(child: const CircularProgressIndicator());
  final ScrollController _scrollController = ScrollController();
  MemberInfo memberInfo;
  int quantityOfPaper;

  List<Content> contents = List<Content>.empty();

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  Future<void> loadMoreData() async {
    natSearcher = NATSearcherProvider().natSearcher;
    //Update the page number of searcher
    natSearcher.isearchStructure.pageNumber += 1;
    var loadContents = await natSearcher.searchPapers();
    if (mounted) {
      setState(() {
        contents.addAll(loadContents);
        displayPaper();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSearcher().then((value) => {displayPaper()});

    //Add handle.
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreData();
      }
    });
  }

  Future<void> initializeSearcher() async {
    natSearcher = NATSearcherProvider().natSearcher;

    //Get archives data quantity.
    natSearcher.getArchivesDataQuantity();

    contents = await natSearcher.searchPapers();
    quantityOfPaper = await natSearcher.countPaper();
  }

  displayPaper() async {
    setState(() {
      _body = WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("รายละเอียดการค้นหา"),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "รายการค้นหาทั้งหมด ${quantityOfPaper} รายการ",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: FutureBuilder(
                      future: loadMoreData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          // return Container(
                          //   child: Center(
                          //     child: Text("loading..."),
                          //   ),
                          // );
                        }
                        print(snapshot.data);
                        return ListView.builder(
                            controller: _scrollController,
                            itemCount: contents.length,
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
                                  margin: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PaperDetailViewPage(
                                                  content: contents[index],
                                                )),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: defaultPadding * 1,
                                        ),
                                        _headerSectionCard(contents[index]),
                                        _namegroupsSectionCard(contents[index]),
                                        _nameinfoSectionCard(contents[index]),
                                        _infofromSectionCard(contents[index]),
                                        _instituteSectionCard(contents[index]),
                                        _documentSectionCard(contents[index]),
                                        const SizedBox(
                                          height: defaultPadding * 1.5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _headerSectionCard(Content content) => Container(
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
            child: Text(content.fullContentCode),
          ),
        ),
      );

  Widget _namegroupsSectionCard(Content content) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: ListTile(
          title: const Text(
            "ชื่อชุดเอกสาร :",
            style: TextStyle(fontSize: 14),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(content.archiveDocumentAccount.accountName),
          ),
        ),
      );

  Widget _nameinfoSectionCard(Content content) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding / 1,
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
            child: Text(content.subject),
          ),
        ),
      );

  Widget _infofromSectionCard(Content content) => Container(
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
            child: Text(
                content.archiveDocumentAccount.ownerDocumentName.toString()),
          ),
        ),
      );

  Widget _instituteSectionCard(Content content) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding / 1,
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
            child: Text(content.branchName),
          ),
        ),
      );

  Widget _documentSectionCard(Content content) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1,
        ),
        alignment: FractionalOffset.topCenter,
        child: ListTile(
          title: const Text(
            "ประเภทเอกสาร :",
            style: TextStyle(fontSize: 14),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(content.archiveDocumentAccount.accountType),
          ),
        ),
      );

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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: const Text(
                      "คำค้นที่กรอก",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.brown,
                          fontSize: 18),
                    ),
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
                      style: TextStyle(color: Colors.blue[900]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _CountwordSection() => Container(
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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: const Text(
                  "จำนวนเอกสารที่พบ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.brown),
                ),
              ),
              Container(
                child: Divider(
                  color: Colors.grey,
                  height: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                      ),
                      child: const Text("จดหมายเหตุประเภทลายลักษณ์อักษร :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: defaultPadding,
                      ),
                      child: InkWell(
                        child: Text(
                          quantityOfPaper.toString(),
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PaperDetailViewPage()),
                          );
                        },
                      ),
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
                        left: defaultPadding,
                      ),
                      child: const Text("โสตทัศนจดหมายเหตุ-ภาพ :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: InkWell(
                        child: Text(
                          natSearcher
                              .searchedArchivesDataQuantity.quantityOfImage
                              .toString(),
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ImageListViewPage()),
                          );
                        },
                      ),
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
                        left: defaultPadding,
                      ),
                      child: const Text("จดหมายเหตุประเภทแผนที่ แผนผัง :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: InkWell(
                        child: Text(
                          natSearcher.searchedArchivesDataQuantity.quantityOfMap
                              .toString(),
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MapListViewPage()),
                          );
                        },
                      ),
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
                        left: defaultPadding,
                      ),
                      child: const Text("โสตทัศนจดหมายเหตุ-แถบบันทึกภาพ :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: InkWell(
                        child: Text(
                          natSearcher.searchedArchivesDataQuantity.quantityOfVDO
                              .toString(),
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VideoListViewPage()),
                          );
                        },
                      ),
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
                        left: defaultPadding,
                      ),
                      child: const Text("โสตทัศนจดหมายเหตุ-แถบบันทึกเสียง :"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: InkWell(
                        child: Text(
                          natSearcher
                              .searchedArchivesDataQuantity.quantityOfSound
                              .toString(),
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SoundListViewPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
