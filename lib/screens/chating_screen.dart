import 'package:fix_flex/components/chat/message_box.dart';
import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/chating_cubits/get_my_chats_cubit/get_my_chats_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/sliver_appbar.dart';

class ChatingScreen extends StatelessWidget {
  const ChatingScreen({
    super.key,
  });

  static const String id = 'ChatingScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  BlocBuilder<GetMyChatsCubit,GetMyChatsState>(
                    builder: (context,state){
                      final index = GetMyChatsCubit.get(context).index;
                      if(state is GetMyChatsSuccess){
                      return SliverAppBarWidget(
                        backgroundColor: kPrimaryColor,
                        icon: Icons.arrow_back,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        chatImage: state.chatsHolders[index].profilePicture?.url !=null? state.chatsHolders[index].profilePicture!.url  : kDefaultUserImage,
                        onTap: () async{
                          await GetUserDataCubit.get(context).getUserData(state.chatsHolders[index].uId);
                          await CheckPersonalInformationCubit.get(context).checkPersonalInformation(userId: state.myChatsDataModel[index].tasker);
                          Navigator.pushNamed(
                              context, PersonalInformationScreen.id);
                        },
                        title: state.chatsHolders[index].FirstName + ' ' + state.chatsHolders[index].LastName,
                      );
                    }return const SizedBox();
                    },
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
              ),
            ),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MessageBox(onSubmitted: (p0) {

      }, controller: TextEditingController()),
    );
  }
}