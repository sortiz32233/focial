import 'dart:convert';

const exp = "exp";

class JWT {
  static Map<String, dynamic> decode(String token) {
    if (token == null) return null;
    final parts = token.split('.');
    if (parts.length != 3) return null;

    final payload = parts[1];

    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    final Map<String, dynamic> payloadMap = json.decode(resp) as Map<String, dynamic>;
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }

    return payloadMap;
  }

  static bool isExpired(String token) {
    final Map<String, dynamic> decodedToken = decode(token);
    if (DateTime.fromMillisecondsSinceEpoch((decodedToken[exp] as int) * 1000).isAfter(DateTime.now())) {
      return true;
    }
    // payload expired, refresh the token and continue
    return false;
  }
}
