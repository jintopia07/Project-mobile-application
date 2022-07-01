//@dart=2.9

import 'package:nat/src/Searching/Models/AdvanceSearchStructure.dart';
import 'package:nat/src/Searching/Models/BasicSearchStructure.dart';
import 'package:nat/src/Searching/Models/ISearchStructure.dart';

void main() {
  ISearchStructure basicSearchStructure = BasicSearchStructure();
  ISearchStructure advanceSearchStructure = AdvanceSearchStructure();

  if (basicSearchStructure is BasicSearchStructure) {
    print("xxxxx");
  }

  if (advanceSearchStructure is AdvanceSearchStructure) {
    print("");
  }
}
