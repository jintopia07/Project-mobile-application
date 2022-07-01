// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/Config/WebSite_Config.dart';
import 'package:nat/src/Member/Screens/THMember/launcherUser.dart';
import 'package:nat/src/MemberProfile/Models/memberinfo.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Searching/Screens/DetailViewPages/ImageDetailViewPage.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';
import 'package:nat/src/Searching/Services/NATSearcherProvider.dart';
import 'package:path/path.dart' as Path;

class ImageListViewPage extends StatefulWidget {
  const ImageListViewPage({Key key}) : super(key: key);

  @override
  ImageListViewPageState createState() => ImageListViewPageState();
}

class ImageListViewPageState extends State<ImageListViewPage> {
  NATSearcher natSearcher;
  Widget _body = Center(child: const CircularProgressIndicator());
  final ScrollController _scrollController = ScrollController();
  MemberInfo memberInfo;
  List<DigitalFile> digitalFiles = List<DigitalFile>.empty();
  int quantityOfImage;

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  Future<void> loadMoreData() async {
    natSearcher = NATSearcherProvider().natSearcher;
    //Update the page number of searcher
    natSearcher.isearchStructure.pageNumber += 1;
    var loadDigitalFiles = await natSearcher.searchImages();
    if (mounted) {
      setState(() {
        digitalFiles.addAll(loadDigitalFiles);
        showlistImages();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSearcher().then((value) => {showlistImages()});
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

    digitalFiles = await natSearcher.searchImages();
    quantityOfImage = await natSearcher.countImage();
  }

  showlistImages() async {
    setState(
      () => {
        _body = WillPopScope(
          onWillPop: () async => true,
          child: Scaffold(
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
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    _WordSearch(),
                    SizedBox(height: 20),
                    Text(
                      "รายการค้นหาทั้งหมด ${quantityOfImage} รายการ",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: FutureBuilder(
                        future: null,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            //

                          }
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: digitalFiles.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4,
                                      offset: Offset(4, 8), // Shadow position
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
                                              ImageDetailViewPage(
                                                  digitalFile:
                                                      digitalFiles[index]),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: defaultPadding * 1,
                                        ),
                                        _displayimage(digitalFiles[index]),
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
                                            height: defaultPadding * 1.5),
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
          ),
        )
      },
    );
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

  Widget _displayimage(DigitalFile digitalFile) => Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  WebSite_Config.mainWebSiteURLWithSAndDigitalFileFolder +
                      digitalFile.storedPathThumnail),
              fit: BoxFit.cover),
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
          title: const Text(
            "รหัสเอกสาร :",
            style: TextStyle(fontSize: 14),
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
          title: const Text(
            "ชื่อชุดเอกสาร :",
            style: TextStyle(fontSize: 14),
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
          title: const Text(
            "ชื่อเรื่อง :",
            style: TextStyle(fontSize: 14),
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
          title: const Text(
            "ชื่อไฟล์ :",
            style: TextStyle(fontSize: 14),
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
          title: const Text(
            "หน่วยงาน :",
            style: TextStyle(fontSize: 14),
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
          title: const Text(
            "ประเภทเอกสาร :",
            style: TextStyle(fontSize: 14),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(digitalFile.originSourceTypeName),
          ),
        ),
      );
}
