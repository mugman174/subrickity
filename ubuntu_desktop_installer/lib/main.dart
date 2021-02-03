import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:yaru/yaru.dart';

import 'i18n.dart';
import 'welcomepage.dart';
import 'tryorinstallpage.dart';
import 'turnoffrstpage.dart';
import 'keyboardlayoutpage.dart';
import 'rickroll.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final client = SubiquityClient();
  await client.fetchLanguageList('assets/languagelist');
  runApp(UbuntuDesktopInstallerApp(client: client));
}

class UbuntuDesktopInstallerApp extends StatelessWidget {
  final SubiquityClient client;

  const UbuntuDesktopInstallerApp({Key key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => UbuntuLocalizations.of(context).appTitle,
      theme: yaruLightTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        UbuntuLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: client.languagelist
          .map((t) => t.item1)
          .where((locale) => UbuntuLocalizations.supportedLocales
              .contains(locale.languageCode))
          .toList(),
      home: WelcomePage(client: client),
      routes: <String, WidgetBuilder>{
        '/tryorinstall': (BuildContext context) =>
            TryOrInstallPage(client: client),
        '/turnoffrst': (BuildContext context) => TurnOffRSTPage(),
        '/keyboardlayout': (BuildContext context) =>
            KeyboardLayoutPage(client: client),
        '/rickroll': (BuildContext context) => rickRoll(),
      },
    );
  }
}
