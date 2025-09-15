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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      imageName = passwordValue == actualPassword ? ideaImage : stopImage;

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
            Padding(padding: EdgeInsets.all(16.0) , child: Image.asset("images/$imageName", width: 100, height: 100))
          ],
        ),
      ),
    );
  }
}
