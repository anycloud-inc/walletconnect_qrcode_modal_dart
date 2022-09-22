import 'package:flutter/material.dart';

class ModalWalletWebPage extends StatelessWidget {
  final Function() onPressed;
  const ModalWalletWebPage({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

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
          const Center(
            child: Text(
              'https://cnp-friends.com/auth',
              style: TextStyle(
                color: Color(0xFFA2A5A9),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('2.接続後、生成されるQRコードを読み込む'),
          const SizedBox(height: 16),
          _qrScannerButton(context)
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
}
