import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  Widget _spacing(BuildContext context) {
    final responsive = MediaQuery.of(context).size.height;
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new SizedBox(
            height: responsive * 0.01,
            width: 500.0,
          ),
        )
      ],
    );
  }

  String menOrWomen(gender) {
    String imageURL = "";
    if (gender == "male") {
      imageURL = "images/man.png";
    } else {
      imageURL = "images/women.png";
    }
    return imageURL;
  }

  @override
  Widget build(BuildContext context) {
    final double responsive = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Naveed Rehman'),
        centerTitle: false,
      ),
      body: new ListView(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.all(0.0),
                height: responsive * 0.2,
                decoration: new BoxDecoration(
                    image: DecorationImage(
                      image:
                      NetworkImage("https://iambharat.tk/images/hiretpp.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      repeat: ImageRepeat.noRepeat,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  padding: new EdgeInsets.only(top: responsive * 0.15),
                  child: new Card(
                    child: Container(
                      padding: new EdgeInsets.only(
                          top: responsive * 0.15, bottom: responsive * 0.05),
                      child: new Column(
                        children: <Widget>[
                          Center(
                            child: new Text(
                              'Naveed rehman',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40.0),
                            ),
                          ),
                          _spacing(context),
                          new Text(
                            'Naveed12@gmail.com',
                            style: new TextStyle(color: Colors.grey),
                          ),
                          _spacing(context),
                          new Text('03355051080'),
                          _spacing(context),
                          new Text(
                            '20 April 1996',
                          ),
                          _spacing(context),
                          _spacing(context),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                    "images/icons/facebook_logo.png",
                                    width: 30.0,
                                  ),
                                ),
                                onTap: () {},
                              ),
                              InkWell(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                    "images/icons/instagram_logo.png",
                                    width: 30.0,
                                  ),
                                ),
                                onTap: () {print("H");},
                              ),
                              InkWell(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                    "images/icons/website_logo.png",
                                    width: 30.0,
                                  ),
                                ),
                                onTap: () {},
                              ),
                              InkWell(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                    "images/icons/linkedin_logo.png",
                                    width: 30.0,
                                  ),
                                ),
                                onTap: () {},
                              ),
                              InkWell(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  child: Image.asset(
                                    "images/icons/twitter_logo.png",
                                    width: 30.0,
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    elevation: 5.0,
                  ),
                ),
              ),
              Card(
                elevation: 10.0,
                shape: CircleBorder(),
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: responsive * 0.02),
                  child: new Center(
                    child: new Hero(
                      tag: "image",
                      child: CircleAvatar(
                        radius: 100.0,
                        backgroundImage: new NetworkImage('sweets.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.only(
                    top: responsive * 0.2,
                    left: MediaQuery.of(context).size.width * 0.85),
                child: new Image.asset(
                  menOrWomen('man'),
                  height: 20,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
