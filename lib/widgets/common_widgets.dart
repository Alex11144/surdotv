import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

Widget getVector(String fname, double h, double w) {
  return SvgPicture.asset(
    fname,
    height: h,
    width: w,
  );
}

Widget logo(double h, double w) {
  return SvgPicture.asset(
    'assets/images/logo.svg',
    height: h,
    width: w,
  );
}

final Widget logoMSizeWhite = SvgPicture.asset('assets/images/logo.svg',
    height: 25, width: 50, color: Colors.white);

final Widget logoMSize = getVector('assets/images/logo.svg', 25, 50);
final Widget logoLSize = getVector('assets/images/logo.svg', 55, 80);
final Widget vCamera = getVector('assets/images/videoCamera.svg', 35, 35);

final Widget svgMapPin = getVector('assets/images/pin.svg', 35, 35);
final Widget svgMail = getVector('assets/images/mail.svg', 35, 35);
final Widget svgShareNetwork =
    getVector('assets/images/shareNetwork.svg', 35, 35);

final Widget svgWhatsapp = getVector('assets/images/whatsappLogo.svg', 35, 35);
final Widget svgTwitter = getVector('assets/images/twitterLogo.svg', 35, 35);
final Widget svgFacebook = getVector('assets/images/facebookLogo.svg', 35, 35);

final Widget svgcartoon = getVector('assets/images/cartoon.svg', 35, 35);

final Widget logoMin = Image.asset('assets/images/logo_min.png');
final Widget logoFund = Image.asset('assets/images/logo_fond.png');

final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  padding: EdgeInsets.all(15),
  side: BorderSide(
    width: 1.0,
    color: Colors.red,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  primary: Colors.black,
);

final ButtonStyle redFilledButtonStyle = OutlinedButton.styleFrom(
  padding: EdgeInsets.all(15),
  backgroundColor: Colors.red,
  side: BorderSide(
    width: 1.0,
    color: Colors.red,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  primary: Colors.white,
);

Widget adsBlock(BuildContext ctx) {
  return Container(
    color: Theme.of(ctx).colorScheme.primary.withOpacity(0.2),
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        logoMin,
        logoFund,
      ],
    ),
  );
}

InputDecoration myInputDecoration(
    {String aHintText, IconData aSuffixIcon, String aErrortext = ''}) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    errorText: aErrortext != '' ? aErrortext : null,
    suffixIcon: aSuffixIcon != null ? Icon(aSuffixIcon) : null,
    hintText: aHintText,
    helperText: ' ',
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.blue, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey, width: 1),
    ),
  );
}

class TextButtonWithSubfixIconChild extends StatelessWidget {
  TextButtonWithSubfixIconChild({
    @required this.label,
    @required this.icon,
  });

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(child: label),
        SizedBox(width: 4),
        icon,
      ],
    );
  }
}
