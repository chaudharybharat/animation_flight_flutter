import 'package:flutter/material.dart';

class FlightRoute extends StatefulWidget {
  const FlightRoute({Key? key}) : super(key: key);

  @override
  State<FlightRoute> createState() => _FlightRouteState();
}

class _FlightRouteState extends State<FlightRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child:  Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFE04148), Color(0xFFD85774)])),
                  ),
                ),
                const Positioned(
                    top: 20,
                    left: 10,
                    child: BackButton(
                      color: Colors.white,
                    )),
                Positioned(
                    top:  MediaQuery.of(context).size.height * 0.10,
                    left: 10,
                    right: 10,
                    child: Column(
                        children:const [
                          RouteItem(duration:  Duration(milliseconds: 400),),
                          RouteItem(duration:  Duration(milliseconds: 600)),
                          RouteItem(duration:  Duration(milliseconds: 800)),
                          RouteItem(duration:  Duration(milliseconds: 1000)),
                          RouteItem(duration:  Duration(milliseconds: 1200)),
                         ],
                      ),
                    ),

              ],
            ),

    ));
  }
}

class RouteItem extends StatelessWidget {
  final Duration duration;
   const RouteItem({Key? key,required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve:Curves.decelerate ,
      tween: Tween(begin:0.1,end: 0.0, ),
      builder: (context,value,child){
        return Transform.translate(offset: Offset(0.0,
        MediaQuery.of(context).size.height*value),
        child: child,);
      },
      child:  Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Flutter",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Flutter",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )
                  ],
                ),
              ),
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.flight,
                    color: Colors.red,),
                  Text("Savvient",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                  )
                ],)),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Savvient",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                    ),
                    Text(
                      "Savvient",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
