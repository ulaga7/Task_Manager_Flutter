import 'package:parse_server_sdk/parse_server_sdk.dart';

class ParseService {
  static Future<void> initialize({
    required String appId,
    required String clientKey,
    required String serverUrl,
  }) async {
    await Parse().initialize(
      appId,        // positional
      serverUrl,    // positional
      clientKey: clientKey,
      autoSendSessionId: true,
      debug: true,
    );
  }
}
