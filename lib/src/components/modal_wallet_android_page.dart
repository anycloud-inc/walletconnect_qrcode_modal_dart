import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_qrcode_modal_dart/src/components/modal_main_page.dart';
import 'package:walletconnect_qrcode_modal_dart/src/models/wallet.dart';
import 'package:walletconnect_qrcode_modal_dart/src/store/wallet_store.dart';
import 'package:walletconnect_qrcode_modal_dart/src/utils/utils.dart';

class ModalWalletAndroidPage extends StatelessWidget {
  const ModalWalletAndroidPage({
    required this.uri,
    this.store = const WalletStore(),
    this.walletCallback,
    Key? key,
  }) : super(key: key);

  final String uri;
  final WalletStore store;
  final WalletCallback? walletCallback;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: androidWallets(),
      builder: (context, AsyncSnapshot<List<Wallet>> walletData) {
        if (walletData.hasData) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  'Choose your preferred wallet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: walletData.data!.length,
                  itemBuilder: (context, index) {
                    final wallet = walletData.data![index];
                    if (!shouldEnable(wallet)) return Container();
                    return _buildItem(wallet);
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          );
        }
      },
    );
  }

  Future<List<Wallet>> androidWallets() {
    Future<bool> shouldShow(wallet) async =>
        await Utils.openableLink(wallet.mobile.universal) ||
        await Utils.openableLink(wallet.mobile.native) ||
        await Utils.openableLink(wallet.app.android);

    return store.load().then(
      (wallets) async {
        final filter = <Wallet>[];
        for (final wallet in wallets) {
          if (await shouldShow(wallet)) {
            if (shouldEnable(wallet)) {
              filter.insert(0, wallet);
            } else {
              filter.add(wallet);
            }
          }
        }
        return filter;
      },
    );
  }

  bool shouldEnable(Wallet wallet) => wallet.name == 'MetaMask';

  Widget _buildItem(Wallet wallet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () async {
          if (shouldEnable(wallet)) {
            walletCallback?.call(wallet);
            Utils.androidLaunch(wallet: wallet, uri: uri);
          }
        },
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  wallet.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://registry.walletconnect.org/logo/sm/${wallet.id}.jpeg',
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
