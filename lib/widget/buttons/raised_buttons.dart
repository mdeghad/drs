import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:flutter/material.dart';

//stateless Widget for Common Raised Button
class RaisedButtons extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  RaisedButtons({@required this.text, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: CustomizedColors.signInButtonColor,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        padding: EdgeInsets.all(18.0),
        child: Text(
          text,
          style: TextStyle(
              color: CustomizedColors.signInButtonTextColor, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}


class RaisedBtn extends StatelessWidget {
  RaisedBtn(
      {@required this.text, @required this.onPressed, @required this.iconData});

  final IconData iconData;
  final String text;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: 350,
        height: 80,
        child:RaisedButton(
            color: CustomizedColors.raisedBtnColor,
            onPressed: onPressed,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    color: CustomizedColors.primaryColor,
                    size: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                            color: CustomizedColors.primaryColor, fontSize: 20),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ])
        )
    );
  }
}
