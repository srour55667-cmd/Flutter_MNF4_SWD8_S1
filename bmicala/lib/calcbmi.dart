import 'package:bmicala/card.dart';
import 'package:bmicala/heightRulerCard.dart';
import 'package:flutter/material.dart';

class Calcbmi extends StatefulWidget {
  const Calcbmi({super.key});

  @override
  State<Calcbmi> createState() => _CalcbmiState();
}

class _CalcbmiState extends State<Calcbmi> {
  int weight = 65;
  int age = 21;
  int height = 150;
  String massage() {
    if (weight / ((height / 100) * (height / 100)) < 18.5) {
      return "Underweight";
    } else if (weight / ((height / 100) * (height / 100)) < 25) {
      return "Normal weight";
    } else if (weight / ((height / 100) * (height / 100)) < 30) {
      return "Overweight";
    } else {
      return "Obesity";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Color(0xff65B741),
                ),
              ),
              SizedBox(width: 60),
              textbmicala(),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Please Modify the values",
            style: TextStyle(fontSize: 24, color: Color(0xff0A1207)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StepperCard(
                label: 'Weight',
                unit: 'kg',
                value: weight,
                onMinus: () => setState(() => weight = (weight - 1)),
                onPlus: () => setState(() => weight = (weight + 1)),
              ),
              SizedBox(width: 25),
              StepperCard(
                label: 'Aga',
                unit: "ans",
                value: age,
                onMinus: () => setState(() => age = (age - 1)),
                onPlus: () => setState(() => age = (age + 1)),
              ),
            ],
          ),

          HeightRulerCard(
            value: height,
            min: 120,
            max: 220,
            onChanged: (v) => setState(() => height = v),
          ),

          Container(
            margin: EdgeInsets.all(25),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Color(0xff65B741),
            ),
            child: InkWell(
              onTap: () {
                double bmiValue = weight / ((height / 100) * (height / 100));
                String bmiCategory = massage();

                AlertDialog alert = AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.white,
                  title: Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 50,
                          color: Color(0xff65B741),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Your BMI Result",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0A1207),
                          ),
                        ),
                      ],
                    ),
                  ),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xffFFB534).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            bmiValue.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFFB534),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff65B741),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            bmiCategory,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff65B741),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          child: Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
                showDialog(context: context, builder: (context) => alert);
              },
              child: Center(
                child: Text(
                  "Calculate",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row textbmicala() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "BMI",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xffFFB534),
          ),
        ),
        Text(
          "Calculator",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xff65B741),
          ),
        ),
      ],
    );
  }
}
