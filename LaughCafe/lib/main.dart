import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:share/share.dart';

void main() {
  runApp(MaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Colors.grey,
                      Colors.blueGrey[900],
                    ]
                )
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 220, 0, 0),
                child: Icon(Icons.local_cafe, color: Colors.white, size: 200,),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Text('Laugh Cafe',
                  style: TextStyle(color: Colors.white,
                      fontSize: 50, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 500, 0, 0),
                width: 170,
                height: 50,
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Text('Log In', style: TextStyle(color: Colors.blueGrey[900], fontSize: 20),),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 500, 0, 0),
                width: 170,
                height: 50,
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Text('Sign Up', style: TextStyle(color: Colors.blueGrey[900], fontSize: 20),),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Colors.grey,
                          Colors.blueGrey[900],
                        ]
                    )
                ),
              ),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Text('Sign Up',
                      style: TextStyle(color: Colors.white,
                        fontSize: 50, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 235, 0, 0),
                    child: Text('Email', style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 270, 0, 0),
                        width: 350,
                        child: TextField(
                          controller: myControllerEmail,
                          decoration: InputDecoration(
                            hintText: ' example@gmail.com',
                            prefixIcon: Icon(Icons.mail_outline,),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Text('Password', style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        width: 350,
                        child: TextField(
                          controller: myControllerPassword,
                          decoration: InputDecoration(
                            hintText: ' password',
                            prefixIcon: Icon(Icons.vpn_key,),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.fromLTRB(0, 125, 0, 0),
                    child: Builder(
                      builder: (context) => FlatButton(
                        onPressed: (){
                          print(myControllerEmail.text);
                          if(myControllerPassword.text == '' || myControllerEmail.text == ''){
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please enter the required information.')));
                          }
                          else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                          }
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        child: Text('Sign Up', style: TextStyle(color:Colors.blueGrey[900], fontSize: 20),),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],

      ),
    );
  }
}

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Colors.grey,
                          Colors.blueGrey[900],
                        ]
                    )
                ),
              ),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Text('Log In',
                      style: TextStyle(color: Colors.white,
                        fontSize: 50, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 235, 0, 0),
                    child: Text('Email', style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 270, 0, 0),
                        width: 350,
                        child: TextField(
                          controller: myControllerEmail,
                          decoration: InputDecoration(
                            hintText: ' example@gmail.com',
                            prefixIcon: Icon(Icons.mail_outline,),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Text('Password', style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        width: 350,
                        child: TextField(
                          controller: myControllerPassword,
                          decoration: InputDecoration(
                            hintText: ' password',
                            prefixIcon: Icon(Icons.vpn_key,),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 350,
                    height: 50,
                    margin: EdgeInsets.fromLTRB(0, 125, 0, 0),
                    child: Builder(builder: (context) => FlatButton(
                      onPressed: (){
                        if(myControllerPassword.text == '' || myControllerEmail.text == ''){
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please enter the required information.')));
                        }
                        else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                        }
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: Text('Log In', style: TextStyle(color: Colors.blueGrey[900], fontSize: 20),),
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> memeImages = [
  'https://i.pinimg.com/originals/f7/ae/e8/f7aee8753832af613b63e51d5f07011a.jpg',
  'https://i.pinimg.com/736x/ce/c0/74/cec074ab85ddb1b716c8ea9ed2a79d4f.jpg',
  'https://wallpaperaccess.com/full/636909.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              color: Colors.blueGrey[900],
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('Today\'s Specials', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30,),
                  ),
                ],
              ),
            ),
          ),
         Container(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height - 90,
           child: ListView(
             padding: EdgeInsets.all(0),
             scrollDirection: Axis.vertical,
             children: [
               Row(mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Container(
                     margin: EdgeInsets.all(10),
                     width: 45,
                     height: 45,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                       ),
                     ),
                   ),
                   Container(
                     margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                     child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                   ),
                   Container(
                     margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                     child: OutlineButton(
                       color: Colors.brown,
                       onPressed: (){},
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(30))
                       ),
                       child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                     ),
                   ),
                 ],
               ),
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: 465,
                 child: Image(
                   image: NetworkImage('${memeImages[0]}'),
                   fit: BoxFit.fill,
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width,
                 color: Colors.blueGrey[900],
                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     GestureDetector(
                       onTap: (){},
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: Icon(Icons.favorite, color: Colors.white, size: 45,
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                       },
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: Icon(Icons.comment, color: Colors.white, size: 45,
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         // Share.share(memeImages[0]);
                       },
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: Icon(Icons.share, color: Colors.white, size: 45,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Row(mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Container(
                     margin: EdgeInsets.all(10),
                     width: 45,
                     height: 45,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                       ),
                     ),
                   ),
                   Container(
                     margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                     child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                   ),
                   Container(
                     margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                     child: OutlineButton(
                       color: Colors.brown,
                       onPressed: (){},
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(30))
                       ),
                       child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                     ),
                   ),
                 ],
               ),
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: 465,
                 child: Image(
                   image: NetworkImage('${memeImages[1]}'),
                   fit: BoxFit.fill,
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width,
                 color: Colors.blueGrey[900],
                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     GestureDetector(
                       onTap: (){},
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: Icon(Icons.favorite, color: Colors.white, size: 45,
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                       },
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: Icon(Icons.comment, color: Colors.white, size: 45,
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         // Share.share(memeImages[1]);
                       },
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: Icon(Icons.share, color: Colors.white, size: 45,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Row(mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Container(
                     margin: EdgeInsets.all(10),
                     width: 45,
                     height: 45,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                       ),
                     ),
                   ),
                   Container(
                     margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                     child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                   ),
                   Container(
                     margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                     child: OutlineButton(
                       color: Colors.brown,
                       onPressed: (){},
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(30))
                       ),
                       child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                     ),
                   ),
                 ],
               ),
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: 465,
                 child: Image(
                   image: NetworkImage('${memeImages[2]}'),
                   fit: BoxFit.fill,
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width,
                 color: Colors.blueGrey[900],
                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     GestureDetector(
                       onTap: (){},
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: Icon(Icons.favorite, color: Colors.white, size: 45,
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                       },
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: Icon(Icons.comment, color: Colors.white, size: 45,
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         // Share.share('holla');
                       },
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: Icon(Icons.share, color: Colors.white, size: 45,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ],//memeImages.map((images) => buildCarousel(images)).toList(),
           ),
         ),
        ],
      ),
    );
  }
}

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        title: Text('Explore 🔭'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                        Colors.grey,
                        Colors.blueGrey[700],
                        ]
                    )
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width -10,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: GestureDetector(child: Icon(Icons.search),onTap: (){

                        },)
                      ),
                    ),
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(20),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FunnyPage()));
                            },
                            color: Colors.blueGrey[900],
                            child: Text('Funny', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                        ),
                      )
                    ],
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                            padding: EdgeInsets.all(20),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CringePage()));
                            },
                            color: Colors.blueGrey[900],
                            child: Text('Cringe', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                            padding: EdgeInsets.all(20),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SillyPage()));
                            },
                            color: Colors.blueGrey[900],
                            child: Text('Silly', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                        ),
                      ),
                    ],
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                            padding: EdgeInsets.all(20),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DarkPage()));
                            },
                            color: Colors.blueGrey[900],
                            child: Text('Dark', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                            padding: EdgeInsets.all(20),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SuperSillyPage()));
                            },
                            color: Colors.blueGrey[900],
                            child: Text('SUPER Silly', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                        ),
                      ),
                    ],
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                            padding: EdgeInsets.all(20),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ExperimentalPage()));
                            },
                            color: Colors.blueGrey[900],
                            child: Text('Experimental', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                        ),
                      )
                    ],
                  ),
                ],
              ),

            ],

          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Text('click'),
      //   backgroundColor: Colors.red[600],
      // ),
    );
  }
}
// funny page
class FunnyPage extends StatefulWidget {
  @override
  _FunnyPageState createState() => _FunnyPageState();
}

class _FunnyPageState extends State<FunnyPage> {
  List<String>memeImages = [
    'https://filmdaily.co/wp-content/uploads/2020/07/cleanmeme-lede-1300x1244.jpg',
    'https://cdn.dumpaday.com/wp-content/uploads/2020/04/when-you-have-a-lack-of-taste.jpg',
    'https://www.hellomagazine.com/imagenes/healthandbeauty/health-and-fitness/2020040187313/funniest-memes-about-self-isolation/0-419-388/meme-zoom-z.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text('Funny'),
        //     // centerTitle: true,
        //     backgroundColor: Colors.blueGrey[900],
        // ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              color: Colors.blueGrey[900],
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('Funny', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30,),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 90,
            child: ListView(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[0]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[0]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[1]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[1]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[2]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share('holla');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],//memeImages.map((images) => buildCarousel(images)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

//Cringe Explore tab
class CringePage extends StatefulWidget {
  @override
  _CringePageState createState() => _CringePageState();
}

class _CringePageState extends State<CringePage> {
  List<String>memeImages = [
    'https://images7.memedroid.com/images/UPLOADED758/5c535ca9ae87e.jpeg',
    'https://cdn.ebaumsworld.com/mediaFiles/picture/604025/85226984.png',
    'https://i.kym-cdn.com/photos/images/original/001/813/333/258.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Cringe'),
      //   backgroundColor: Colors.blueGrey[900],
      // ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              color: Colors.blueGrey[900],
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('Cringe', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30,),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 90,
            child: ListView(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[0]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[0]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[1]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[1]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[2]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share('holla');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],//memeImages.map((images) => buildCarousel(images)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

//Dark Explore tab
class DarkPage extends StatefulWidget {
  @override
  _DarkPageState createState() => _DarkPageState();
}

class _DarkPageState extends State<DarkPage> {
  List<String>memeImages = [
    'https://i.pinimg.com/474x/d6/cb/00/d6cb008bc1291154467fd223ec8df556.jpg',
    'https://i.redd.it/9s6977sdcxn51.jpg',
    'https://i.imgur.com/28gDhu0.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Dark'),
      //   backgroundColor: Colors.blueGrey[900],
      // ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              color: Colors.blueGrey[900],
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('Dark', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30,),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 90,
            child: ListView(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[0]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[0]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[1]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[1]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[2]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share('holla');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],//memeImages.map((images) => buildCarousel(images)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


//Silly Explore tab
class SillyPage extends StatefulWidget {
  @override
  _SillyPageState createState() => _SillyPageState();
}

class _SillyPageState extends State<SillyPage> {
  List<String>memeImages = [
    'https://i.redd.it/0zykle8dhzn51.png',
    'https://i.redd.it/s5zlsroxhxn51.png',
    'https://media.tenor.com/images/c21883c04f37e7b0af0e0b2a09d281bb/tenor.gif',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Silly'),
      //   backgroundColor: Colors.blueGrey[900],
      // ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              color: Colors.blueGrey[900],
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('Silly', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30,),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 90,
            child: ListView(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[0]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[0]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[1]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[1]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[2]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share('holla');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],//memeImages.map((images) => buildCarousel(images)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

//Super Silly Explore tab
class SuperSillyPage extends StatefulWidget {
  @override
  _SuperSillyPageState createState() => _SuperSillyPageState();
}

class _SuperSillyPageState extends State<SuperSillyPage> {
  List<String>memeImages = [
    'https://thumbs.gfycat.com/ThirdShabbyAlligator-size_restricted.gif',
    'https://media1.tenor.com/images/cf59aa24b8d9c4a0eec3a152bb55baab/tenor.gif?itemid=16513499',
    'https://i.imgur.com/oKK3GIa.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Super Silly'),
      //   backgroundColor: Colors.blueGrey[900],
      // ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              color: Colors.blueGrey[900],
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('Super Silly', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30,),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 90,
            child: ListView(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[0]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[0]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[1]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[1]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[2]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share('holla');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],//memeImages.map((images) => buildCarousel(images)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

//Experimental; Explore tab
class ExperimentalPage extends StatefulWidget {
  @override
  _ExperimentalPageState createState() => _ExperimentalPageState();
}

class _ExperimentalPageState extends State<ExperimentalPage> {
  List<String>memeImages = [
    'https://i.redd.it/cdukviugezn51.jpg',
    'https://i.pinimg.com/originals/8a/6a/9d/8a6a9d94f4770522eb88cadb845749d5.gif',
    'https://i.redd.it/nrllawmd60o51.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Super Silly'),
      //   backgroundColor: Colors.blueGrey[900],
      // ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              color: Colors.blueGrey[900],
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('Experimental', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30,),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 90,
            child: ListView(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[0]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[0]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[1]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share(memeImages[1]);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('UserName', style: TextStyle(color: Colors.blueGrey[900], fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: OutlineButton(
                        color: Colors.brown,
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text('Subscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 465,
                  child: Image(
                    image: NetworkImage('${memeImages[2]}'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey[900],
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.favorite, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.comment, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          // Share.share('holla');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          color: Colors.blueGrey[900],
                          child: Icon(Icons.share, color: Colors.white, size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],//memeImages.map((images) => buildCarousel(images)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


class NavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Cafe Menu '),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(icon: Icon(Icons.local_cafe, color: Colors.white, size: 25,), onPressed: (){},),
        actions: [
          IconButton(icon: Icon(Icons.local_cafe, color: Colors.white, size: 25,), onPressed: (){},)
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Colors.blueGrey[900],
                      Colors.grey,
                    ]
                )
            ),
          ),
          Column(
            children: [
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // width: Checkbox.width,
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: FloatingActionButton.extended(
                        heroTag: "button3",
                        // padding: EdgeInsets.all(20),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                        },
                        backgroundColor: Colors.blueGrey[900],
                        label: Text('Today\'s Special   ★', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                    ),
                  ),
                ],
              ),
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: FloatingActionButton.extended(
                        heroTag: 'button1',
                        // padding: EdgeInsets.all(20),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ExplorePage()));
                        },
                        backgroundColor: Colors.blueGrey[900],
                        label: Text('      Explore        🔭 ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                    ),
                  ),
                ],
              ),
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: FloatingActionButton.extended(
                        heroTag: 'button2',
                        // padding: EdgeInsets.all(20),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalProfilePage()));
                        },
                        backgroundColor: Colors.blueGrey[900],
                        label: Text( ' Subscriptions    🔔', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                    ),
                  ),
                ],
              ),

              Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                        padding: EdgeInsets.all(19),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
                        },
                        color: Colors.blueGrey[50],
                        child: Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.blueGrey[900],
                          size: 30.0,
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 90, 0, 0),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                        padding: EdgeInsets.all(15),
                        onPressed: (){},
                        color: Colors.blueGrey[50],
                        child: Icon(
                          Icons.assignment_ind,
                          color: Colors.blueGrey[900],
                          size: 35.0,
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 90, 0, 0),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                        padding: EdgeInsets.all(10),
                        onPressed: (){},
                        color: Colors.blueGrey[50],
                        child: Icon(
                          Icons.add,
                          color: Colors.blueGrey[900],
                          size: 45.0,
                        )
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(margin: EdgeInsets.fromLTRB(0, 15, 0, 0),  child: Text(' Chat', style: TextStyle(fontSize: 15, color: Colors.white),)),
                  Container(margin: EdgeInsets.fromLTRB(0, 15, 0, 0),child: Text('  Profile',style: TextStyle(fontSize: 15, color: Colors.white))),
                  Container(margin: EdgeInsets.fromLTRB(0, 15, 0, 0),child: Text('Create',style: TextStyle(fontSize: 15, color: Colors.white))),
                ],
              ),
            ],
          ),

        ],

      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Text('click'),
      //   backgroundColor: Colors.red[600],
      // ),
    );
  }
}

// class FunnyPage extends StatefulWidget {
//   @override
//   _FunnyPageState createState() => _FunnyPageState();
// }
//
// class _FunnyPageState extends State<FunnyPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title: Text('Funny'),
//             backgroundColor: Colors.brown
//         )
//     );
//   }
// }



class PersonalProfilePage extends StatefulWidget {
  @override
  _PersonalProfilePageState createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  int subNum1 = 0;
  int n = 0;
  final List<String> userNameList = [
    'UserProfileOne',
    'UserProfileTwo',
    'UserProfileThree',
    'UserProfileFour',
    'UserProfileFive',
    'UserProfileSix',
    'UserProfileSeven',
    'UserProfileEight',
    'UserProfileNine',
    'UserProfileTen',
    'UserProfileEleven',
    'UserProfileTwelve',
  ];
  Widget buildSubBars(names){
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: (){
                print('sub select $subNum1');
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),

                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://images.squarespace-cdn.com/content/5b47794f96d4553780daae3b/1531516790942-VFS0XZE207OEYBLVYR99/profile-placeholder.jpg?content-type=image%2Fjpeg'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(names, style: TextStyle(color: Colors.blueGrey[900], fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        width: 120,
                        child: OutlineButton(
                          color: Colors.brown,
                          onPressed: (){},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          child: Text('Unsubscribe', style: TextStyle(color: Colors.blueGrey[900],),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscriptions 🔔', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Colors.blueGrey[900],
                      Colors.grey,
                    ]
                )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: userNameList.map((names) => buildSubBars(names)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}



//Comment Page for Posts 
class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final myController = TextEditingController();
  List<String> userComments = ['Lol nice meme. Keep them coming.'];

  @override
  Widget commentCard(comment){
    return Row(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'), fit: BoxFit.fill),
          ),
        ),
        Container(
          width: 330,
          child: Card(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Padding(padding: EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(comment),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Comment Section', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: Icon(Icons.chat),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Colors.grey,
                      Colors.blueGrey[900],
                    ]
                )
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(onTap: (){
                    setState(() {
                      userComments.add(myController.text);
                      print(myController.text);
                    });
                  }, child: Container(margin: EdgeInsets.only(left: 10), child: Icon(Icons.add_circle_outline, size: 30, color: Colors.white,))),
                  Container(
                    width: 350,
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: '  Comment here...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                        ),
                      ),
                  ),
                ],
              ),
              Container(
                height: 525,
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        children: userComments.map((comment) => commentCard(comment)).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//chat page
class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String>memeImages = [
    'https://filmdaily.co/wp-content/uploads/2020/07/cleanmeme-lede-1300x1244.jpg',
    'https://cdn.dumpaday.com/wp-content/uploads/2020/04/when-you-have-a-lack-of-taste.jpg',
    'https://www.hellomagazine.com/imagenes/healthandbeauty/health-and-fitness/2020040187313/funniest-memes-about-self-isolation/0-419-388/meme-zoom-z.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        // centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
    );
  }
}



