import 'package:flutter/material.dart';
import 'package:walletconnect_qrcode_modal_dart/src/lib/app_clipbord_manager.dart';

const _webAuthurl = 'https://app.cnpowners.jp';
const _appGray = Color(0xFFA2A5A9);

class ModalWalletWebPage extends StatefulWidget {
  final Function() onPressed;
  const ModalWalletWebPage({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<ModalWalletWebPage> createState() => _ModalWalletWebPageState();
}

class _ModalWalletWebPageState extends State<ModalWalletWebPage> {
  bool _copiedToClipboard = false;

  Widget _urlText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          const Text(
            _webAuthurl,
            style: TextStyle(fontSize: 14, color: _appGray),
          ),
          const SizedBox(width: 8),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: _appGray.withOpacity(0.1),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              _copiedToClipboard ? 'Copied' : 'Copy',
              style: const TextStyle(fontSize: 12, color: _appGray),
            ),
            onPressed: _copiedToClipboard
                ? null
                : () async {
                    await AppClipboardManager.copy(context, text: _webAuthurl);
                    setState(() => _copiedToClipboard = true);
                    await Future.delayed(
                      const Duration(seconds: 1),
                      () => setState(() => _copiedToClipboard = false),
                    );
                  },
          ),
        ],
      ),
    );
  }

  Widget _qrScannerButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        child: const Text('QRコードを読み込む'),
        onPressed: widget.onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
          foregroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.white),
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.black),
          overlayColor: MaterialStateProperty.resolveWith(
              (states) => Colors.white.withOpacity(0.1)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '接続の手順',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text('1.PCで以下のリンクを開きMetaMaskと接続'),
          const SizedBox(height: 16),
          _urlText(context),
          const SizedBox(height: 16),
          const Text('2.接続後、生成されるQRコードを読み込む'),
          const SizedBox(height: 16),
          _qrScannerButton(context)
        ],
      ),
    );
  }
}
