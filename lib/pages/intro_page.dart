import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(

            border: Border.all(color:  Color(0xFF992a21), width: 15)),

        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/intro.jpg'),
                fit: BoxFit.cover, // BoxFit options: cover, contain, fill, etc.
              ),
              border: Border.all(color: Color(0xFF992a21), width: 7)),


          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Image.asset('lib/images/logo1.png'),

              const SizedBox(height: 300,),
              GestureDetector(
                onTap: ()=>Navigator.pushNamed(context,'/home'),
                child: Container(
                  width: 1200,
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Let's cook",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,

                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffc7635b),
                  ),

                ),
              ),
              const SizedBox(height: 0,),


            ],
          ),
        ),
      ),
    );
  }
}
