import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      // لا يؤثر هذا على الثيم العام للبرنامج
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Theme.of(context)
              .colorScheme
              .onPrimary, // لون النص داخل حقل البحث
        ),
      ),
      // تخصيص الـ TextField نفسه هنا
      appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onPrimary)),
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary, // تغيير لون الخلفية
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // إزالة الحدود
        ),
        hintStyle: const TextStyle(
          color: Colors.grey, // لون النص التلميحي (Hint)
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(
            Icons.arrow_back,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Scaffold(body: Center());
  }
}
