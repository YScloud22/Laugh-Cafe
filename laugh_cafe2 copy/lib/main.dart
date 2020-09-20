import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// -----------------------------------
///          Auth0 External Packages
/// -----------------------------------

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------

const AUTH0_DOMAIN = 'dev-kl4e7wj9.us.auth0.com';
const AUTH0_CLIENT_ID = 'K7UDQTpnpTIbN4uiMzPBeA2Z5n8hfCqu';

const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

/// -----------------------------------
///           Profile Widget
/// -----------------------------------

class Profile extends StatelessWidget {
  final logoutAction;
  final String name;
  final String picture;

  Profile(this.logoutAction, this.name, this.picture);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(picture ?? ''),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Text('Name: $name'),
        SizedBox(height: 48.0),
        RaisedButton(
          onPressed: () {
            logoutAction();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}

/// -----------------------------------
///            Login Widget
/// -----------------------------------
/// Login Created below with MyApp
class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

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
              children: <Widget>[
/*                Expanded(
                child:*/ Container(
                  margin: EdgeInsets.fromLTRB(0, 500, 0, 0),
                  width: 170,
                  height: 50,
                  child: FlatButton(
                    onPressed: (){
                      loginAction();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Text('Log In', style: TextStyle(color: Colors.blueGrey[900], fontSize: 20),),
                  ),
                ),
/*                ),*/
                Text(loginError ?? ''),
/*                Expanded(
                child: */Container(
                  margin: EdgeInsets.fromLTRB(0, 500, 0, 0),
                  width: 170,
                  height: 50,
                  child: FlatButton(
                    onPressed: (){
                      loginAction();
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Text('Sign Up', style: TextStyle(color: Colors.blueGrey[900], fontSize: 20),),
                  ),
                ),
/*                ),*/
                Text(loginError ?? ''),
              ],
            ),
          ]),
    );
  }
}

/// -----------------------------------
///                 App
/// -----------------------------------

void main() {
  runApp(MaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage;
  String name;
  String picture;
  String page;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
/*      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/second': (context) => MainPage(),
      },*/
      title: 'Laugh Cafe Authentication',
      home: Scaffold(
/*        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
*//*          title: const Text('LCAuth'),*//*
        ),*/
        body: Center(

          /// Navigator setState() cannot be used on a currently building widget so either use async/await or .then, etc.

          child: isBusy
              ? const CircularProgressIndicator()
              : isLoggedIn
              ?
          Future.delayed(Duration.zero, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage())).then(FlutterError.onError);})          /*         Profile(logoutAction, name, picture)*/
              : Login(loginAction, errorMessage),
        ),
      ),
    );
  }

  /// Test ErrorHandler

/*  void main() {
    FlutterError.onError = (FlutterErrorDetails details) async {
      FlutterError.dumpErrorToConsole(details);
      if (kReleaseMode)
        await Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
    };
    runApp(MyApp());
 }*/

  Map<String, Object> parseIdToken(String idToken) {
    final List<String> parts = idToken.split('.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, Object>> getUserDetails(String accessToken) async {
    const String url = 'https://$AUTH0_DOMAIN/userinfo';
    final http.Response response = await http.get(
      url,
      headers: <String, String>{'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final AuthorizationTokenResponse result =
      await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: 'https://$AUTH0_DOMAIN',
          scopes: <String>['openid', 'profile', 'offline_access'],
           promptValues: ['login']
        ),
      );

      final Map<String, Object> idToken = parseIdToken(result.idToken);
      final Map<String, Object> profile =
      await getUserDetails(result.accessToken);

      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } on Exception catch (e, s) {
      debugPrint('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }

  Future<void> initAction() async {
    final String storedRefreshToken =
    await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

    try {
      final TokenResponse response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
      ));

      final Map<String, Object> idToken = parseIdToken(response.idToken);
      final Map<String, Object> profile =
      await getUserDetails(response.accessToken);

      await secureStorage.write(
          key: 'refresh_token', value: response.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } on Exception catch (e, s) {
      debugPrint('error on refresh token: $e - stack: $s');
      await logoutAction();
    }
  }
}
/*
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
*/



class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool iconColor = false;
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
                       onTap: (){
                         setState(() {
                           iconColor = true;
                         });
                       },
                       child: Container(
                         margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                         color: Colors.blueGrey[900],
                         child: iconColor ? Icon(Icons.favorite, color: Colors.pink, size: 45,) : Icon(Icons.favorite, color: Colors.pink, size: 45,),
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
    'https://imageproxy.ifunny.co/crop:x-20,resize:320x,crop:x800,quality:90x75/images/dbf4cf30771d178ab1a6ab237f780e9759c6cb471fc9edbacdc1d518e8f11c1a_1.jpg',
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriberListPage()));
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
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalProfilePage()));
                        },
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
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePost()));
                        },
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



class SubscriberListPage extends StatefulWidget {
  @override
  _SubscriberListPageState createState() => _SubscriberListPageState();
}

class _SubscriberListPageState extends State<SubscriberListPage> {
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
          width: 310,
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
                    width: 310,
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
                        children: userComments.map((comment) => commentCard(comment)).toList(), //chatbubble.map((mess) => messageForm(mess)).toList();
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
  List<String> chatbubble = [];
  final mycontroller = TextEditingController();
  Widget messageForm(mess){
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              padding: EdgeInsets.all(20),
              onPressed: (){},
              color: Colors.teal[400],
              child: Text( mess, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey[800])),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anonymous Cafe Lounge  [5/16]  👤'),
        //centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      // width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 20, 0,20),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(20),
                        onPressed: (){},
                        color: Colors.blueGrey[100],
                        child: Text( 'Wow, the silly memes are so funny!', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey[800])),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,

                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),

                        padding: EdgeInsets.all(20),
                        onPressed: (){},
                        color: Colors.blueGrey[100],
                        child: Text( 'I agree 👌', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey[800])),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),

                        padding: EdgeInsets.all(20),
                        onPressed: (){},
                        color: Colors.blueGrey[100],
                        child: Text( 'Which categories do you guys like the most?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey[800])),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),

                        padding: EdgeInsets.all(20),
                        onPressed: (){},
                        color: Colors.teal[400],
                        child: Text( 'The SUPER silly of course! 😂', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey[800])),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 540, 0, 0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      chatbubble.add(mycontroller.text);
                      print(chatbubble[0]);
                      chatbubble.map((mess) => messageForm(mess)).toList();
                    });
                  },
                  icon: Icon(Icons.add_circle_outline),
                ),
              ),
              Container(
                width: 340,
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.fromLTRB(0, 470, 0, 0),
                child: TextField(
                  controller: mycontroller,
                  decoration: InputDecoration(
                    hintText: 'Chat Here...',
                    filled: true,
                    fillColor: Colors.blueGrey[100],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class PersonalProfilePage extends StatefulWidget {
  @override
  _PersonalProfilePageState createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {

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
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://live.staticflickr.com/4586/38356245336_6b439c3843_b.jpg'),
                fit: BoxFit.fill
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,70,0,0),
                child: Text('UserName', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('https://upload.wikimedia.org/wikipedia/en/9/93/Man_Alive_King_Krule.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,195,0,0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.mood, color: Colors.white,),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text('1K Likes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),)
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,200,20,0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text('30 Subscribers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),)
                ),
              ],
            ),
          ),
          Container(
            height: 430,
            margin: EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: GridView.count(
              padding: EdgeInsets.all(15),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                GestureDetector(
                  onTap: (){
                    print('pressed');
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayMeme1()));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage('https://i.pinimg.com/originals/dd/43/98/dd4398d986933b277575dea5c314a3b2.jpg'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://www.bingeclock.com/memes/spongebob-squarepants___said_the_same_thing_twice.jpg'),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://image-aws-us-west-2.vsco.co/080e47/95362960/5c55a6cfd31cf77a6797c086/vsco5c55a6d0bda90.jpg'),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://i.imgur.com/XQALKju_d.webp?maxwidth=728&fidelity=grand'),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://i.redd.it/50qbh2ysdoi51.jpg'),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://cdn.guff.com/site_0/media/33000/32013/items/96cb958e5d33540b37ead313.jpg'),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class DisplayMeme1 extends StatefulWidget {
  @override
  _DisplayMeme1State createState() => _DisplayMeme1State();
}

class _DisplayMeme1State extends State<DisplayMeme1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/originals/dd/43/98/dd4398d986933b277575dea5c314a3b2.jpg'),
          ),
        ),
      ),
    );
  }
}



class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  double xPos = 0;
  double yPos = 0;
  double boxStuff = 0;
  double containerWidth;
  String textValue ='';
  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  GlobalKey _keyText = GlobalKey();
  final myController = TextEditingController();
  getSizes() {
    final RenderBox renderBoxRed = _keyText.currentContext.findRenderObject();
    containerWidth = renderBoxRed.size.width;
    print("WIDTH of Red: $containerWidth");
    boxStuff = 400 - containerWidth;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        color: Colors.blueGrey[900],
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text('Create a Post', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
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
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      child: _image == null ? Text('') : Image.file(_image, fit: BoxFit.fill,),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width - 20,
                      height: 50,
                      child: FlatButton(
                        onPressed: (){
                          getImage();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text('Upload Photo', style: TextStyle(color: Colors.white),),
                        color: Colors.blueGrey[900],
                        disabledColor: Colors.blueGrey[900],
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: (){
                              textValue = myController.text;
                              setState(() {
                                textValue = myController.text;
                                getSizes();

                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                              child: Icon(Icons.add_circle_outline, color: Colors.blueGrey[900], size: 30,),
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          height: 50,
                          width: MediaQuery.of(context).size.width - 80,
                          child: Builder(
                            builder: (context) => TextField(
                              controller: myController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left:10, top: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Text Value #1',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: yPos,
            left: xPos,
            child: GestureDetector(
              onPanUpdate: (tapInfo){
                setState(() {
                  xPos += tapInfo.delta.dx;
                  yPos += tapInfo.delta.dy;
                  if(xPos > (boxStuff)){
                    xPos = boxStuff;
                  }
                  else if(xPos < 5){
                    xPos = 5;
                  }
                  if(yPos < 0){
                    yPos = 0;
                  }
                  else if(yPos > 290){
                    yPos = 290;
                  }
                });
              },
              child: Container(
                key: _keyText,
                margin: EdgeInsets.only(top: 100),

                height: 50,
                color: Colors.transparent,
                child: Text('${textValue}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color:Colors.black),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





