import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Locale selectedLocale = const Locale('en', 'US');
  // Initial language selection
  // Method to update the app's language
  _updateLanguage(Locale local) {
    Get.back(); // Close the language selection screen
    Get.updateLocale(local); // Update the app's locale
  }

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
            trailing: DropdownButton<Locale>(
              value: selectedLocale,
              onChanged: (Locale? newValue) {
                setState(() {
                  selectedLocale = newValue!;
                  _updateLanguage(newValue); // Call the _updateLanguage method
                });
              },
              items: [
                DropdownMenuItem<Locale>(
                  value: const Locale('en', 'US'),
                  child: Text('ENGLISH'),
                ),
                DropdownMenuItem<Locale>(
                  value: const Locale('et', 'ET'),
                  child: Text('አማርኛ'),
                ),
                DropdownMenuItem<Locale>(
                  value: const Locale('et', 'TG'),
                  child: Text('ትግሪኛ'),
                ),
                DropdownMenuItem<Locale>(
                  value: const Locale('et', 'OR'),
                  child: Text('Afaan Oromoo'),
                ),
                // Add more locales as needed
              ],
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
              // Example: SharedPreferences.getInstance().then((prefs) => prefs.setString('language', selectedLocale.languageCode));

              // After changing the language, you can navigate to another screen using GetX.
              Get.offNamed('/home'); // Replace with your screen's route name.
            },
            // Customize the button's appearance to match your app's theme
            child: Text('Save Changes', style: TextStyle(fontSize: 18.0)),
          ),
        ],
      ),
    );
  }
}
