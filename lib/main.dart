import 'package:animationflight/fight_timeline.dart';
import 'package:animationflight/flight_from.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
enum FightView{
  from,timeLine
}
class _MyHomePageState extends State<MyHomePage> {
  FightView fightView=FightView.from;
  @override
  Widget build(BuildContext context) {
   final headerHeight=MediaQuery.of(context).size.height*0.32;
    return Scaffold(
     body: SafeArea(
       child: Stack(
         fit: StackFit.expand,
         children: [
         Positioned(
           left: 0,
           right: 0,
           height: headerHeight,
           child: DecoratedBox(
             decoration:BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: [Color(0xFFE0448),
                      Color(0xFFD85774)]
               )
             ),
             child: Padding(
               padding: EdgeInsets.all(15.0),
               child: Column(
                   children: [
                    Text("Air India",
                    style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.white),
                    textAlign: TextAlign.center,),
                     SizedBox(height: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                       HeaderButton(title: "One way",),
                       HeaderButton(title: "Round",),
                       HeaderButton(title: "Multicity",selected: true,),
                     ],)
                   ],
                 ),
               ),
               ),
             ),
         Positioned(
            left: 10,
             right: 10,
             top: headerHeight/2,
             bottom: 0,
             child: Card(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12)
               ),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       TabButton(title: "Flight", isSelected: true),
                       TabButton(title: "Train", ),
                       TabButton(title: "Bus",),
                   ],),
                   Expanded(child:fightView==FightView.from? FlightForm(onTap:onFlightPress,):FightTimeLine())
                 ],
               ),
             ))

       ],),
     ),

    );
  }
  void onFlightPress(){
    setState(() {
      fightView=FightView.timeLine;
    });
  }
}
class HeaderButton extends StatelessWidget {
final String title;
 final bool selected;
  const HeaderButton({Key? key,required this.title,this.selected=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected?Colors.white:Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.white)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 12),
        child: Center(child: Text(title.toUpperCase(),
        style: TextStyle(color: selected?Colors.red:Colors.white),),),
      ),
    );
  }
}
class TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  TabButton({Key? key,required this.title,this.isSelected=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(title,style: TextStyle(color: isSelected?Colors.black:Colors.grey),),
          ),
          if(isSelected)Container(height:2,color: Colors.red,width: 100,),
        ],
      ),
    );
  }
}
