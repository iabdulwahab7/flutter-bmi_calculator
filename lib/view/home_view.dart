import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var feetController = TextEditingController();
  var inchController = TextEditingController();
  var weightController = TextEditingController();

  var result = "";
  var message = "";
  Color bgColor = const Color.fromARGB(255, 235, 242, 245);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: bgColor,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("BMI Calculator",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 30),
          TextFieldColumn(
              feetController: feetController,
              inchController: inchController,
              weightController: weightController),
          const SizedBox(height: 20),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
                child: InkWell(
                    onTap: () {
                      var feet = feetController.text.toString();
                      var inch = inchController.text.toString();
                      var weight = weightController.text.toString();

                      if (feet != "" && inch != "" && weight != "") {
                        //bmi calculate

                        var iFeet = int.parse(feet);
                        var iInch = int.parse(inch);
                        var iWeight = int.parse(weight);

                        // total inches calculation
                        var tInch = (iFeet * 12) + iInch;

                        // into cm
                        var tCM = tInch * 2.54;

                        // in meter
                        var tM = tCM / 100;

                        // bmi
                        var bmi = iWeight / (tM * tM);

                        if (bmi <= 18.5) {
                          message = "Underweight!";
                          bgColor = const Color.fromARGB(255, 177, 175, 175);
                        } else if (bmi > 18.5 && bmi < 24.9) {
                          message = "Normal Weight!";
                          bgColor = const Color.fromARGB(255, 174, 188, 180);
                        } else if (bmi >= 25 && bmi < 29.9) {
                          message = "Over Weight!";
                          bgColor = const Color.fromARGB(255, 197, 197, 197);
                        } else {
                          message = "Obsity!";
                          bgColor = const Color.fromARGB(255, 197, 197, 197);
                        }

                        setState(() {
                          result =
                              "Your BMI : ${bmi.toStringAsFixed(2)} \n\n ${message.toString()}";
                        });
                      } else {
                        setState(() {
                          result = "Please fill all the required fields!";
                        });
                      }
                    },
                    child: const Text(
                      "Calculate BMI",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ))),
          ),
          const SizedBox(height: 30),
          Text(
            result,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          )
        ]),
      ),
    ));
  }
}

class TextFieldColumn extends StatelessWidget {
  const TextFieldColumn({
    super.key,
    required this.feetController,
    required this.inchController,
    required this.weightController,
  });

  final TextEditingController feetController;
  final TextEditingController inchController;
  final TextEditingController weightController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Column(children: [
        TextField(
          controller: feetController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Feet",
            labelText: "Feet",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: inchController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Inch",
            labelText: "Inch",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: weightController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Weight",
            labelText: "Weight",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ]),
    );
  }
}
