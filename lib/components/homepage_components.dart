import 'package:fix_flex/cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:fix_flex/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/constants.dart';
import '../cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import '../helper/secure_storage/secure_keys/secure_variable.dart';
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
            BlocBuilder<GetMyDataCubit, GetMyDataState>(
              builder: (context, state) {
                return SliverAppBarWidget(
                  onTap: () {
                    CheckPersonalInformationCubit.get(context)
                        .checkPersonalInformation(state is GetMyDataSuccess
                            ? state.myDataList[0].uId
                            : '');
                    Navigator.pushNamed(context, PersonalInformationScreen.id);
                  },
                  title: state is GetMyDataSuccess ? state.myDataList[0].role == 'USER'? SecureVariables.role == 'user'?'USER': 'TASKER':'ADMIN':'USER',
                  icon: Icons.menu,
                  iconSize: 40,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  image: state is GetMyDataSuccess
                      ? state.myDataList[0].profilePicture?.url != null
                          ? state.myDataList[0].profilePicture!.url as String
                          : kDefaultUserImage
                      : kDefaultUserImage,
                );
              },
            ),
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
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
