import 'package:flutter/material.dart';
import 'package:frivia/pages/game_page.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double? _deviceHeight;
  double _currentDifficultyLevel = 0.0;
  final List<String> _diffycultyTexts = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [_appTile(), _difficultySlider(), _startButton()],
          ),
        ),
      ),
    );
  }

  Widget _appTile() {
    return Column(
      children: [
        const Text(
          "FRIVIA",
          style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        Text(
          _diffycultyTexts[_currentDifficultyLevel.toInt()],
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
        )
      ],
    );
  }

  Widget _difficultySlider() {
    return Slider(
        label: "Difficulty",
        min: 0,
        max: 2,
        divisions: 2,
        value: _currentDifficultyLevel,
        onChanged: (_value) {
          setState(() {
            _currentDifficultyLevel = _value;
          });
        });
  }

  Widget _startButton() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => GamePage(difficultyLevel: _diffycultyTexts[_currentDifficultyLevel.toInt()].toLowerCase(),),
            ),
          );
        },
        child: const Text("Start",
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 8, 95, 227))));
  }
}
