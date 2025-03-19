import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/service/pref_handler.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Teks.biasa("Naikin level produktivitas lo!", fs: 15),
            Teks.spesial("Bye-bye\nCatatan Kertas!", fs: 40),
            Image.asset("assets/image/welcome.png"),
            SizedBox(height: 60,),
            
            SizedBox(
              height: 50,
              width: 239,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                  PreferenceHandler.saveId("user");
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(98)
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: ColorApp.kuning
                ),
                child: Teks.biasa("Mulai aja dulu!", fs: 16, fw: FontWeight.w500)
              ),
            ),
          ],
        ),
      ),
    );
  }
}