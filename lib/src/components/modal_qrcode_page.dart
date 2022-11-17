import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
          const Text(
            'WalletConnect対応のウォレットで',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CnpAppColor.black,
            ),
          ),
          const Text(
            'QRコードをスキャン',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CnpAppColor.black,
            ),
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
              child: Text(
                _copiedToClipboard ? 'コピーしました' : 'クリップボードにコピー',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
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
