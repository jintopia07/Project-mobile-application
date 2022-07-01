// @dart=2.9
class ArchivesDataQuantity {
  ArchivesDataQuantity();

  int quantityOfPaper = 0;
  int quantityOfImage = 0;
  int quantityOfMap = 0;
  int quantityOfSound = 0;
  int quantityOfVDO = 0;

  ArchivesDataQuantity.fromJson(Map<String, dynamic> json) {
    quantityOfPaper = json["QuantityOfPaper"];
    quantityOfImage = json["QuantityOfImage"];
    quantityOfMap = json["QuantityOfMAP"];
    quantityOfSound = json["QuantityOfSound"];
    quantityOfVDO = json["QuantityOfVDO"];
  }
}

class ArchiveDocumentAccount {
  ArchiveDocumentAccount();

  String oid = "";
  String accountType = "";
  String ownerDocumentCode = "";
  String ownerDocumentName = "";
  String fullAccountCode = "";
  String accountCode = "";
  String accountName = "";
  String description = "";
  String microflimNO = "";
  String rootOidText = "";
  ArchiveDocumentAccount rootArchiveDocumentAccount;
  String branchName = "";
  String parentAccountOid = "";
  String indexSortNode = "";
  String publishStatus = "";

  ArchiveDocumentAccount.fromJson(Map<String, dynamic> json) {
    oid = json['Oid'];
    accountType = json['AccountType'];
    ownerDocumentCode = json['OwnerDocumentCode'];
    ownerDocumentName = json['OwnerDocumentName'];
    fullAccountCode = json['FullAccountCode'];
    accountCode = json['AccountCode'];
    accountName = json['AccountName'];
    description = json['Description'];
    microflimNO = json['MicrofilmNO'];
    rootOidText = json['RootOidText'];
    branchName = json['BranchName'];
    parentAccountOid = json['ParentAccountOid'];
    indexSortNode = json['indexSortNode'];
    publishStatus = json['PublishStatus'];
  }
}

class Content {
  Content();

  String oid = "";
  String archiveDocumentAccountOid = "";
  ArchiveDocumentAccount archiveDocumentAccount;
  int subjectNO = 0;
  String fullContentCode = "";
  String fullContentCodeToDisplay = "";
  String yearType = "";
  int startDate = 0;
  int startMonth = 0;
  String startYear = "";
  int endDate = 0;
  int endMonth = 0;
  String endYear = "";
  String subject = "";
  String subjectToDisplay = "";
  int quantity = 0;
  String unitName = "";
  String tearmsOfService = "";
  String box = "";
  String pack = "";
  String abstractMessage = "";
  String organizerAbstract = "";
  String remarkSubject = "";
  String remark = "";
  String rootOidString = "";
  String microFilmNO = "";
  String branchName = "";
  String publishStatus = "";

  Content.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      oid = json['Oid'];
      archiveDocumentAccountOid = json['ArchiveDocumentAccountOid'];
      archiveDocumentAccount =
          ArchiveDocumentAccount.fromJson(json['ArchiveDocumentAccount']);
      subjectNO = json['SubjectNo'];
      fullContentCode = json['FullContentCode'];
      fullContentCodeToDisplay = json['FullContentCodeToDisplay'];
      yearType = json['YearType'];
      startDate = json['StartDate'];
      startMonth = json['StartMonth'];
      startYear = json['StartYear'];
      endDate = json['EndDate'];
      endMonth = json['EndMonth'];
      endYear = json['EndYear'];
      subject = json['Subject'];
      subjectToDisplay = json['SubjectToDisplay'];
      quantity = json['Quantity'];
      unitName = json['UnitName'];
      tearmsOfService = json['TearmsOfService'];
      box = json['Box'];
      pack = json['Pack'];
      abstractMessage = json['Abstract'];
      organizerAbstract = json['OrganizerAbstract'];
      remarkSubject = json['RemarkSubject'];
      remark = json['Remark'];
      rootOidString = json['RootOidString'];
      microFilmNO = json['MicroFilmNO'];
      branchName = json['BranchName'];
      publishStatus = json['PublishStatus'];
    }
  }
}

class DigitalFile {
  DigitalFile();
  String oid = "";
  String contentOid = "";
  Content content;
  String resourceDigitalFile = "";
  String digitalFileID = "";
  String accountArchiveType = "";
  String filmNO = "";
  String cdNO = "";
  int quantity = 0;
  String nameArachiveDigitalFile = "";
  String size = "";
  String description = "";
  String branchName = "";
  String storedPath = "";
  String storedPathThumnail = "";
  String storedPathTrailer = "";
  String digitalFileName = "";
  String digitalFileType = "";
  String originSourceTypeName = "";
  String longKeywords = "";
  String publishStatus = "";

  DigitalFile.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      oid = json['Oid'];
      contentOid = json['ContentOid'];
      content = Content.fromJson(json['Content']);
      resourceDigitalFile = json['ResourceDigitalFile'];
      digitalFileID = json['DigitalFileID'];
      accountArchiveType = json['AccountArchiveType'];
      filmNO = json['FilmNo'];
      cdNO = json['CDNo'];
      quantity = json['Quantity'];
      nameArachiveDigitalFile = json['NameArchiveDigitalFile'];
      size = json['Size'];
      description = json['Description'];
      branchName = json['BranchName'];
      storedPath = json['StoredPath'];
      storedPathThumnail = json['StoredPathThumbnail'];
      storedPathTrailer = json['StorePathTrailer'];
      digitalFileName = json['DigitalFileName'];
      digitalFileType = json['DigitalFileType'];
      originSourceTypeName = json['OriginSourceTypeName'];
      longKeywords = json['LongKeyWords'];
      publishStatus = json['PublishStatus'];
    }
  }
}
