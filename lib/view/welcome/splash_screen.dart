import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/service/pref_handler.dart';
import 'package:investasi_ala_ala/service/provider_handler.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:investasi_ala_ala/view/home/home_screen.dart';
import 'package:investasi_ala_ala/view/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3), () async{
      Future.microtask(() => 
        Provider.of<InvestasiProvider>(context, listen: false).getListInvestasi()
      );
      String id = await PreferenceHandler.getId();
      if (id.isEmpty || id == "") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }

    },);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.abu,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/image/chick1.png"),
            Teks.spesial("Investasi Ala-ala", fs: 40),
            SizedBox(height: 60,),
            
          ],
        ),
      ),
    );
  }
}