import 'package:app/l10n/app_localizations.dart';
import 'package:app/utils/profixStyles.dart';
import 'package:app/utils/profix_colors.dart';
import 'package:app/utils/profix_images.dart';
import 'package:flutter/material.dart';

import 'package:app/widgets/custom_eleveted_button.dart';


class ResetPassword extends StatelessWidget {
  static const  String routeName='resetPassword';

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ProfixColors.white,
      appBar: AppBar(
        backgroundColor: ProfixColors.white,
        title:  Text(AppLocalizations.of(context)!.forget_password,
        style: ProfixStyles.bold20Primary),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(ProfixImages.logo),
            SizedBox(height: height*0.02,),
            CustomElevatedButton(text: AppLocalizations.of(context)!.reSetPassword,onButtonClick: resetPassword,),
            SizedBox(height: height*0.02,),
          ],
        ),
      ),
    );
  }
  void resetPassword(){

  }
}
