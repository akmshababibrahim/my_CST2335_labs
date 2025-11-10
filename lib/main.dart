import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/ItemDAO.dart';
import 'package:my_cst2335_labs/ItemDatabase.dart';

import 'Item.dart';

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

  // List<String> items = [];
  // List<String> quantity = [];
  List<Item> listOfItems = [];
  TextEditingController itemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  late ItemDAO itemDao;
  Item? selectedItem = null;

  void add() async {
    Item newItem = Item(Item.ID++, itemController.text.trim(), int.parse(quantityController.text.trim()));
    await itemDao.insertItem(newItem);

    setState(() {
      // items.add(itemController.text.trim());
      // quantity.add(quantityController.text.trim());

      listOfItems.add(newItem);

      itemController.text = "";
      quantityController.text = "";
    });
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    itemController.addListener(() => setState(() {}));
    quantityController.addListener(() => setState(() {}));

    $FloorItemDatabase.databaseBuilder("mydatabase.db").build().then((database){
      itemDao = database.myItemDAO;

      itemDao.getAllItems().then((itemList){
        setState(() {
          listOfItems.addAll(itemList);

        });
      });
    });

  }

  @override
  void dispose() {
    itemController.dispose();
    quantityController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: reactiveLayout(),
    );
  }

  Widget reactiveLayout(){
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    if( (width>height) && (width > 720)) {
      return Row(
          children:[
            Expanded(flex: 1, // takes  a/(a+b)  of available width
                child: ListPage()  ),
            Expanded(flex: 2, // takes b(a+b) of available width
                child: DetailsPage())
          ]);
    }
    else{
      if (selectedItem == null){
        return ListPage();
      }
      else{
        return DetailsPage();
      }
    }
  }

  Widget DetailsPage(){
    if (selectedItem != null){
      return Center(
        child: Column(children:
        [Text("ID: ${selectedItem?.id} "),
          Text("Name: ${selectedItem?.name} "),
          Text("Quantity: ${selectedItem?.quantity}"),
          Spacer(),
          OutlinedButton(onPressed: (){setState(() {
            selectedItem = null;
          });}, child: Text("Close")),
          OutlinedButton(onPressed: () async {
            await itemDao.deleteItem(selectedItem!);
            setState(() {
              listOfItems.remove(selectedItem);
              selectedItem = null;
          });}, child: Text("Delete"))
        ], mainAxisAlignment: MainAxisAlignment.center,),);
    }
    else{
      return Text("Please select an item.");
    }
  }
  Widget ListPage(){

    return Padding(padding: EdgeInsets.all(16.0),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: TextField(controller: itemController, decoration: const InputDecoration(hintText: 'Item', hintStyle: TextStyle(color: Colors.blueGrey),border: OutlineInputBorder(),))),
            Expanded(child: TextField(controller: quantityController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: 'Quantity', hintStyle: TextStyle(color: Colors.blueGrey), border: OutlineInputBorder(),))),
            Expanded(child: ElevatedButton(onPressed: (itemController.text.isEmpty || quantityController.text.isEmpty) ? null : add, child: Text("Add")))
          ],
        ),
        Expanded(child: Padding(padding: EdgeInsets.all(16.0), child: ListView.builder(itemCount: listOfItems.length, itemBuilder: (context, rowNum) {return
          GestureDetector(child: Center(child: Text("${rowNum + 1}. ${listOfItems[rowNum].name}, quantity: ${listOfItems[rowNum].quantity}")),
          onTap:(){
            setState((){
              selectedItem = listOfItems[rowNum];
            });
              },
          onLongPress: (){
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Delete item"),
                content: const Text("Are you sure?"),
                actions: [
                  FilledButton(child: Text("Yes"), onPressed: () async {
                    Navigator.pop(context);
                    await itemDao.deleteItem(listOfItems[rowNum]);
                    setState(() {
                      // items.removeAt(rowNum);
                      // quantity.removeAt(rowNum);
                      listOfItems.removeAt(rowNum);
                    });
                  },),
                  FilledButton(child: Text("Cancel"), onPressed: (){
                    Navigator.pop(context);
                  },)
                ],
              )
            );
          },);
        })))
      ],
    ));
  }
}


