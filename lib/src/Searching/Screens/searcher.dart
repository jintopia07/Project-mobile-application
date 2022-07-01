// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/constants.dart';
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/Searching/Models/AdvanceSearchStructure.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';
import 'package:nat/src/Searching/Services/NATSearcherService.dart';
import 'package:nat/src/MasterData/Services/dataprovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nat/src/Searching/Models/BasicSearchStructure.dart';
import 'package:nat/src/Searching/Screens/ArchivesDataQuantityPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/ImageListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/MapListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/PaperListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/SoundListViewPage.dart';
import 'package:nat/src/Searching/Screens/ListViewPages/VideoListViewPage.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';
import 'package:nat/src/Searching/Services/NATSearcherProvider.dart';
import 'package:nat/widgets/language_picker_widget.dart';

class Searcher extends StatefulWidget {
  Searcher();

  @override
  SearcherState createState() => SearcherState();
}

class SearcherState extends State<Searcher> {
  bool visibilityOne = false;
  bool visibilityTwo = false;

  ArchivesDataQuantity archivesDataQuantity;
  DataProvider dataProvider;
  AccountTypeShortName selectedAccountType;
  String keyword;
  SearchingOptions selectedsearchingOptionChice;
  List<NATBranch> natBranches;
  String branchIDs;

  //Properties
  List<Content> contents;
  List<DigitalFile> digitalFiles;
  //About Searcher.
  NATSearcher natSearcher;
  BasicSearchStructure basicSearchStructure = BasicSearchStructure();
  AdvanceSearchStructure advanceSearchStructure = AdvanceSearchStructure();

  bool isBranch01Selected = false;
  bool isBranch02Selected = false;
  bool isBranch03Selected = false;
  bool isBranch04Selected = false;
  bool isBranch05Selected = false;
  bool isBranch06Selected = false;
  bool isBranch07Selected = false;
  bool isBranch08Selected = false;
  bool isBranch09Selected = false;

  List<DropdownMenuItem> dropdownAccountTypeItems;

  TextEditingController keywordController;

  addItemsToDorpdownAccountTypeItems() {
    dropdownAccountTypeItems = <DropdownMenuItem>[];
    dropdownAccountTypeItems.add(DropdownMenuItem(
        value: AccountTypeShortName.Peper,
        child: Text(
            NATSearcherService.getAccountName(AccountTypeShortName.Peper))));
    dropdownAccountTypeItems.add(DropdownMenuItem(
        value: AccountTypeShortName.Image,
        child: Text(
            NATSearcherService.getAccountName(AccountTypeShortName.Image))));
    dropdownAccountTypeItems.add(DropdownMenuItem(
        value: AccountTypeShortName.MAP,
        child:
            Text(NATSearcherService.getAccountName(AccountTypeShortName.MAP))));
    dropdownAccountTypeItems.add(DropdownMenuItem(
        value: AccountTypeShortName.Sound,
        child: Text(
            NATSearcherService.getAccountName(AccountTypeShortName.Sound))));
    dropdownAccountTypeItems.add(DropdownMenuItem(
        value: AccountTypeShortName.VDO,
        child:
            Text(NATSearcherService.getAccountName(AccountTypeShortName.VDO))));
  }

  initializeData() async {
    natBranches = await dataProvider.getNATBranches();
  }

  initializeSearchingOption(NATSearcherService natSearcherService) {
    selectedAccountType = natSearcherService.selectedAccountType;
    keywordController.text = natSearcherService.searchingKeyword;
    selectedsearchingOptionChice = natSearcherService.searchingOption;

    if (natSearcherService.isBranchSelected(1)) {
      isBranch01Selected = true;
    }
    if (natSearcherService.isBranchSelected(2)) {
      isBranch02Selected = true;
    }
    if (natSearcherService.isBranchSelected(3)) {
      isBranch03Selected = true;
    }
    if (natSearcherService.isBranchSelected(4)) {
      isBranch04Selected = true;
    }
    if (natSearcherService.isBranchSelected(5)) {
      isBranch05Selected = true;
    }
    if (natSearcherService.isBranchSelected(6)) {
      isBranch06Selected = true;
    }
    if (natSearcherService.isBranchSelected(7)) {
      isBranch07Selected = true;
    }
    if (natSearcherService.isBranchSelected(8)) {
      isBranch08Selected = true;
    }
    if (natSearcherService.isBranchSelected(9)) {
      isBranch09Selected = true;
    }
  }

  keywordSearch() {
    //this.widget.searcherPageState.natSearcher.selectedAccountType =
    //selectedAccountType;
    basicSearchStructure.keyword = "คนไทย";
    basicSearchStructure.pageNumber = 1;
    basicSearchStructure.maxRowPerPage = 10;
  }

  @override
  void initState() {
    super.initState();

    keywordController = TextEditingController();

    dataProvider = DataProvider(WebAPI_Config.mainWebAPIURL);
    initializeData();
    addItemsToDorpdownAccountTypeItems();
    //initializeSearchingOption(widget.searcherPageState.natSearcher);

    initNATSearcher();
    displayArchivesDataQuantity();
  }

  final ScrollController _scrollController = ScrollController();

  Widget _body = Center(child: const CircularProgressIndicator());

  initNATSearcher() {
    //Initialize natsearcher provider.
    NATSearcherProvider natSearcherProvider = NATSearcherProvider();
    natSearcher = natSearcherProvider.natSearcher;

    contents = List<Content>.empty();
    digitalFiles = List<DigitalFile>.empty();
  }

  Future<void> getArchivesDataQuantityByEmmptyKeyword() async {
    //Create an object to be empty keyword structure.
    BasicSearchStructure basicSearchStructure = BasicSearchStructure();
    basicSearchStructure.keyword = "";
    //Set the structure to searcher.
    natSearcher.SetSearchStructure(basicSearchStructure);
    //Do Getting quantity.
    archivesDataQuantity = await natSearcher.getArchivesDataQuantity();
  }

  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).titlesearcher),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 20, left: 20, top: 40, bottom: 30),
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  basicSearch(),
                  SizedBox(
                    height: 10,
                  ),
                  advanceSearch(),
                  _body
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget basicSearch() => Column(
        children: [
          Container(
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    visibilityOne = !visibilityOne;
                  });
                },
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 20, bottom: 20, right: 20),
                      child: Text(
                        AppLocalizations.of(context).menusearcher1,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          visibilityOne
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(),
                            ),
                            isDense: true, // Added this
                            contentPadding: const EdgeInsets.all(12),
                            hintText:
                                AppLocalizations.of(context).menusearcher3,
                          ),
                          onChanged: (value) {
                            setState(() {
                              keyword = value;
                              basicSearchStructure.keyword = value;
                            });
                          },
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: RadioListTile(
                                  title: Text(
                                    AppLocalizations.of(context)
                                        .getsearchingoptionand,
                                  ),
                                  groupValue: selectedsearchingOptionChice,
                                  value: SearchingOptions.AND,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedsearchingOptionChice = value;
                                      basicSearchStructure
                                          .keywordConditionType = value;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  title: Text(
                                    AppLocalizations.of(context)
                                        .getsearchingoptionor,
                                  ),
                                  groupValue: selectedsearchingOptionChice,
                                  value: SearchingOptions.OR,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedsearchingOptionChice = value;
                                      basicSearchStructure
                                          .keywordConditionType = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).menusearcherdetail1 +
                              AppLocalizations.of(context).menusearcherdetail2,
                          style: TextStyle(color: Colors.teal[600]),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: defaultPadding * 1),
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.all(defaultPadding),
                            padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding * 5,
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0))),
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
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    //Set search structure.
                                    natSearcher.SetSearchStructure(
                                        basicSearchStructure);
                                    return ArchivesDataQuantityPage();
                                  },
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          6, 0, 10, 0),
                                      child: const Icon(
                                        Icons.search,
                                        size: 30,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.teal[800],
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPadding / 2),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .menusearcherbutton,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
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
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
        ],
      );

  Widget advanceSearch() => Column(
        children: [
          Container(
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    visibilityTwo = !visibilityTwo;
                  });
                },
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 20, bottom: 20, right: 20),
                      child: Text(
                        AppLocalizations.of(context).menusearcherbuttondetail,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
          visibilityTwo
              ? Padding(
                  padding: const EdgeInsets.only(
                      bottom: defaultPadding * 1.5, top: defaultPadding * 1),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: defaultPadding),
                          child: Text(
                            AppLocalizations.of(context).menusearcherfillin1,
                          ),
                        ),
                        Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                advanceSearchStructure.fullContentCode_Keyword =
                                    value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: Text(
                            AppLocalizations.of(context).menusearcherfillin2,
                          ),
                        ),
                        Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                advanceSearchStructure.subject_Keyword = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: Text(
                              AppLocalizations.of(context).menusearcherfillin3),
                        ),
                        Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                advanceSearchStructure
                                    .ownerDocumentName_Keyword = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: Text(
                              AppLocalizations.of(context).menusearcherfillin4),
                        ),
                        Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                advanceSearchStructure.abstract_Keyword = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: Text(
                              AppLocalizations.of(context).menusearcherfillin5),
                        ),
                        Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(),
                              ),
                              isDense: true, // Added this
                              contentPadding: const EdgeInsets.all(12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                advanceSearchStructure.digitalFileName_Keyword =
                                    value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: Text(
                              AppLocalizations.of(context).menusearcherfillin6),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(
                              left: defaultPadding, right: defaultPadding),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              value: selectedAccountType,
                              hint: Text(AppLocalizations.of(context)
                                  .menusearcherfillin7),
                              items: dropdownAccountTypeItems,
                              onChanged: (value) {
                                setState(() {
                                  advanceSearchStructure.yearType = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: Text(
                            AppLocalizations.of(context).menusearcherfillin8,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              value: selectedAccountType,
                              hint: Text(AppLocalizations.of(context)
                                  .menusearcherfillin9),
                              items: dropdownAccountTypeItems,
                              onChanged: (value) {
                                setState(() {
                                  advanceSearchStructure.startYear = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: Text(AppLocalizations.of(context)
                              .menusearcherfillin10),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(
                              left: defaultPadding, right: defaultPadding),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              value: selectedAccountType,
                              hint: Text(AppLocalizations.of(context)
                                  .menusearcherfillin11),
                              items: dropdownAccountTypeItems,
                              onChanged: (value) {
                                setState(() {
                                  advanceSearchStructure.endYear = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding, top: defaultPadding),
                          child: Text(AppLocalizations.of(context)
                              .menusearcherfillin12),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              value: selectedAccountType,
                              hint: Text(
                                AppLocalizations.of(context)
                                    .menusearcherfillin13,
                              ),
                              items: dropdownAccountTypeItems,
                              onChanged: (value) {
                                setState(() {
                                  advanceSearchStructure.branchName = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: defaultPadding * 1),
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.all(defaultPadding),
                            padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding * 5,
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0))),
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
                                // //Set search structure.
                                natSearcher.SetSearchStructure(
                                    advanceSearchStructure);

                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ArchivesDataQuantityPage();
                                  },
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          6, 0, 10, 0),
                                      child: const Icon(
                                        Icons.search,
                                        size: 30,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.teal[800],
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPadding / 2),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .menusearcherfillin14,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
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
                )
              : Container(),
          const SizedBox(
            height: defaultPadding,
          ),
        ],
      );

  displayArchivesDataQuantity() async {
    getArchivesDataQuantityByEmmptyKeyword().then((value) => {
          setState(() => {
                _body = Container(
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
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, right: 20),
                          child: Text(
                            AppLocalizations.of(context).menusearchercount1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.brown),
                          ),
                        ),
                        Container(
                          child: Divider(
                            color: Colors.grey,
                            height: defaultPadding * 2,
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
                                child: Text(
                                  AppLocalizations.of(context)
                                      .menusearchercount2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: defaultPadding * 0.5,
                                ),
                                child: InkWell(
                                  child: Text(
                                    archivesDataQuantity.quantityOfPaper
                                        .toString(),
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PaperListViewPage()));
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
                                child: Text(AppLocalizations.of(context)
                                    .menusearchercount3),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: InkWell(
                                  child: Text(
                                    archivesDataQuantity.quantityOfImage
                                        .toString(),
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImageListViewPage()),
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
                                child: Text(
                                  AppLocalizations.of(context)
                                      .menusearchercount4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: InkWell(
                                  child: Text(
                                    archivesDataQuantity.quantityOfMap
                                        .toString(),
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MapListViewPage()),
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
                                child: Text(
                                  AppLocalizations.of(context)
                                      .menusearchercount5,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: InkWell(
                                  child: Text(
                                    archivesDataQuantity.quantityOfVDO
                                        .toString(),
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VideoListViewPage()),
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
                                child: Text(
                                  AppLocalizations.of(context)
                                      .menusearchercount6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: InkWell(
                                  child: Text(
                                    archivesDataQuantity.quantityOfSound
                                        .toString(),
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SoundListViewPage()),
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
                ),
              })
        });
  }
}

class DataValue {
  final int _key;
  final String _value;
  DataValue(this._key, this._value);
}
