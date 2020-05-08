import 'package:DC_Note/core/statics/adds.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    AppAds.showBanner(anchorOffset: 80);
    super.initState();
  }

  @override
  void dispose() {
    AppAds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "O aplikacji",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AboutTitleWithValueWidget(
                title: "Opis",
                value:
                    'Aplikacja to prosty organizer który ma za zadanie ułatwić kontrolę nad swoimi kosmetykami. Dostępna jest duża, szczegółowa lista kategorii, dzięki której nie będzie problemów z klasyfikacją produktu. Każdy produkt może zostać opatrzony stosowną notatką. Produkty oznaczone jako "aktualnie używane" są dostępne w osobnej karcie aplikacji.',
              ),
              SizedBox(height: 16),
              _AboutTitleWithInnerWidget(
                  title: "Zaplanowane prace",
                  value: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Pierwsza wersja aplikacji posiada tylko podstawowe funkcjonalności. \nZaplanowane są m.in."),
                      SizedBox(height: 8),
                      Text("\u2022 Notyfikacje o końcu daty ważności produktu"),
                      Text("\u2022 Skanowanie kodu kreskowego produktu"),
                      Text("\u2022 Budowanie listy zakupowej"),
                    ],
                  )),
              SizedBox(height: 16),
              _AboutTitleWithValueWidget(
                title: "Źródła ikon",
                value:
                    "Uzyte ikony zostały stworzone przez Freepik ze strony www.flaticon.com.",
              )
            ],
          ),
        ),
      )),
    );
  }
}

class _AboutTitleWithValueWidget extends StatelessWidget {
  final String title;
  final String value;

  const _AboutTitleWithValueWidget({Key key, this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 2),
        Text(value)
      ],
    );
  }
}

class _AboutTitleWithInnerWidget extends StatelessWidget {
  final String title;
  final Widget value;

  const _AboutTitleWithInnerWidget({Key key, this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 2),
        value
      ],
    );
  }
}
