import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KFUPMAuth extends StatelessWidget {
  const KFUPMAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KFUPM Authentication'),
      ),
      body: SafeArea(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://portal.kfupm.edu.sa/',
          onPageFinished: (String? currentUrl) {
            if (currentUrl!.contains('login.kfupm.edu.sa')) {
              // INFO: 
              // This if statement is only to clearly depict the logic behind kfupm auth.
              // The order must be maintained for a clear code context.
            } else if (currentUrl.contains('portal.kfupm.edu.sa')) {
              Navigator.pop(context, true);
            } else {
              Navigator.pop(context, false);
            }
          },
        ),
      ),
    );
  }
}
