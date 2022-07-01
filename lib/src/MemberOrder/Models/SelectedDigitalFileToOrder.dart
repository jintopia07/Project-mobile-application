// @dart=2.9
class SelectedDigitalFileToOrder {
  String cardID;
  String digitalFileOid;

  Map<String, dynamic> createJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json["CardID"] = cardID;
    json["DigitalFileOid"] = digitalFileOid;
    return json;
  }
}
