import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaru/yaru.dart';

import 'i18n.dart';

class rickRoll extends StatelessWidget {
  const rickRoll({
    Key key,
  }) : super(key: key);

  String get title => Intl.message('You\'ve theoretically been rickrolled...');

  String get description => Intl.message(
      'This build of the Subiquity installer has been rigged and designed to rickroll you. If it worked, an embed should show up below with the video. Enjoy!');

  String instructions(url) => Intl.message(
        '<a href="$url">Click to escape</a>',
        name: 'instructions',
        args: [url],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Column(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(description),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Html(
                  data: instructions(' </a><audio controls autoplay><source type="audio/mpeg" src="assets/rick.mp3"><source type="audio/wav" src="assets/rick.wav"></audio>'),
                  style: {
                    'body': Style(
                      margin: EdgeInsets.all(0),
                    ),
                  },
                  onLinkTap: (url) => launch(url),
                ),
              ),
              SizedBox(height: 32),
              Image.asset('assets/rick.gif'),
            ])),
            SizedBox(height: 20),
            ButtonBar(
              children: <OutlinedButton>[
                OutlinedButton(
                    child:
                        Text(UbuntuLocalizations.of(context).goBackButtonText),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                OutlinedButton(
                  style: yaruOutlinedButtonThemeData.style.copyWith(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xFF0e8420)),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => yaruWhite)),
                  child:
                      Text("Exit"),
                  onPressed: () {
                    launch("https://www.youtube.com/watch?v=fZi4JxbTwPo");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
