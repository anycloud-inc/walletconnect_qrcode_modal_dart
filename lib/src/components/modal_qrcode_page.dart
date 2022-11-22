import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:walletconnect_qrcode_modal_dart/src/components/text_ui.dart';
import 'package:walletconnect_qrcode_modal_dart/src/lib/config/cnp_app_color.dart';

class ModalQrCodePage extends StatefulWidget {
  const ModalQrCodePage({
    required this.uri,
    Key? key,
  }) : super(key: key);

  final String uri;

  @override
  State<ModalQrCodePage> createState() => _ModalQrCodePageState();
}

class _ModalQrCodePageState extends State<ModalQrCodePage> {
  bool _copiedToClipboard = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 16,
      ),
      child: Column(
        children: [
          const TextUI(
            textString: 'WalletConnect対応のウォレットで',
          ),
          const TextUI(
            textString: 'QRコードをスキャン',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: QrImage(data: widget.uri),
            ),
          ),
          SizedBox(
            width: 260,
            child: TextButton(
              child: TextUI(
                textString: _copiedToClipboard ? 'コピーしました' : 'クリップボードにコピー',
                fontSize: 14.0,
                fontColor: Colors.white,
              ),
              onPressed: _copiedToClipboard
                  ? null
                  : () async {
                      await Clipboard.setData(ClipboardData(text: widget.uri));
                      setState(() => _copiedToClipboard = true);
                      await Future.delayed(const Duration(seconds: 1),
                          () => setState(() => _copiedToClipboard = false));
                    },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
                foregroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.white),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => CnpAppColor.black),
                overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.white.withOpacity(0.1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
