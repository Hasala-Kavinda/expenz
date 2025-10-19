import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  // method to store the username and user email in shared preferences
  static Future<void> storeUserDetails(
      {required String userName,
      required String email,
      required String password,
      required String confirmPasswrd,
      required BuildContext context}) async {
    // Check whether the user enter password and the confirm password are the same

    try {
      if (password != confirmPasswrd) {
        // show a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password and Confirm password are do not the same"),
          ),
        );
        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", userName);
      await prefs.setString("email", email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Userdetails stored succesfully"),
        ),
      );
    } catch (err) {
      err.toString();
    }
  }
}
