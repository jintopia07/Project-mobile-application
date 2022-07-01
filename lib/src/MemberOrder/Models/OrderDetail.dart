// @dart=2.9
import 'package:nat/src/MasterData/Models/MasterData.dart';
import 'package:nat/src/MemberOrder/Models/Order.dart';
import 'package:nat/src/Searching/Models/ArchiveInfo.dart';

class OrderDetail {
  OrderDetail();

  int id = 0;
  Order order;
  int order_ID = 0;

  String contentOid = "";
  Content content;
  String contentCode = "";
  String subject = "";

  String digitalFileOid = "";
  DigitalFile digitalFile;
  String digitalFileID = "";
  String digitalFileName = "";
  String digitalFileType = "";
  String storedThumbnailPath = "";

  String orderName = "";
  int archiveDocumentType = 0;
  int orderingPriceSetting_ID = 0;
  OrderPriceSetting orderPriceSetting;
  double unitPrice = 0;
  int quantity = 0;
  double calculatedPrice = 0;

  int approvalStatus = 0;
  String approvedBy = "";
  DateTime approvedDate;
  DateTime unApprovedDate;
  String unApprovedReason = "";
  DateTime approvalDueDate;

  bool isFileDownloaded;
  DateTime fileDownloadedDate;

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    order = Order.fromJson(json["Order"]);
    order_ID = json["Order_ID"];

    contentOid = json["ContentOid"];
    content = Content.fromJson(json["Content"]);
    contentCode = json["contentCode"];
    subject = json["Subject"];

    digitalFileOid = json["DigitalFileOid"];
    digitalFile = DigitalFile.fromJson(json["DigitalFile"]);
    digitalFileID = json["DigitalFileID"];
    digitalFileName = json["DigitalFileName"];
    digitalFileType = json["DigitalFileType"];
    storedThumbnailPath = json["StoredThumbnailPath"];

    orderName = json["OrderName"];
    archiveDocumentType = json["ArchiveDocumentType"];
    orderingPriceSetting_ID = json["OrderingPriceSetting_ID"];
    // orderPriceSetting = OrderPriceSetting
    unitPrice = json["UnitPrice"];
    quantity = json["Quantity"];
    calculatedPrice = json["CalculatedPrice"];

    approvalStatus = json["ApprovalStatus"];
    approvedBy = json["ApprovedBy"];
    approvedDate = DateTime.parse(json["ApprovedDate"]);
    unApprovedDate = DateTime.parse(json["UnApprovedDate"]);
    unApprovedReason = json["UnApprovedReason"];
    approvalStatus = json["ApprovalStatus"];

    isFileDownloaded = json["IsFileDownloaded"];
    fileDownloadedDate = DateTime.parse(json["FileDownloadedDate"]);
  }
}
