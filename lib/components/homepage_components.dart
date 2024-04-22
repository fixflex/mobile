import 'package:fix_flex/screens/search_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/categories_gridview.dart';
import '../widgets/sliver_appbar.dart';
import 'offers.dart';


class HomePageComponents extends StatelessWidget {
  HomePageComponents({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            //Sliver App Bar Widget
            SliverAppBarWidget(),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Search Box
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SearchScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Icon(
                                Icons.search,
                                size: 25.0,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            
                //Services Categories Text
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 20),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Services Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            
                //Categories Grid view
                CategoriesGridview(),
            
                //Offers Text
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Offers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            
                //Offers Container
                Offers(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}