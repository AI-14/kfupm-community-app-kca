import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/providers/buysell_screen_category.dart';
import 'package:kfupm_community_app/screens/buysell/widgets/categories.dart';
import 'package:kfupm_community_app/screens/buysell/widgets/item_card.dart';
import 'package:kfupm_community_app/screens/buysell/widgets/sell_product_page.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

class BuySellScreen extends StatelessWidget {
  BuySellScreen({Key? key}) : super(key: key);


  final List<String> categories = [
    'All',
    'Furniture',
    'Clothing',
    'Electronics',
    'Perfumes',
    'Decoration',
    'Books',
    'Sports',
    'Others'
  ];

  void navigateToAddProductPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SellProductPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkThemeColor,
      appBar: AppBar(
        elevation: 0,
        shadowColor: darkThemeColor,
        automaticallyImplyLeading: false,
        backgroundColor: darkThemeColor,
        title: Text(
          'Buy-Sell',
          style: TextStyle(
            color: Color(0xFFC9ECF8),
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Categories(screenSize: screenSize, allCategories: categories),
          SizedBox(
            height: 25,
          ),
          // Grid view of Itemcards.
          Consumer<BuySellScreenCategoryProvider>(
            builder: (context, provider, child) => StreamBuilder(
                stream: provider.stream,
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          'Could not load product posts in the grid! Try again.'),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text('Oops! No products available.'),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.80,
                        mainAxisSpacing: 40.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) =>
                          ItemCard(data: snapshot.data!.docs[index]),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddProductPage(context);
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: primaryColor,
      ),
    );
  }
}
