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
      debugShowCheckedModeBanner: false,
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
      home: const MyHomePage(title: 'Food Truck'),
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
  double _radius = 45;
  Color _byMeatColor = Colors.white;
  double _byMeatFontSize = 19;
  double _textSubHeadingFontSize = 24;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("BROWSE CATEGORIES", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),child: Text("Not sure about exactly which recipe you are looking for? Do a search, or dive into our most popular categories", style: TextStyle(fontSize: 16), textAlign: TextAlign.start,)),
            Text("BY MEAT", style: TextStyle(fontSize: _textSubHeadingFontSize, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
              Stack(alignment: Alignment.center, children: [CircleAvatar(backgroundImage: AssetImage("images/beef-image.jpg"),radius: _radius,), Text("BEEF", style: TextStyle(fontWeight: FontWeight.bold, fontSize: _byMeatFontSize, color: _byMeatColor),)],),
              Stack(alignment: Alignment.center, children: [CircleAvatar(backgroundImage: AssetImage("images/chicken.jpg"),radius: _radius,), Text("CHICKEN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: _byMeatFontSize, color: _byMeatColor),)],),
              Stack(alignment: Alignment.center, children: [CircleAvatar(backgroundImage: AssetImage("images/pork.jpg"),radius: _radius,), Text("PORK", style: TextStyle(fontWeight: FontWeight.bold, fontSize: _byMeatFontSize, color: _byMeatColor),)],),
              Stack(alignment: Alignment.center, children: [ CircleAvatar(backgroundImage: AssetImage("images/seafood.jpg"),radius: _radius,), Text("SEAFOOD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: _byMeatFontSize, color: _byMeatColor),)],),
             ],),
            Text("BY COURSE", style: TextStyle(fontSize: _textSubHeadingFontSize, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Column(children: [CircleAvatar(backgroundImage: AssetImage("images/main-dishes.jpg"),radius: _radius,), Padding(padding: const EdgeInsets.only(top: 8.0), child: Text("Main Dishes")),],),
              Column(children: [CircleAvatar(backgroundImage: AssetImage("images/salad.jpg"),radius: _radius,), Padding(padding: const EdgeInsets.only(top: 8.0), child: Text("Salad Recipes")),],),
              Column(children: [CircleAvatar(backgroundImage: AssetImage("images/side-dishes.jpg"),radius: _radius,), Padding(padding: const EdgeInsets.only(top: 8.0), child: Text("Side Dishes")),],),
              Column(children: [CircleAvatar(backgroundImage: AssetImage("images/crockpot.jpg"),radius: _radius,), Padding(padding: const EdgeInsets.only(top: 8.0), child: Text("Crockpot")),],),
            ],),
            Text("BY DESSERT", style: TextStyle(fontSize: _textSubHeadingFontSize, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            Padding(padding: const EdgeInsets.only(bottom: 8.0), child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Column(children: [CircleAvatar(backgroundImage: AssetImage("images/ice-cream.jpg"),radius: _radius,), Padding(padding: const EdgeInsets.only(top: 8.0), child: Text("Ice-cream")),],),
              Column(children: [CircleAvatar(backgroundImage: AssetImage("images/brownies.jpg"),radius: _radius,), Padding(padding: const EdgeInsets.only(top: 8.0), child: Text("Brownies")),],),
              Column(children: [CircleAvatar(backgroundImage: AssetImage("images/pie.jpg"),radius: _radius,), Padding(padding: const EdgeInsets.only(top: 8.0), child: Text("Pies")),],),
              Column(children: [CircleAvatar(backgroundImage: AssetImage("images/cookies.jpg"),radius: _radius,), Padding(padding: const EdgeInsets.only(top: 8.0), child: Text("Cookies")),],),
            ],)),



          ],
        ),
      ),
    );
  }
}
