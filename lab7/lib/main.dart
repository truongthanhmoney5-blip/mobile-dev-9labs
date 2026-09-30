import 'package:flutter/material.dart';
import 'package:bossleveldestini/brain.dart';

void main() => runApp(MainApp());

final StoryBrain storyBrain = StoryBrain();

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: StoryPage());
  }
}

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  void _updateStory(int choiceNumber) {
    setState(() {
      storyBrain.nextStory(choiceNumber);
    });
  }

  Widget _buildChoiceButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      flex: 2,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(backgroundColor: color),
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyBrain.getStory(),
                    style: TextStyle(fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              _buildChoiceButton(
                text: storyBrain.getchoose1(),
                color: Colors.red,
                onPressed: () => _updateStory(1),
              ),
              SizedBox(height: 30.0),
              Visibility(
                visible: storyBrain.buttonShouldBeVisible(),
                child: _buildChoiceButton(
                  text: storyBrain.getchoose2(),
                  color: Colors.green,
                  onPressed: () => _updateStory(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
