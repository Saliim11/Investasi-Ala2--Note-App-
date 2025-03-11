import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
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
            
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(98)
                ),
                foregroundColor: Colors.black,
                backgroundColor: ColorApp.kuning
              ),
              child: Teks.biasa("Mulai aja dulu")
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 239,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(98),
                color: ColorApp.kuning,

              ),
              child: Teks.biasa("Mulai aja dulu!", fs: 16, fw: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}