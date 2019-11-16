import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lista_pacientes/widgets/my_divider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: aboutScreen(),
    );
  }

  Widget aboutScreen() {
    return Center(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            MyDivider(dividerTitle: "Desarrollado por"),
            SizedBox(height: 8),
            Text(
              "Ing. Jorge Sarabia",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 25),
            GestureDetector(
              onTap: _launchURL,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.link,
                    size: 30,
                    color: Colors.lightBlue,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "www.sarabiajor.ge (*)",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            MyDivider(dividerTitle: ""),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "(*) Sugerencias y reporte de errores son bienvenidos.",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Text(
                "Información de contacto en el link.",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    const url = 'http://www.sarabiajor.ge';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
