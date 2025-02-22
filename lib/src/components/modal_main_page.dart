import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_qrcode_modal_dart/src/components/text_ui.dart';

import '../utils/utils.dart';
import 'modal_qrcode_page.dart';
import 'modal_wallet_ios_page.dart';
import 'modal_wallet_android_page.dart';
import 'modal_wallet_web_page.dart';
import '../models/wallet.dart';
import 'modal_wallet_desktop_page.dart';

class ModalMainPage extends StatefulWidget {
  const ModalMainPage({
    required this.uri,
    required this.onQrScanButtonPressed,
    this.walletCallback,
    Key? key,
  }) : super(key: key);

  final String uri;
  final Function() onQrScanButtonPressed;
  final WalletCallback? walletCallback;

  @override
  State<ModalMainPage> createState() => _ModalMainPageState();
}

typedef WalletCallback = Function(Wallet);

class _ModalMainPageState extends State<ModalMainPage> {
  int? _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: max(500, MediaQuery.of(context).size.height * 0.5),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                CupertinoSlidingSegmentedControl<int>(
                  groupValue: _groupValue,
                  onValueChanged: (value) => setState(() {
                    _groupValue = value;
                  }),
                  padding: const EdgeInsets.all(4),
                  children: {
                    0: Utils.isDesktop
                        ? const QrSegment()
                        : const ListSegment(),
                    1: const QrScannerSegment(),
                    2: Utils.isDesktop
                        ? const ListSegment()
                        : const QrSegment(),
                  },
                ),
                Expanded(
                  child: _ModalContent(
                    groupValue: _groupValue!,
                    walletCallback: widget.walletCallback,
                    uri: widget.uri,
                    onQrScanButtonPressed: widget.onQrScanButtonPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListSegment extends StatelessWidget {
  const ListSegment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Segment(
      text: Utils.isDesktop ? 'Desktop' : 'Mobile',
    );
  }
}

class QrScannerSegment extends StatelessWidget {
  const QrScannerSegment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Segment(
      text: 'PC(Web)',
    );
  }
}

class QrSegment extends StatelessWidget {
  const QrSegment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Segment(
      text: 'QRコード',
    );
  }
}

class _ModalContent extends StatelessWidget {
  const _ModalContent({
    required this.groupValue,
    required this.uri,
    required this.onQrScanButtonPressed,
    this.walletCallback,
    Key? key,
  }) : super(key: key);

  final int groupValue;
  final String uri;
  final WalletCallback? walletCallback;
  final Function() onQrScanButtonPressed;

  @override
  Widget build(BuildContext context) {
    if (groupValue == (Utils.isDesktop ? 2 : 0)) {
      if (Utils.isIOS) {
        return ModalWalletIOSPage(uri: uri, walletCallback: walletCallback);
      } else if (Utils.isAndroid) {
        return ModalWalletAndroidPage(uri: uri, walletCallback: walletCallback);
      } else {
        return ModalWalletDesktopPage(uri: uri, walletCallback: walletCallback);
      }
    } else if (groupValue == 1) {
      return ModalWalletWebPage(onPressed: onQrScanButtonPressed);
    }
    return ModalQrCodePage(uri: uri);
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.text,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          width: 100,
          child: TextUI(
            textString: text,
            fontSize: 15.0,
          )),
    );
  }
}
