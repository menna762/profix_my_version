import 'package:flutter/material.dart';
import 'package:app/utils/profixStyles.dart';
import 'package:app/utils/profix_colors.dart';



class CusstomTextButton extends StatelessWidget {
 Function onButtonClicked;
 String text;
 TextAlign? textAlign;
CusstomTextButton({required this.onButtonClicked,required this.text,this.textAlign});
  @override
  Widget build(BuildContext context) {
    return  TextButton(onPressed: (){
    onButtonClicked();
    },
        child: RichText(text: TextSpan(
            text: text,style: ProfixStyles.bold16blue.copyWith(
            decorationColor: ProfixColors.lightBlue,
            decoration: TextDecoration.underline,

        )

        ),
            textAlign: textAlign??TextAlign.end,
          )
    );
  }
}
