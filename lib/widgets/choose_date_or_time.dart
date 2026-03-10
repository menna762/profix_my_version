import 'package:app/widgets/custom_text_Widget.dart' hide CustomTextWidget;
import 'package:app/utils/profixStyles.dart' hide ProfixStyles;
import 'package:flutter/material.dart';

import '../utils/profixStyles.dart';
import 'custom_text_Widget.dart';

class ChooseDateOrTime extends StatelessWidget {
  String iconName;
  String eventDateOrTime;
  String chooseDateOrTime;
  Function onChooseClick;
  ChooseDateOrTime({
    required this.iconName,
    required this.eventDateOrTime,
    required this.chooseDateOrTime,
    required this.onChooseClick
});

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(iconName),
        SizedBox(width: width*0.02,),
        CustomTextWidget(text: eventDateOrTime,
            textStyle: ProfixStyles.medium16black),
        Spacer(),
        InkWell(
          onTap: (){
            onChooseClick();
          },
          child: CustomTextWidget(text: chooseDateOrTime,
              textStyle: ProfixStyles.medium16black),
        )
      ],
    );
  }
}
