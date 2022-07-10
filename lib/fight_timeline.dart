import 'package:animationflight/flight_route.dart';
import 'package:flutter/material.dart';

const airPlanSize=30.0;
const dotSize=15.0;
const _cardAnimationDuration=100;
class FightTimeLine extends StatefulWidget {
  const FightTimeLine({Key? key}) : super(key: key);

  @override
  State<FightTimeLine> createState() => _FightTimeLineState();
}

class _FightTimeLineState extends State<FightTimeLine> {
  bool _isAnimated=false;
  bool _isAnimatedCards=false;
  bool _isAnimatedButton=false;

  void _initAnimation() async{
    setState(() {
      _isAnimated=!_isAnimated;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _isAnimatedCards=true;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _isAnimatedButton=true;
    });
  }
  void _onRoutesPressed(){
    Navigator.of(context).push(PageRouteBuilder(pageBuilder:(_,animation1,__){
      return FadeTransition(opacity: animation1,
      child: const FlightRoute(),);
    }));
  }
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _initAnimation();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      final centerDot=constraints.maxWidth/2-dotSize/2;
      print(constraints);
      return Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              left: constraints.maxWidth/2-airPlanSize/2,
              top:_isAnimated?20: constraints.maxHeight-airPlanSize-20,
              bottom: 0.0,
              child: const AirCraftAndLine()),
          AnimatedPositioned(
            duration:const Duration(milliseconds: 600),
              top: _isAnimated?80:constraints.maxHeight,
              left: centerDot,
              child: TimeLineDot(isSelected: true,
              isDisplayCard:_isAnimatedCards ,
                  delay: const Duration(milliseconds: _cardAnimationDuration))),
          AnimatedPositioned(
              duration:const Duration(milliseconds: 800),
              top: _isAnimated?140:constraints.maxHeight,
              right: centerDot,
              child: TimeLineDot(isLeft: true, isDisplayCard:_isAnimatedCards,
                delay: const Duration(milliseconds: _cardAnimationDuration*2),)),
          AnimatedPositioned(
              duration:const Duration(milliseconds: 1000),
              top: _isAnimated?200:constraints.maxHeight,
              left: centerDot,
              child: TimeLineDot( isDisplayCard:_isAnimatedCards,
                delay: const Duration(milliseconds: _cardAnimationDuration*3),)),
          AnimatedPositioned(
              duration:const Duration(milliseconds: 1200),
              top: _isAnimated?260:constraints.maxHeight,
              right: centerDot,
              child: TimeLineDot(
                  isSelected: true,
                  isLeft: true,
                  delay: const Duration(milliseconds: _cardAnimationDuration*4),
                  isDisplayCard:_isAnimatedCards )),
         if(_isAnimatedButton) Align(
            alignment: Alignment.bottomCenter,
            child:TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0,end: 1.0),
          duration:const Duration(milliseconds: 500),
          child: FloatingActionButton(
              backgroundColor: Colors.red,
              child:const Icon(Icons.check),
              onPressed: (){
                _onRoutesPressed();
              },
            ),
            builder:(context,value,child) {
            return Transform.scale(scale: value,
            child:child);
            },)),
          ],

      );
    });
  }
}

 class AirCraftAndLine extends StatelessWidget {

   const AirCraftAndLine({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return SizedBox(
       width: airPlanSize,
       child: Column(
         children: [
           Icon(Icons.flight,
           size: airPlanSize,
           color: Colors.red,),
           Expanded(child:Container(
             width: 5,
             color: Colors.grey[300],
           ))
         ],
       ),
     );
   }
 }

 class  TimeLineDot extends StatefulWidget {
   final bool isSelected;
   final bool isDisplayCard;
   final bool isLeft;
   final Duration delay;
   const TimeLineDot({Key? key,this.isSelected=false,this.isDisplayCard=false,this.isLeft=false,this.delay=const Duration(milliseconds: 0)}) : super(key: key);

   @override
   State<TimeLineDot> createState() => _TimeLineDot();
 }

class _TimeLineDot extends State<TimeLineDot> {
   bool isAnimated=false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(isAnimated && widget.isLeft)...[

          _buildCard(),
          _buildDivider(),
       ],
        Container(
          height: dotSize,
          width: dotSize,
          decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child:CircleAvatar(
              backgroundColor:widget.isSelected?Colors.red:Colors.green ,
            ),
          ),
        ),
        if(isAnimated && !widget.isLeft)...[
          _buildDivider(),
          _buildCard()
        ]
      ],
    );
  }


   _animateWidthDelay()async{
     if(widget.isDisplayCard) {
       await Future.delayed(widget.delay);
       setState(() {
         isAnimated = true;
       });
     }
   }
   @override
   void didUpdateWidget(covariant TimeLineDot oldWidget) {
     _animateWidthDelay();
     super.didUpdateWidget(oldWidget);
   }

 Widget _buildCard() =>
       TweenAnimationBuilder<double>(
         tween: Tween(begin: 0.0,end: 1.0),
         duration: const Duration(milliseconds: _cardAnimationDuration),
         child:   Container(
             color: Colors.grey[200],
             child:const Padding(
               padding:  EdgeInsets.all(20.0),
               child: Text("Savvient"),
             )
         ),
         builder: (context,value,child){
           return Transform.scale(scale: value,
           alignment: widget.isLeft?Alignment.centerRight:Alignment.centerLeft,
           child:child ,);
         },
       );


  Widget _buildDivider()  =>
     Container(
      width: 10,
      height: 2,
      color: Colors.grey[400],
    );

}
