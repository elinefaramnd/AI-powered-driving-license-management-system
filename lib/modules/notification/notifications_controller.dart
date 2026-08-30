import 'dart:convert';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import 'notification_model.dart';

class NotificationsController extends GetxController {
  final notifications = <NotificationModel>[].obs;
  final unreadNotifications = <NotificationModel>[].obs;
  final unreadCount = 0.obs;
  final loading = false.obs;
  final loadingMore = false.obs;
  int currentPage = 1;
  int lastPage = 1;
  int unreadCurrentPage = 1;
  int unreadLastPage = 1;
  final selectedTab = 0.obs;
  bool get hasMore {
    if (selectedTab.value == 0) {
      return currentPage < lastPage;
    } else {
      return unreadCurrentPage < unreadLastPage;
    }
  }
  @override
  void onInit() {
    super.onInit();
    loadNotifications();
    loadUnreadCount();
  }
  Future<void> changeTab(int index) async {
    if (selectedTab.value == index) return;
    selectedTab.value = index;
    if (index == 0) {
      if (notifications.isEmpty) {
        await loadNotifications();
      }
    } else {
      if (unreadNotifications.isEmpty) {
        await loadUnreadNotifications();
      }
    }
  }
  Future<void> loadNotifications({bool refresh = true}) async {
    if (loading.value || loadingMore.value) return;
    if (refresh) {
      loading.value = true;
      currentPage = 1;
    } else {
      if (currentPage >= lastPage) return;
      loadingMore.value = true;
    }
    try {
      final page = refresh ? 1 : currentPage + 1;
      final response = await HttpHelper.gettData(
        url: "notifications?page=$page&per_page=20",
      );
      if (response.statusCode != 200) {
        print("LOAD NOTIFICATIONS ERROR: ${response.statusCode}");
        return;
      }
      final data = jsonDecode(response.body);
      final result = data["data"];
      final items = (result["items"] as List)
          .map(
            (item) =>
                NotificationModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
      final pagination = result["pagination"];
      if (refresh) {
        notifications.assignAll(items);
      } else {
        notifications.addAll(items);
      }
      currentPage = pagination["current_page"] ?? page;
      lastPage = pagination["last_page"] ?? currentPage;
    } catch (e) {
      print("NOTIFICATIONS ERROR: $e");
    } finally {
      loading.value = false;
      loadingMore.value = false;
    }
  }
  Future<void> loadUnreadNotifications({bool refresh = true}) async {
    if (loading.value || loadingMore.value) return;
    if (refresh) {
      loading.value = true;
      unreadCurrentPage = 1;
    } else {
      if (unreadCurrentPage >= unreadLastPage) return;
      loadingMore.value = true;
    }
    try {
      final page = refresh ? 1 : unreadCurrentPage + 1;
      final response = await HttpHelper.gettData(
        url: "notifications?page=$page&per_page=20&unread_only=1",
      );
      if (response.statusCode != 200) {
        print("LOAD UNREAD NOTIFICATIONS ERROR: ${response.statusCode}");
        return;
      }
      final data = jsonDecode(response.body);
      final result = data["data"];
      final items = (result["items"] as List)
          .map(
            (item) =>
                NotificationModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
      final pagination = result["pagination"];
      if (refresh) {
        unreadNotifications.assignAll(items);
      } else {
        unreadNotifications.addAll(items);
      }
      unreadCurrentPage = pagination["current_page"] ?? page;
      unreadLastPage = pagination["last_page"] ?? unreadCurrentPage;
    } catch (e) {
      print("UNREAD NOTIFICATIONS ERROR: $e");
    } finally {
      loading.value = false;
      loadingMore.value = false;
    }
  }
  Future<void> loadUnreadCount() async {
    try {
      final response = await HttpHelper.gettData(
        url: "notifications/unread-count",
      );
      if (response.statusCode != 200) {
        print("UNREAD COUNT STATUS: ${response.statusCode}");
        return;
      }
      final data = jsonDecode(response.body);
      final result = data["data"];
      if (result is Map) {
        unreadCount.value = result["unread_count"] ?? 0;
      }
    } catch (e) {
      print("UNREAD COUNT ERROR: $e");
    }
  }
  Future<void> markAsRead(NotificationModel notification) async {
    if (notification.isRead) return;
    try {
      final response = await HttpHelper.putData(
        url: "notifications/${notification.id}/read",
        body: {},
      );
      if (response.statusCode != 200) {
        print("MARK READ STATUS: ${response.statusCode}");
        return;
      }
      final index = notifications.indexWhere(
        (item) => item.id == notification.id,
      );
      if (index != -1) {
        final old = notifications[index];
        notifications[index] = NotificationModel(
          id: old.id,
          title: old.title,
          body: old.body,
          type: old.type,
          readAt: DateTime.now().toIso8601String(),
          isRead: true,
          data: old.data,
          createdAt: old.createdAt,
        );
      }
      unreadNotifications.removeWhere((item) => item.id == notification.id);
      if (unreadCount.value > 0) {
        unreadCount.value--;
      }
    } catch (e) {
      print("MARK READ ERROR: $e");
    }
  }
  Future<void> markAllAsRead() async {
    if (unreadCount.value == 0) return;
    try {
      final response = await HttpHelper.putData(
        url: "notifications/read-all",
        body: {},
      );
      if (response.statusCode != 200) {
        print("READ ALL STATUS: ${response.statusCode}");
        return;
      }
      notifications.value = notifications.map((notification) {
        return NotificationModel(
          id: notification.id,
          title: notification.title,
          body: notification.body,
          type: notification.type,
          readAt: notification.readAt ?? DateTime.now().toIso8601String(),
          isRead: true,
          data: notification.data,
          createdAt: notification.createdAt,
        );
      }).toList();
      unreadNotifications.clear();
      unreadCount.value = 0;
    } catch (e) {
      print("READ ALL ERROR: $e");
    }
  }
}
