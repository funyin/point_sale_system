import 'dart:ui';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:point_sale_system/resources/R.dart';

class PointSaleSystem extends StatelessWidget {
  PointSaleSystem({Key? key}) : super(key: key);

  var containerDecoration = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.black26.withAlpha(20),
            offset: Offset(0, 4),
            blurRadius: 16)
      ],
      borderRadius: BorderRadius.circular(10));

  var tabTitles = ["All Items", "Food", "Alcohol", "Cold Drinks", "Hot Drinks"];

  late BuildContext mContext;

  bool get showDrawer => R.dimens.screenWidth(mContext) < 1075;

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Scaffold(
      endDrawer: R.dimens.screenWidth(context) < 1075
          ? Drawer(
              child: sideBar(),
            )
          : null,
      body: Theme(
        data: ThemeData(
            textTheme: GoogleFonts.rubikTextTheme()
                .apply(bodyColor: R.colors.textColor)),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: mainBody(),
            ),
            if (!showDrawer) Expanded(flex: 2, child: sideBar()),
          ],
        ),
      ),
    );
  }

  EdgeInsets get mainPadding {
    var isMobile = R.dimens.isMobile(mContext);
    return EdgeInsets.all(isMobile ? 24 : 30)
        .copyWith(bottom: isMobile ? 16 : 22);
  }

  Widget mainBody() {
    var selectedTab = ValueNotifier(0);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
            padding: mainPadding,
            color: R.colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Simon's BBQ Team",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: 8),
                          Text("Location ID# SIMON123")
                        ],
                      ),
                    ),
                    if (constraints.maxWidth > 420)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Last Synced",
                            style: TextStyle(
                                color: R.colors.greyLight, fontSize: 12),
                          ),
                          SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff27c358)),
                              ),
                              SizedBox(width: 10),
                              Text("3 mins ago",
                                  style: TextStyle(fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                    if (constraints.maxWidth > 490)
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: buildButton(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.help_outline_rounded, size: 24),
                            SizedBox(width: 4),
                            Text("Help")
                          ],
                        )),
                      ),
                    if (showDrawer)
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: buildButton(
                            child: Icon(LineIcons.shoppingCart, size: 24),
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                            }),
                      ),
                  ],
                ),
                SizedBox(height: 35),
                Expanded(
                  child: DefaultTabController(
                      length: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            isScrollable: true,
                            onTap: (index) => selectedTab.value = index,
                            tabs: List.generate(
                                tabTitles.length,
                                (index) => Tab(
                                      text: tabTitles[index],
                                    )),
                            unselectedLabelColor: R.colors.textColor,
                            labelPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 24),
                            indicator: BoxDecoration(
                                color: R.colors.orange,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: ValueListenableBuilder<int>(
                                valueListenable: selectedTab,
                                builder: (context, value, child) {
                                  return Container(
                                    width: double.infinity,
                                    child: Scrollbar(
                                      child: SingleChildScrollView(
                                        child: LayoutBuilder(
                                          builder: (context, constraints) =>
                                              Wrap(
                                            runSpacing: 26,
                                            spacing: 24,
                                            children: List.generate(
                                                9,
                                                (index) => itemProduct(
                                                    index, value, constraints)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      )),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    var firstChild = Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WRISTBAND INFORMATION",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 14),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Container(
                                    width: 58,
                                    height: 58,
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 2))
                                    ])),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    faker.image.image(
                                        keywords: ["person"],
                                        height: 80,
                                        width: 80),
                                    width: 58,
                                    height: 58,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Eleanor Rusell",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          colors: [
                                            R.colors.orange,
                                            R.colors.pink,
                                            R.colors.purple
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight)),
                                  child: Text(
                                    "VIP TICKET HOLDER",
                                    style: TextStyle(
                                        color: R.colors.white, fontSize: 10),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 60),
                            if (constraints.maxWidth < 722)
                              Expanded(child: Container()),
                            if (constraints.maxWidth > 387)
                              SizedBox(
                                height: 58,
                                width: 98,
                                child: buildButton(
                                    background: R.colors.pink,
                                    child: Text(
                                      "Unlink",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                          ],
                        )
                      ],
                    );
                    var secondChild = Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "SELECT AVAILABLE PROMO TO APPLY",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              child: Text(
                                "(LIMIT 1 PER ORDER)",
                                maxLines: 2,
                                style: TextStyle(
                                    color: R.colors.greyLight,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          height: 58,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                          colors: [
                                            R.colors.orange,
                                            R.colors.pink,
                                            R.colors.purple
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight)),
                                  child: buildButton(
                                      background: R.colors.white,
                                      child: Text(
                                        "\$5 Off Any Item",
                                        maxLines: 2,
                                      )),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Expanded(
                                  flex: 5,
                                  child: buildButton(
                                      child:
                                          Text("Free Beverage", maxLines: 2))),
                              Expanded(child: SizedBox()),
                              Expanded(
                                  flex: 5,
                                  child: buildButton(
                                      child: Text("20% Off Entire Order",
                                          maxLines: 2))),
                            ],
                          ),
                        )
                      ],
                    );
                    var page = ValueNotifier(0);
                    if (constraints.maxWidth < 722)
                      return Container(
                        height: 135,
                        decoration: containerDecoration,
                        padding: EdgeInsets.all(16).copyWith(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: PageView(
                                onPageChanged: (index) => page.value = index,
                                children: [firstChild, secondChild],
                              ),
                            ),
                            SizedBox(height: 7),
                            ValueListenableBuilder<int>(
                                valueListenable: page,
                                builder: (context, value, child) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        2,
                                        (index) => AnimatedContainer(
                                              width: constraints.maxWidth / 2.8,
                                              height: 4,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 6, horizontal: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: index == value
                                                      ? R.colors.pink
                                                          .withAlpha(100)
                                                      : R.colors.btnGrey),
                                              duration:
                                                  Duration(milliseconds: 200),
                                            )),
                                  );
                                })
                          ],
                        ),
                      );

                    return Container(
                        decoration: containerDecoration,
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            firstChild,
                            SizedBox(
                              height: 62,
                              child: VerticalDivider(
                                width: 52,
                                color: R.colors.btnGrey,
                                thickness: 2,
                              ),
                            ),
                            Expanded(
                              child: secondChild,
                            )
                          ],
                        ));
                  },
                )
              ],
            ));
      },
    );
  }

  Widget itemProduct(
      int index, int selectedTabIndex, BoxConstraints constraints) {
    var isMobile = R.dimens.isMobile(mContext);
    var dishImage = ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          faker.image.image(
              random: true,
              keywords: [
                selectedTabIndex == 0 ? "meal" : tabTitles[selectedTabIndex],
                if (selectedTabIndex == 3 || selectedTabIndex == 4) "drink"
              ],
              height: 100,
              width: 100),
          width: 90,
          height: 90,
        ));
    return Container(
      width: constraints.maxWidth > 432
          ? (constraints.maxWidth > 714
              ? constraints.maxWidth / 3.3
              : constraints.maxWidth / 2.2)
          : constraints.maxWidth / 1.029,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      decoration: BoxDecoration(
          border: Border.all(color: R.colors.btnGrey, width: 2),
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  faker.food.dish(),
                  maxLines: 1,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: !isMobile ? 8 : 4),
                Text("${faker.randomGenerator.integer(200, min: 4)}g",
                    style: TextStyle(
                        color: Color(0xffd5d7dc),
                        fontSize: 15,
                        fontWeight: FontWeight.w800)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "\$${faker.randomGenerator.decimal(min: 1, scale: 15).toStringAsPrecision(3)}",
                        maxLines: 1,
                        style: TextStyle(
                            color: R.colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (!isMobile) dishImage
                  ],
                )
              ],
            ),
          ),
          if (isMobile) dishImage
        ],
      ),
    );
  }

  Container sideBar() {
    var screenHeight = R.dimens.screenHeight(mContext);
    return Container(
        color: R.colors.grey,
        child: SingleChildScrollView(
          padding: mainPadding,
          child: SizedBox(
            height: screenHeight < 730 ? 730 : screenHeight,
            child: Column(
              children: [
                SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, constraints) => Row(
                    children: [
                      Text(
                        "Current Order",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: SizedBox(width: 2)),
                      if (constraints.maxWidth > 292)
                        buildButton(
                            background: R.colors.pink.withAlpha(20),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                "Clear All",
                                style: TextStyle(color: R.colors.pink),
                              ),
                            )),
                      SizedBox(width: 10),
                      buildButton(
                          equalPadding: true,
                          child: Icon(
                              constraints.maxWidth > 292
                                  ? Icons.settings_outlined
                                  : Icons.more_horiz,
                              color: R.colors.textColor))
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        bottom: 1,
                        left: 1,
                        right: 1,
                        child: ListView.separated(
                            itemBuilder: (context, index) => itemCart(),
                            padding: EdgeInsets.only(bottom: 100),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 24,
                                ),
                            itemCount: 10),
                      ),
                      Positioned(
                          height: 100,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: IgnorePointer(
                            ignoring: true,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    R.colors.grey,
                                    R.colors.grey.withOpacity(0.0)
                                  ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter)),
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: containerDecoration,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(children: [
                          buildPriceBreakDown("Subtotal", "\$35.25"),
                          buildPriceBreakDown("Discounts", "-\$5.00"),
                          /*to leave some room for the cart list*/
                          // buildPriceBreakDown("Sales Tax", "\$2.25"),
                        ]),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            Text("\$37.50",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w900))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: containerDecoration,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CASHLESS CREDIT",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w800),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 4),
                            child: Text(
                              "\$32.50",
                              maxLines: 1,
                              style: TextStyle(
                                color: R.colors.orange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Available",
                            style: TextStyle(
                                color: R.colors.greyLight, fontSize: 12),
                          )
                        ],
                      ),
                      SizedBox(
                          height: 54,
                          width: 90,
                          child:
                              buildButton(onTap: () {}, child: Text("Cancel")))
                    ],
                  ),
                ),
                SizedBox(height: 18),
                SizedBox(
                  height: 58,
                  width: double.infinity,
                  child: buildButton(
                      background: R.colors.orange,
                      onTap: () {},
                      child: Text(
                        "Pay with Cashless Credit",
                        style: TextStyle(color: R.colors.white),
                      )),
                ),
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Balance Due"), Text("\$5.00")],
                )
              ],
            ),
          ),
        ));
  }

  Padding buildPriceBreakDown(String title, String price) {
    var textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textStyle.copyWith(fontSize: 14)),
          Text(
            price,
            style: textStyle,
          )
        ],
      ),
    );
  }

  Widget itemCart() {
    var count = ValueNotifier(faker.randomGenerator.integer(11, min: 1));
    return LayoutBuilder(
      builder: (context, constraints) {
        var amount = Text("\$13.50", maxLines: 1, textAlign: TextAlign.end);
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                  faker.image.image(
                      keywords: ["food"],
                      width: 100,
                      random: true,
                      height: 100),
                  width: 50,
                  height: 50),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: Text(
                faker.food.dish(),
                maxLines: 2,
              ),
            ),
            Expanded(child: Container()),
            Expanded(
              flex: 6,
              child: ValueListenableBuilder<int>(
                  valueListenable: count,
                  builder: (context, value, child) {
                    var deletable = value == 1;
                    return Column(
                      crossAxisAlignment: constraints.maxWidth < 292
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (constraints.maxWidth < 292) amount,
                        Row(
                          mainAxisAlignment: constraints.maxWidth < 292
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            buildQuantityBtn(
                                onTap: () {
                                  if (value != 1) count.value--;
                                },
                                icon: deletable
                                    ? LineIcons.trash
                                    : LineIcons.minus,
                                deletable: deletable,
                                constraints: constraints),
                            SizedBox(
                              width: 40,
                              height: 24,
                              child: FittedBox(
                                child: Text("${value}"),
                              ),
                            ),
                            buildQuantityBtn(
                                icon: LineIcons.plus,
                                onTap: () => count.value++,
                                constraints: constraints),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
            if (constraints.maxWidth > 292)
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: amount,
              )
          ],
        );
      },
    );
  }

  Widget buildQuantityBtn(
      {IconData icon = LineIcons.minus,
      VoidCallback? onTap,
      bool deletable = false,
      BoxConstraints? constraints}) {
    var btnSize = R.dimens.screenWidth(mContext) > 1300 ? 46.0 : 34;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: btnSize as double?,
        width: btnSize as double?,
        padding: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: deletable ? R.colors.pink : R.colors.btnGrey),
        child: Icon(icon, size: 20, color: deletable ? Colors.white : null),
      ),
    );
  }

  Widget buildButton(
      {Widget? child,
      Color? background,
      bool equalPadding = false,
      VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: equalPadding ? 8 : 12, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: background ?? R.colors.btnGrey,
            borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
}
