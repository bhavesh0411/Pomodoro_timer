import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomodoro_timer/settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TextEditingController txtWork;
  TextEditingController txtShort;
  TextEditingController txtLong;

  static const String WORKTIME = " workTime";
  static const String SHORTBREAK = " workTime";
  static const String LONGBREAK = " workTime";

  int workTime;
  int shortBreak;
  int longBreak;

  SharedPreferences prefs;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int workTime = prefs.getInt(WORKTIME);
    if (workTime == null){
      await prefs.setInt(WORKTIME, int.parse('30'));
    }

    int shortBreak = prefs.getInt(SHORTBREAK);
    if (workTime == null){
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }

    int longBreak = prefs.getInt(LONGBREAK);
    if (workTime == null){
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int workTime = prefs.getInt(SHORTBREAK);
          workTime += value;
          if (workTime >= 1 && workTime <= 120) {
            prefs.setInt(SHORTBREAK, shortBreak);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int workTime = prefs.getInt(LONGBREAK);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(LONGBREAK, longBreak);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", updateSettings, WORKTIME, -1),
          TextField(
            style: textStyle,
            controller: txtWork,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(Color(0xff455A64), "+", updateSettings, WORKTIME, -1),

          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", updateSettings, SHORTBREAK, -1),
          TextField(
            style: textStyle,
            controller: txtWork,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(Color(0xff455A64), "+", updateSettings, SHORTBREAK, -1),

          Text("Long", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455A64), "-", updateSettings, LONGBREAK, -1),
          TextField(
            style: textStyle,
            controller: txtWork,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(Color(0xff455A64), "+", updateSettings, LONGBREAK, -1),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
