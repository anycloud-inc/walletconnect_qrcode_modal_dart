import 'package:flutter/material.dart';
import 'package:walletconnect_qrcode_modal_dart/src/lib/app_clipbord_manager.dart';
import 'package:walletconnect_qrcode_modal_dart/src/lib/config/cnp_app_color.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  Widget _qrScannerButton(BuildContext context) {
    return SizedBox(
      width: 260,
      child: TextButton(
        child: const Text(
          'QRコードを読み込む',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
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
              MaterialStateProperty.resolveWith((states) => CnpAppColor.black),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '接続の手順',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: CnpAppColor.black,
            ),
          ),
          const SizedBox(height: 24),
          const Text('1. PCで以下のリンクを開きMetaMaskと接続'),
          const SizedBox(height: 16),
          _urlText(context),
          const SizedBox(height: 24),
          const Text('2. 接続後、生成されるQRコードを読み込む'),
          const SizedBox(height: 16),
          _qrScannerButton(context)
        ],
      ),
    );
  }
}
