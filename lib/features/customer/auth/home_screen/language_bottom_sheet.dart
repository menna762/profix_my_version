import 'package:flutter/material.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/providers/language_provider.dart';
import 'package:app/utils/profix_colors.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<AppLanguageProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          InkWell(
            onTap: (){
              provider.changeLanguage("en");
            },
            child: provider.appLanguage=='en' ?
            getSelectdItemWidget(AppLocalizations.of(context)!.english):
                getUnSelectedItemWidget(AppLocalizations.of(context)!.english)
          ),
          SizedBox(height:15),
          InkWell(
            onTap: (){
              provider.changeLanguage("ar");
            },
              child:provider.appLanguage=='ar'?
                getSelectdItemWidget(AppLocalizations.of(context)!.arabic):
                  getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic),
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
