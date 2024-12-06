import 'package:flutter/material.dart';
import 'package:test_prep/modules/home/c_home.dart';
import 'package:get/get.dart';
import 'package:test_prep/modules/home/w_user_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: controller.xFetching,
          builder: (context, xFetching, child) {
            if (xFetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ValueListenableBuilder(
                valueListenable: controller.userList,
                builder: (context, userList, child) {
                  if (userList.isEmpty) {
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
                },
              );
            }
          },
        ),
      ),
    );
  }
}
