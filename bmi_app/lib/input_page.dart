import 'dart:ffi';
import 'dart:ui';

import 'package:bmi_app/icon_widget.dart';
import 'package:bmi_app/result_page.dart';
import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'dart:math';

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

enum Gender { Male, Female, None }

class _AppBodyState extends State<AppBody> {
  int maleCardColour = kInactiveCardColor;
  int femaleCardColour = kInactiveCardColor;
  int height = 60;
  int age = 10;
  int weight = 30;
  int minAgeLimit = 10;
  int minWeightLimit = 30;
  int minHeightLimit = 60;
  Gender gender = Gender.None;
  int bmi = 0;
  double calc = 0;
  String bmiIndicator = '';
  String bmiText = '';
  List bmiData = [];

  void changeCardColourOnSelect(String gender) {
    if (gender == "male") {
      maleCardColour = kActiveCardColor;
      femaleCardColour = kInactiveCardColor;
    } else if (gender == "female") {
      femaleCardColour = kActiveCardColor;
      maleCardColour = kInactiveCardColor;
    }
  }

  void addButtonFunction(int number, String type) {
    setState(() {
      if (type == "age") {
        if (number >= minAgeLimit) {
          age++;
        } else {
          age = minAgeLimit;
        }
      } else if (type == "weight") {
        if (number >= minWeightLimit) {
          weight++;
        } else {
          age = minWeightLimit;
        }
      }
    });
  }

  void minusButtonFunction(int number, String type) {
    setState(() {
      if (type == "age") {
        if (number > minAgeLimit) {
          age--;
        } else {
          age = minAgeLimit;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Error',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              content: Text(
                'You cant go beyond minimum age limit i.e. "$minAgeLimit"',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }
      } else if (type == "weight") {
        if (number > minWeightLimit) {
          weight--;
        } else {
          weight = minWeightLimit;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Error',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              content: Text(
                'You cant go beyond minimum weight limit i.e. "$minWeightLimit"',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }
      }
    });
  }

  dynamic calculateBMI(int height, int weight, int age) {
    double mHeight = height / 100;
    Color bmiColor = Colors.white;
    calc = weight / (mHeight * mHeight);
    if (gender != Gender.None) {
      if (calc >= 18 && calc <= 25) {
        bmiIndicator = "NORMAL";
        bmiColor = Colors.green;
        bmiText = "You have a normal BMI, good job.";
      } else if (calc < 18) {
        bmiIndicator = "UNDERWEIGHT";
        bmiColor = Colors.red;
        bmiText = "You need to put up some kgs.";
      } else if (calc > 25) {
        bmiIndicator = "OVERWEIGHT";
        bmiColor = Colors.orange;
        bmiText = "You're overweight, Please try to be fit.";
      } else if (calc > 30) {
        bmiIndicator = "OBESE";
        bmiColor = Colors.red;
        bmiText = "You need to put in some significant diet and habit changes.";
      }

      bmiData.add(calc.toInt());
      bmiData.add(bmiIndicator);
      bmiData.add(bmiColor);
      bmiData.add(bmiText);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Error',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Please select a Gender first',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          print('its clicked male');
                          changeCardColourOnSelect("male");
                          gender = Gender.Male;
                        },
                      );
                    },
                    child: ReusableCard(
                      newColor: Color(maleCardColour),
                      cardChild: IconWidget(
                          cardLabel: 'MALE',
                          iconData: FontAwesomeIcons.mars,
                          iconSize: 50),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          print('its clicked female');
                          changeCardColourOnSelect("female");
                          gender = Gender.Female;
                        },
                      );
                    },
                    child: ReusableCard(
                      newColor: Color(femaleCardColour),
                      cardChild: IconWidget(
                          cardLabel: 'FEMALE',
                          iconData: FontAwesomeIcons.venus,
                          iconSize: 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: ReusableCard(
              newColor: Color(kInactiveCardColor),
              cardChild: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "HEIGHT",
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '$height',
                        style: kLargeTextFontStyle,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text("cm"),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 10.0),
                      activeTrackColor: Color(kBottomContainerColor),
                      thumbColor: Color(kBottomContainerColor),
                      overlayColor: Color(kSliderOverlayColor),
                    ),
                    child: Slider(
                        value: height.toDouble(),
                        min: 60,
                        max: 200,
                        // activeColor: Color(kBottomContainerColor),
                        inactiveColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            height = value.toInt();
                          });
                        }),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                      newColor: Color(kInactiveCardColor),
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style: kBottomCardTextStyle,
                          ),
                          Text(weight.toString(),
                              style: kBottomCardNumberStyle),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                child: FloatingActionButton(
                                  heroTag: "btn1",
                                  backgroundColor: Color(0xFF4C4F5E),
                                  foregroundColor: Colors.white,
                                  onPressed: () =>
                                      minusButtonFunction(weight, "weight"),
                                  child: Icon(
                                    Icons.remove,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                child: FloatingActionButton(
                                  heroTag: "btn2",
                                  backgroundColor: Color(0xFF4C4F5E),
                                  foregroundColor: Colors.white,
                                  onPressed: () =>
                                      addButtonFunction(weight, "weight"),
                                  child: Icon(
                                    Icons.add,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                Expanded(
                  child: ReusableCard(
                      newColor: Color(kInactiveCardColor),
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style: kBottomCardTextStyle,
                          ),
                          Text(
                            age.toString(),
                            style: kBottomCardNumberStyle,
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                child: FloatingActionButton(
                                  heroTag: "btn3",
                                  backgroundColor: Color(0xFF4C4F5E),
                                  foregroundColor: Colors.white,
                                  onPressed: () =>
                                      minusButtonFunction(age, "age"),
                                  child: Icon(
                                    Icons.remove,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                child: FloatingActionButton(
                                  heroTag: "btn4",
                                  backgroundColor: Color(0xFF4C4F5E),
                                  foregroundColor: Colors.white,
                                  onPressed: () =>
                                      addButtonFunction(age, "age"),
                                  child: Icon(
                                    Icons.add,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              calculateBMI(height, weight, age);
              print('height is $height and weight is $weight and age is $age');
              if (bmiData.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                        bmi: bmiData[0],
                        bmiText: bmiData[1],
                        bmiColor: bmiData[2],
                        explainText: bmiData[3]),
                  ),
                );
              }
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
                    "CALCULATE YOUR BMI",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
