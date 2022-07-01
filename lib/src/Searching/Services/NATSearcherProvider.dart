import 'package:nat/Config/WebAPI_Config.dart';
import 'NATSearcher.dart';

class NATSearcherProvider {
  static final NATSearcherProvider _natSearcherService =
      NATSearcherProvider._internal();
  NATSearcher? natSearcher;

  factory NATSearcherProvider() => _natSearcherService;

  NATSearcherProvider._internal() {
    natSearcher = NATSearcher(WebAPI_Config.mainWebAPIURL);
  }

  
}
