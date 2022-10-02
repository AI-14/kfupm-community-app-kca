import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/buysell_screen_category.dart';
import '../../../utils/color_constants.dart';

class Categories extends StatelessWidget {
  final Size screenSize;
  final List<String> allCategories;
  const Categories(
      {Key? key, required this.screenSize, required this.allCategories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BuySellScreenCategoryProvider buySellCategoryProvider =
        Provider.of<BuySellScreenCategoryProvider>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: screenSize.height * 0.04,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: allCategories.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Consumer<BuySellScreenCategoryProvider>(
              builder: (context, provider, child) => Container(
                child: OutlinedButton(
                  onPressed: () {
                    buySellCategoryProvider.setIndex(index);
                    buySellCategoryProvider.setStream();
                  },
                  child: Text(
                    allCategories[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: provider.index == index
                            ? Colors.black
                            : Colors.white38),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 0.0, color: darkThemeColor),
                  ),
                ),
                decoration: BoxDecoration(
                  color: provider.index == index
                      ? Color(0xFFC9ECF8)
                      : darkThemeColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
