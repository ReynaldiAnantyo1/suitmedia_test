import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../user/controllers/user_controller.dart';

class ThirdScreen extends StatelessWidget {
  ThirdScreen({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF554AF0),
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Third Screen',
          style: TextStyle(
            color: Color(0XFF04021D),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE2E3E4), width: 1),
        ),
      ),
      body: Obx(() {
        if (userController.users.isEmpty && userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userController.users.isEmpty) {
          return const Center(
            child: Text('Empty State', style: TextStyle(fontSize: 18)),
          );
        }

        return RefreshIndicator(
          onRefresh: () => userController.fetchUsers(isRefresh: true),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!userController.isLoading.value &&
                  userController.hasMore &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                userController.fetchUsers();
                return true;
              }
              return false;
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              itemCount:
                  userController.users.length +
                  (userController.hasMore ? 1 : 0),
              separatorBuilder: (context, index) => const Divider(height: 30),
              itemBuilder: (context, index) {
                if (index == userController.users.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final user = userController.users[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF04021D),
                    ),
                  ),
                  subtitle: Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF686777),
                    ),
                  ),
                  onTap: () {
                    Get.back(result: '${user.firstName} ${user.lastName}');
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
