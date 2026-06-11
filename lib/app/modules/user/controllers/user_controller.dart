import 'package:get/get.dart';
import 'dart:convert';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var isLoading = false.obs;

  int page = 1;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    fetchUsers(isRefresh: true);
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isLoading.value || (!hasMore && !isRefresh)) return;

    if (isRefresh) {
      page = 1;
      hasMore = true;
      users.clear();
    }

    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$page&per_page=10'),
        headers: {
          // Keep the headers exactly as requested by the test
          'x-api-key':
              'pro_6c6dda7cba5d8b7250c77a0059387ad4ee178af7cbcc0b0deee45dcdd58e3f24',
          'X-Reqres-Env': 'prod',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List newUsers = data['data'];

        if (newUsers.isEmpty) {
          hasMore = false;
        } else {
          users.addAll(newUsers.map((e) => UserModel.fromJson(e)).toList());
          page++;
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch users. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
