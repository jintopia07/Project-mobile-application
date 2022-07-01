// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebSite_Config.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/src/Searching/Screens/DetailViewPages/MapDetailViewPage.dart';

class NearestMapListViewPage extends StatefulWidget {
  List<DigitalFile> nearestDigitalFiles;
  NearestMapListViewPage(this.nearestDigitalFiles) {
    initialize();
  }

  void initialize() {
    //Load nearest paper from web api.
  }

  @override
  NearestMapListViewPageState createState() => NearestMapListViewPageState();
}

class NearestMapListViewPageState extends State<NearestMapListViewPage> {
  List<DigitalFile> nearestDigitalFiles;

  @override
  void initState() {
    super.initState();
    nearestDigitalFiles = widget.nearestDigitalFiles;
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
                          itemCount: nearestDigitalFiles.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(WebSite_Config
                                          .mainWebSiteURLWithSAndDigitalFileFolder +
                                      nearestDigitalFiles[index]
                                          .storedPathThumnail),
                                ),
                                title: Text(
                                  nearestDigitalFiles[index]
                                      .nameArachiveDigitalFile,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  "แสดงรายละเอียด",
                                  style: TextStyle(
                                      color: Colors.blue[900], fontSize: 13),
                                ),
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MapDetailViewPage(
                                                  digitalFile:
                                                      nearestDigitalFiles[
                                                          index])),
                                      (Route<dynamic> route) => false);
                                },
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
