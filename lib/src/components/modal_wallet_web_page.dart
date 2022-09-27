import 'package:flutter/material.dart';
import 'package:walletconnect_qrcode_modal_dart/src/lib/app_clipbord_manager.dart';

const _webAuthurl = 'https://app.cnpowners.jp';
const _appGray = Color(0xFFA2A5A9);

class ModalWalletWebPage extends StatelessWidget {
  final Function() onPressed;
  const ModalWalletWebPage({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  Widget _urlText(BuildContext context) {
    return GestureDetector(
      onTap: () => AppClipboardManager.copy(context, text: _webAuthurl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            _webAuthurl,
            style: TextStyle(color: _appGray),
          ),
          SizedBox(width: 8),
          Icon(
            Icons.content_copy,
            size: 16,
            color: _appGray,
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
        onPressed: onPressed,
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
