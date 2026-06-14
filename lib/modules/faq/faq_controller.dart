import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import 'faq_model.dart';

class FaqController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<FaqItem> faqList = <FaqItem>[].obs;
  RxList<FaqItem> filteredFaqs = <FaqItem>[].obs;
  RxList<String> categories = <String>[].obs;
  RxString selectedCategory = ''.obs;
  RxInt expandedIndex = (-1).obs;
  final searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await HttpHelper.gettData(url: 'content/faqs');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> items = data['data'] ?? [];
          faqList.value = items.map((e) => FaqItem.fromJson(e)).toList();
          _extractCategories();
          _applyFilter();
        } else {
          errorMessage.value = data['message'] ?? 'حدث خطأ ما';
        }
      } else {
        errorMessage.value = 'فشل جلب الأسئلة الشائعة';
      }
    } catch (e) {
      errorMessage.value = 'حدث خطأ أثناء الاتصال بالخادم';
      print('Error fetching FAQs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _extractCategories() {
    final Set<String> cats = {};
    for (var item in faqList) {
      cats.add(item.category);
    }
    categories.value = cats.toList();
  }

  void selectCategory(String category) {
    if (selectedCategory.value == category) {
      selectedCategory.value = '';
    } else {
      selectedCategory.value = category;
    }
    expandedIndex.value = -1;
    _applyFilter();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    expandedIndex.value = -1;
    _applyFilter();
  }

  void _applyFilter() {
    List<FaqItem> result = faqList.toList();

    if (selectedCategory.value.isNotEmpty) {
      result = result.where((f) => f.category == selectedCategory.value).toList();
    }

    if (searchQuery.value.isNotEmpty) {
      result = result
          .where((f) =>
              f.question.contains(searchQuery.value) ||
              f.answer.contains(searchQuery.value))
          .toList();
    }

    filteredFaqs.value = result;
  }

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
