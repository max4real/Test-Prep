import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_prep/modules/home/c/c_home.dart';
import 'package:test_prep/modules/home/w/w_user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.xFetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (controller.userList.isEmpty) {
                return const Center(
                  child: Text(
                    'No Data Yet!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              } else {
                final userList = controller.userList;
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      user: userList[index],
                      onPress: () {
                        controller.goToUrl(userList[index].website);
                      },
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
