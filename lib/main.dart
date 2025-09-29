import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

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
  final _pref = EncryptedSharedPreferences();

  @override
  void initState(){
    super.initState();
    _login = TextEditingController();
    _password = TextEditingController();
    Future.delayed(Duration.zero, _loadCredentials);
    // WidgetsBinding.instance.addPostFrameCallback((_) => _loadCredentials());
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

  void _loadCredentials() async{
    final _username = await _pref.getString("login");
    final _pwd = await _pref.getString("password");

    if ((_username != null && _username != "") && (_pwd != null && _pwd != "")){
      _login.text = _username;
      _password.text = _pwd;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loaded saved username and password'), duration: const Duration(seconds: 5)),
      );
    }
  }

  Future<void> _ask() async {
    final prompt = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Save credentials?'),
        content: const Text('Would you like to save your username and password for next time?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (prompt == true) {
      await _pref.setString("login", _login.text.trim());
      await _pref.setString('password', _password.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credentials saved securely'), duration: const Duration(seconds: 5),),
      );
    } else if (prompt == false) {
      await _pref.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved credentials cleared'), duration: const Duration(seconds: 5),),
      );
    }
  }

  Future<void> _onLoginPressed() async {
    getPassword();
    await _ask();
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
            ElevatedButton(onPressed: _onLoginPressed, style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), foregroundColor: Colors.blueAccent),child: Text("Login", style: TextStyle(fontSize: 24))),
            Padding(padding: EdgeInsets.all(16.0) , child: Image.asset("images/$imageName", width: 100, height: 100))
          ],
        ),
      ),
    );
  }
}