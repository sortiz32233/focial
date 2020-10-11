import 'package:focial/api/urls.dart';

extension StringExtension on String {
  String getAssetURL() {
    if (contains("http") || contains("://") || contains("www") || contains(".co") || contains(".co")) {
      return this;
    }
    return Urls.assetsBase + this;
  }
}
