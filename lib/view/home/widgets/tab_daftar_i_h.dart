import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:investasi_ala_ala/service/provider_handler.dart';
import 'package:investasi_ala_ala/utils/constant/color.dart';
import 'package:investasi_ala_ala/utils/widget_const/text.dart';
import 'package:provider/provider.dart';

class TabDaftarIH extends StatelessWidget {
  const TabDaftarIH({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InvestasiProvider>(context);
    int isInvestTab = provider.isInvestTab;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              provider.changeTab(0);
            },
            child: Container(
              alignment: Alignment.center,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                ),
                color: isInvestTab == 1 ? ColorApp.abu : ColorApp.oren,
                boxShadow: [
                  BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Colors.black.withOpacity(0.25))
                ]
              ),
              child: Teks.biasa("Investasi", fs: 12, fw: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              provider.changeTab(1);
            },
            child: Container(
              alignment: Alignment.center,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                color: isInvestTab == 0 ? ColorApp.abu : ColorApp.oren,
                boxShadow: [
                  BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Colors.black.withOpacity(0.25))
                ]
              ),
              child: Teks.biasa("Hutang", fs: 12, fw: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}