import 'package:flutter/material.dart';

import '../../utils/app_images.dart';
import 'main_button.dart';

class NoNetworkView extends StatefulWidget {
  const NoNetworkView({super.key});

  @override
  State<NoNetworkView> createState() => _NoNetworkViewState();
}

class _NoNetworkViewState extends State<NoNetworkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            const Spacer(),
            Image.asset(
              AppAssets.network,
              height: 200,
            ),
            const Text(
              'No internet Connection',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Your internet connection is currently not available '
              'please check & try again.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const Spacer(),
            MainButton(
              onPressed: () {},
              text: 'Try again',
            )
          ],
        ),
      ),
    );
  }
}
