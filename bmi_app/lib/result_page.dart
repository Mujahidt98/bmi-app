import 'package:bmi_app/constants.dart';
import 'package:bmi_app/input_page.dart';
import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'constants.dart';

class ResultPage extends StatelessWidget {
  int bmi;
  String bmiText;
  String explainText;
  Color bmiColor;

  ResultPage(
      {required this.bmi,
      required this.bmiText,
      required this.bmiColor,
      required this.explainText});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        // primaryColor: Color(0X0A0E21),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0A0E21),
        ),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Your Result',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            Expanded(
              flex: 12,
              child: ReusableCard(
                newColor: Color(kInactiveCardColor),
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$bmiText',
                      style: TextStyle(
                          color: bmiColor, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '$bmi',
                      style: kResultPageNumberStyle,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Normal BMI Range:',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text('18.5-25 kg/m2'),
                    SizedBox(
                      height: 25,
                      width: double.infinity,
                    ),
                    Text(
                      '$explainText',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Container(
                width: double.infinity,
                height: kBottomContainerHeight,
                decoration: const BoxDecoration(
                  color: Color(kBottomContainerColor),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "RE-CALCULATE",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
