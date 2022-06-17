part of 'R.dart';

class _Dimens {
  double navBarHeight(BuildContext context) {
    if (isTablet(context))
      return 54;
    else
      return 68;
  }

  double gutterWidth(BuildContext context) {
    if (isMobile(context))
      return 14.0;
    else if (isTablet(context))
      return 26.0;
    else if (isLaptop(context))
      return 60.0;
    else
      return 80;
  }

  double bodyGutterWidth(BuildContext context) {
    return (isMobile(context)
            ? 14
            : screenWidth(context) / (isTablet(context) ? 18 : 14)) +
        gutterWidth(context);
  }

  double bodyTopPadding(BuildContext context) {
    return isTablet(context) ? 40 : 100;
  }

  Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  double screenHeight(BuildContext context) => screenSize(context).height;

  double screenWidth(BuildContext context) => screenSize(context).width;

  bool isMobile(BuildContext context) =>
      screenWidth(context).toInt() <= breakPoints.keys.first;

  bool isTablet(BuildContext context) =>
      screenWidth(context).toInt() <= breakPoints.keys.elementAt(1);

  bool isLaptop(BuildContext context) =>
      screenWidth(context).toInt() <= breakPoints.keys.elementAt(2);

  bool isDeskTop(BuildContext context) =>
      screenWidth(context).toInt() <= breakPoints.keys.elementAt(3);

  double heroHeightLarge(BuildContext context) {
    var _screenHeight = screenHeight(context);
    var _screenWidth = screenWidth(context);
    return (_screenHeight < _screenWidth || R.dimens.isMobile(context)
            ? _screenHeight
            : isTablet(context)
                ? screenHeight(context) * 0.8
                : _screenHeight / 2) -
        R.dimens.navBarHeight(context);
  }

  double heroHeightSmall(BuildContext context) {
    return R.dimens.screenHeight(context) / (isTablet(context) ? 2.5 : 2);
  }

  double sectionSpace(BuildContext context) => isMobile(context)
      ? 90
      : isTablet(context)
          ? 120
          : 220;

  ///Map<Width,Height>
  Map<int, int> breakPoints = {
    411: 731, //Mobile
    768: 1024, //TabLet
    1366: 768, //Laptop
    1920: 1080, //Desktop or High res Laptop
  };
}
