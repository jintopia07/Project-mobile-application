// @dart=2.9
import 'package:nat/Config/WebAPI_Config.dart';
import 'package:nat/src/Searching/Models/AdvanceSearchStructure.dart';
import 'package:nat/src/Searching/Models/BasicSearchStructure.dart';
import 'package:nat/src/Searching/Services/AdvanceSearch.dart';
import 'package:nat/src/Searching/Services/BasicSearch.dart';
import 'package:nat/src/Searching/Services/NATSearcher.dart';

String mainWebAPIUrl = WebAPI_Config.mainWebAPIURL;
BasicSearch basicSearch = BasicSearch(mainWebAPIUrl);
AdvanceSearch advanceSearch = AdvanceSearch(mainWebAPIUrl);

void main() async {
  await test_BasicSearchAndAdvanceSearch();
}

void test_BasicSearchAndAdvanceSearch() async {
  //Basic search
  BasicSearchStructure basicSearchStructure = BasicSearchStructure();
  basicSearchStructure.keyword = "";
  basicSearchStructure.keywordConditionType = 1; //1 , 2
      basicSearchStructure.pageNumber = 1;
  basicSearchStructure.maxRowPerPage = 10;
   var archivesDataQuantity =
     await basicSearch.getArchivesDataQuantity(basicSearchStructure);

  var quantityOfPaper = await basicSearch.countPaper(basicSearchStructure);
  var quantityOfMap = await basicSearch.countMap(basicSearchStructure);
  var quantityOfImage = await basicSearch.countImage(basicSearchStructure);
  var quantityOfSound = await basicSearch.countSound(basicSearchStructure);
  var quantityOfVideo = await basicSearch.countVideo(basicSearchStructure);

  List papers = await basicSearch.searchPaper(basicSearchStructure);
  List images = await basicSearch.searchImage(basicSearchStructure);
  var maps = await basicSearch.searchMap(basicSearchStructure);
  var sounds = await basicSearch.searchSound(basicSearchStructure);
  var videos = await basicSearch.searchVideo(basicSearchStructure);

  //Advance search
  AdvanceSearchStructure advanceSearchStructure = AdvanceSearchStructure();
  advanceSearchStructure.fullContentCode_Keyword = "xxxxxx";
  advanceSearchStructure.subject_Keyword = "xxxxx";

  advanceSearchStructure.pageNumber = 1;
  advanceSearchStructure.maxRowPerPage = 10;

  // archivesDataQuantity =
  //     await advanceSearch.getArchivesDataQuantity(advanceSearchStructure);

  quantityOfPaper = await advanceSearch.countPaper(advanceSearchStructure);
  quantityOfImage = await advanceSearch.countImage(advanceSearchStructure);
  quantityOfSound = await advanceSearch.countSound(advanceSearchStructure);
  quantityOfVideo = await advanceSearch.countVideo(advanceSearchStructure);

  papers = await advanceSearch.searchPaper(advanceSearchStructure);
  images = await advanceSearch.searchImage(advanceSearchStructure);
  maps = await advanceSearch.searchMap(advanceSearchStructure);
  sounds = await advanceSearch.searchSound(advanceSearchStructure);
  videos = await advanceSearch.searchVideo(advanceSearchStructure);
}

void test_NATSearcherWithBasicSearchAndAdvance() async {
//Basic search
  BasicSearchStructure basicSearchStructure = BasicSearchStructure();
  basicSearchStructure.keyword = "";
  basicSearchStructure.keywordConditionType = //1 , 2
      basicSearchStructure.pageNumber = 1;
  basicSearchStructure.maxRowPerPage = 10;

//Advance search
  AdvanceSearchStructure advanceSearchStructure = AdvanceSearchStructure();
  advanceSearchStructure.fullContentCode_Keyword = "xxxxxx";
  advanceSearchStructure.subject_Keyword = "xxxxx";

  advanceSearchStructure.pageNumber = 1;
  advanceSearchStructure.maxRowPerPage = 10;

  NATSearcher natSearcher = NATSearcher(WebAPI_Config.mainWebAPIURL);
  //Set search structure by basic search.
  //natSearcher.SetSearchStructure(basicSearchStructure);
  //Set search structure by advance search.
  natSearcher.SetSearchStructure(advanceSearchStructure);
  var archivesDataQuantity = await natSearcher.getArchivesDataQuantity();

  var countPaper = await natSearcher.countPaper();
  var countImage = await natSearcher.countImage();
  var countMap = await natSearcher.countMap();
  var countVideo = await natSearcher.countVideo();
  var countSound = await natSearcher.countSound();

  var papers = await natSearcher.searchPapers();
  var images = await natSearcher.searchImages();
  var maps = await natSearcher.searchMaps();
  var videos = await natSearcher.searchVideos();
  var sounds = await natSearcher.searchSounds();
}
