// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/src/Searching/Screens/DetailViewPages/PaperDetailViewPage.dart';

class NearestPaperListViewPage extends StatefulWidget {
  List<Content> nearestContents;

  NearestPaperListViewPage(this.nearestContents) {
    initialize();
  }

  void initialize() {
    //Load nearest paper from web api.
  }

  @override
  NearestPaperListViewPageState createState() =>
      NearestPaperListViewPageState();
}

class NearestPaperListViewPageState extends State<NearestPaperListViewPage> {
  List<Content> nearestContents;

  @override
  void initState() {
    super.initState();
    nearestContents = widget.nearestContents;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: defaultPadding * 1.5,
              ),
              _header(),
              Container(
                child: Divider(
                  color: Colors.grey,
                  height: 40,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: null,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {}

                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: nearestContents.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: defaultPadding * 1.5,
                                          bottom: defaultPadding * 1.5),
                                      child: Text(
                                        nearestContents[index].fullContentCode,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: defaultPadding * 2,
                                        right: defaultPadding * 1.5,
                                        bottom: defaultPadding * 1.5),
                                    child: InkWell(
                                      child: Text(
                                        "แสดงรายละเอียด",
                                        style:
                                            TextStyle(color: Colors.blue[900]),
                                      ),
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaperDetailViewPage(
                                                        content:
                                                            nearestContents[
                                                                index])),
                                            (Route<dynamic> route) => false);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() => Container(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: const Text(
          "รายการเอกสารที่อยู่ในเรื่องเดียวกัน",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.brown),
        ),
      );
}
