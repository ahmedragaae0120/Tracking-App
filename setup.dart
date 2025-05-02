import 'dart:io';

void main() {
  final setup = {
    "folders": [
      "lib/core/api",
      "lib/core/constants",
      "lib/core/Di",
      "lib/core/localization",
      "lib/core/services",
      "lib/core/theme",
      "lib/core/utils",
      "lib/data/data_source_contract",
      "lib/data/data_source_impl",
      "lib/data/model",
      "lib/data/repo_impl",
      "lib/domain/common",
      "lib/domain/model",
      "lib/domain/repo_contract",
      "lib/domain/use_cases",
      "lib/Shared/observer",
      "lib/Shared/widgets",
      "lib/ui/Auth",
      "lib/ui/all_exams_on_subject",
      "lib/ui/explorescreen",
      "lib/ui/Profile_Details",
      "lib/ui/resultsScreen",
      "lib/ui/start_exam",
      "assets/images",
      "assets/translations"
    ],
    "files": {
      "lib/main.dart":
          "import 'package:flutter/material.dart';\nvoid main() { runApp(MyApp()); }\n",
      "lib/my_app.dart":
          "import 'package:flutter/material.dart';\nclass MyApp extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return MaterialApp(home: Scaffold(body: Center(child: Text('Hello, Flutter!'))));\n  }\n}\n",
      "assets/translations/ar.json": "{\"hello\": \"مرحبا\"}",
      "assets/translations/en.json": "{\"hello\": \"Hello\"}"
    },
    "packages": ["flutter_bloc", "dio", "shared_preferences"]
  };
  if (setup["folders"] != null) {
    for (var folder in setup["folders"] as List<String>) {
      Directory(folder).createSync(recursive: true);
    }
  }

  if (setup["files"] != null) {
    for (var entry in (setup["files"] as Map<String, String>).entries) {
      File(entry.key).writeAsStringSync(entry.value);
    }
  }

  final pubspec = File("pubspec.yaml");
  if (pubspec.existsSync()) {
    pubspec.writeAsStringSync(
        "assets:\n  - assets/images/\n  - assets/translations/\n",
        mode: FileMode.append);
  }

  if (setup["packages"] != null && setup["packages"] is List<String>) {
    var packages = setup["packages"];
    if (packages is List<String> && packages.isNotEmpty) {
      Process.runSync("flutter", ["pub", "add", ...packages]);
    }
  }
  print("✅ المشروع جاهز! 🎉");
}
