
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/language_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../utils/profix_colors.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var languageProvider =Provider.of<AppLanguageProvider>(context);
    var themeProvider =Provider.of<AppThemeProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          InkWell(
            onTap: (){
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.isDarkTheme() ?
            getSelectdItemWidget(AppLocalizations.of(context)!.dark):
                getUnSelectedItemWidget(AppLocalizations.of(context)!.dark)
          ),
          SizedBox(height:15),
          InkWell(
            onTap: (){
              themeProvider.changeTheme(ThemeMode.light);
            },
              child:themeProvider.appTheme==ThemeMode.light?
                getSelectdItemWidget(AppLocalizations.of(context)!.light):
                  getUnSelectedItemWidget(AppLocalizations.of(context)!.light),
          )

        ],
      ),
    );
  }

  Widget getSelectdItemWidget(String text){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,style:
        Theme.of(context).textTheme.headlineLarge,),
        Icon(Icons.check,color: ProfixColors.lightBlue,size: 30,)
      ],
    );
  }
  Widget getUnSelectedItemWidget(String text){

     return Text(text,style:
    Theme.of(context).textTheme.headlineLarge,);
  }
}
