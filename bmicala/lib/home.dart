import 'package:bmicala/calcbmi.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedGender = 'Female';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textbmicala(),
          SizedBox(height: 20),
          Text(
            "Please choose your gender",
            style: TextStyle(fontSize: 24, color: Color(0xff0A1207)),
          ),
          buildGenderCard(
            type: 'Male',
            backcolor: Color.fromARGB(15, 23, 97, 194),
            photo: 'assets/images/male.png',
            typecolor: Color(0xff519234),
          ),
          SizedBox(height: 30),
          buildGenderCard(
            type: 'Female',
            backcolor: Color(0xffFFB199),
            photo: 'assets/images/female.png',
            typecolor: Color(0xffCE922A),
          ),
          SizedBox(height: 20),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calcbmi()),
                );
              },
              child: Center(
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildGenderCard({
    required String type,
    required Color backcolor,
    required String photo,
    required Color typecolor,
  }) {
    bool isSelected = selectedGender == type;
    return InkWell(
      onTap: () {
        setState(() {
          selectedGender = type;
        });
      },
      child: Container(
        margin: EdgeInsets.all(20),
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: isSelected ? backcolor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? backcolor.withOpacity(0.3)
                  : Colors.transparent,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 30),
            Text(
              type,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: typecolor,
              ),
            ),
            Spacer(),
            Image.asset(photo),
            SizedBox(width: 30),
          ],
        ),
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
