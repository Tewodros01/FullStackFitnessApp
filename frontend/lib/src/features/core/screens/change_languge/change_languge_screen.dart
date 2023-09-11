import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'English'; // Initial language selection

  // List of available languages. You can customize this list.
  List<String> languages = ['English', 'Spanish', 'French', 'German'];
  List locales = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'አማርኛ', 'locale': const Locale('et', 'ET')},
    {'name': 'ትግሪኛ', 'locale': const Locale('et', 'TG')},
    {'name': 'Afaan Oromoo', 'locale': const Locale('et', 'OR')},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(
          "Setting",
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title:
                const Text('Change Language', style: TextStyle(fontSize: 18.0)),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
              items: languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Other Setting 1', style: TextStyle(fontSize: 18.0)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to other setting 1 screen or perform action
            },
          ),
          Divider(),
          ListTile(
            title: Text('Other Setting 2', style: TextStyle(fontSize: 18.0)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to other setting 2 screen or perform action
            },
          ),
          Divider(),
          ElevatedButton(
            onPressed: () {
              // Perform the language change action here, e.g., save to preferences
              // You can use a package like shared_preferences for this purpose.
              // Example: SharedPreferences.getInstance().then((prefs) => prefs.setString('language', selectedLanguage));

              // After changing the language, you can navigate to another screen.
              Navigator.of(context).pushReplacementNamed(
                  '/home'); // Replace with your screen's route name.
            },
            // Customize the button's appearance to match your app's theme
            child: Text('Save Changes', style: TextStyle(fontSize: 18.0)),
          ),
        ],
      ),
    );
  }
}
