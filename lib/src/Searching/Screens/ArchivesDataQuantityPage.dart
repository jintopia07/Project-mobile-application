// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/ImageListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/MapListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/PaperListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/SoundListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/VideoListViewPage.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';
import 'package:nat/src/Searching/Services/NATSearcherProvider.dart';

class ArchivesDataQuantityPage extends StatefulWidget {
  const ArchivesDataQuantityPage({Key key}) : super(key: key);

  @override
  ArchivesDataQuantityPageState createState() =>
      ArchivesDataQuantityPageState();
}

class ArchivesDataQuantityPageState extends State<ArchivesDataQuantityPage> {
  Widget _body = Center(child: const CircularProgressIndicator());
  NATSearcher natSearcher;

  Future<void> initailizeSearcher() async {
    natSearcher = NATSearcherProvider().natSearcher;

    //Get archives data quantity.
    await natSearcher.getArchivesDataQuantity();
  }

  displaykeywords() async {
    initailizeSearcher().then((value) => {
          setState(() => {
                _body = Scaffold(
                  appBar: AppBar(
                    title: const Text("รายละเอียดการค้นหา"),
                    backgroundColor: Colors.teal[600],
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          _WordSearch(),
                          SizedBox(height: 30),
                          _CountwordSection(),
                        ],
                      ),
                    ),
                  ),
                )
              }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displaykeywords();
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
                          natSearcher
                              .searchedArchivesDataQuantity.quantityOfPaper
                              .toString(),
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaperListViewPage()),
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
                                builder: (context) => ImageListViewPage()),
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
                                builder: (context) => MapListViewPage()),
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
                                builder: (context) => VideoListViewPage()),
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
                          natSearcher.searchedArchivesDataQuantity.quantityOfVDO
                              .toString(),
                          style: TextStyle(color: Colors.blue[900]),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SoundListViewPage()),
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
