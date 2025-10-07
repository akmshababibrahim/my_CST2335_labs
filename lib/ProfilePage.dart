import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/DataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _number;
  late TextEditingController _email;


  @override
  void initState(){
    super.initState();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _number = TextEditingController();
    _email = TextEditingController();

    _firstName.addListener((){
      DataRepository.firstname = _firstName.text.trim() ;
    });
    _lastName.addListener((){
      DataRepository.lastname = _lastName.text.trim();
    });

    _number.addListener((){
      DataRepository.mobilenumber = _number.text.trim();
    });

    _email.addListener((){
      DataRepository.emailaddress = _email.text.trim();
    });
    Future.delayed(Duration.zero, welcome);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoLoadData();
    });

  }

  Future<void> autoLoadData() async {
    await DataRepository.loadData();
    _firstName.text = DataRepository.firstname;
    _lastName.text = DataRepository.lastname;
    _number.text = DataRepository.mobilenumber;
    _email.text = DataRepository.emailaddress;
  }

  @override
  void dispose(){
    _firstName.dispose();
    _lastName.dispose();
    _number.dispose();
    _email.dispose();
    DataRepository.saveData();
    super.dispose();
  }
  void back(){
    Navigator.pop(context);
  }
  void welcome(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome Back ${DataRepository.loginName}"), duration: const Duration(seconds: 5)));
  }




  Future<void> call(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cannot Launch'),
            content: Text('Could not launch phone call to $phoneNumber.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> sms(String phoneNumber) async {
    final Uri url = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cannot Launch'),
            content: Text('Could not sms to $phoneNumber.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> email(String emailAddress) async {
    final Uri url = Uri(scheme: 'mailto', path: emailAddress,);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cannot Launch'),
            content: Text('Could not launch email to $emailAddress.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Profile Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome Back ${DataRepository.loginName}",
              style: TextStyle(
                fontSize: 24,         // text size
                fontWeight: FontWeight.bold, // bold text
              ),
            ),
            Flexible(child: Padding(padding: const EdgeInsets.all(8.0), child: TextField(controller: _firstName, decoration: InputDecoration(hintText: "First Name", border: OutlineInputBorder(),),),),),
            Flexible(child: Padding(padding: const EdgeInsets.all(8.0), child: TextField(controller: _lastName, decoration: InputDecoration(hintText: "Last Name", border: OutlineInputBorder(),),),),),
            Row(children: [
              Flexible(child: Padding(padding: const EdgeInsets.all(8.0), child: TextField(controller: _number,decoration: InputDecoration(hintText: "Phone Number", border: OutlineInputBorder(),),),),),
              ElevatedButton(
                onPressed: () async {
                  await call(_number.text.trim());
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.call),
              ),
              ElevatedButton(
                onPressed: () async {
                  await sms(_number.text.trim());
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.sms),
              ),
            ],),
            Row(
              children: [
                Flexible(child: Padding(padding: const EdgeInsets.all(8.0), child: TextField(controller: _email,decoration: InputDecoration(hintText: "Email", border: OutlineInputBorder(),),),),),
                ElevatedButton(
                  onPressed: () async {
                    await email(_email.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.email),
                )
              ],
            ),
          ],
        )
      )
    );
  }
  
}