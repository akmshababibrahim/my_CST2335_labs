import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late TextEditingController _login;
  late TextEditingController _password;
  String passwordValue = "";
  String imageName = "question-mark.png";
  String actualPassword = "QWERTY123";
  String ideaImage = "idea.png";
  String stopImage = "stop.png";
  String anotherPassword = "ASDF";

  @override
  void initState(){
    super.initState();
    _login = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose(){
    _login.dispose();
    _password.dispose();
    super.dispose();
  }

  void getPassword(){
    setState(() {
      passwordValue = _password.text;
      imageName = (passwordValue == actualPassword) || (passwordValue == anotherPassword) ? ideaImage : stopImage;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _login,  decoration: InputDecoration(hintText: "Login", border: OutlineInputBorder())),
            TextField(controller: _password, decoration: InputDecoration(hintText: "Password", border: OutlineInputBorder()), obscureText: true,),
            ElevatedButton(onPressed: getPassword, style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), foregroundColor: Colors.blueAccent),child: Text("Login", style: TextStyle(fontSize: 24))),
            Padding(padding: EdgeInsets.all(16.0) , child: Image.asset("images/$imageName", width: 300, height: 300))
          ],
        ),
      ),
    );
  }
}