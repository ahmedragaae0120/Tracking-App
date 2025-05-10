// import 'package:flutter/material.dart';
//
// import '../utils/string_manager.dart';
//
// class Dialogs {
// //========USAGE=========\\
// //   if (isGuestUser) {
// //   Dialogs.showGuestRestrictionDialog(context);
// // } else {
//   // تابع تنفيذ العملية المسموحة
// // } or in widgets        isGuestUser ? Dialogs.showGuestRestrictionDialog(context) : performAllowedOperation();
//
//   static void restrictedAccess(BuildContext context, VoidCallback backButton) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => PopScope(
//         canPop: false,
//         child: AlertDialog(
//             backgroundColor: Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             alignment: Alignment.center,
//             title: Row(
//               children: [
//                 const Icon(Icons.lock_outline, color: Colors.redAccent),
//                 const SizedBox(width: 10),
//                 Text(AppStrings.restrictedAccess,
//                     style: const TextStyle(fontSize: 18)),
//               ],
//             ),
//             content: Text(
//               AppStrings.guestRestrictionMessage,
//               style: TextStyle(color: Theme.of(context).colorScheme.secondary),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: backButton,
//                 child: Text(AppStrings.back,
//                     style: const TextStyle(color: Colors.grey)),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamedAndRemoveUntil(
//                       context, RouteManager.loginScreen, (route) => false);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).primaryColor,
//                 ),
//                 child: Text(AppStrings.login,
//                     style: Theme.of(context).textTheme.labelLarge),
//               ),
//             ]),
//       ),
//     );
//   }
//
//   static void confirmLogout(BuildContext context, VoidCallback cancelButton,
//       VoidCallback logoutButton) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => PopScope(
//         canPop: false,
//         child: AlertDialog(
//             backgroundColor: Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             alignment: Alignment.center,
//             title: Center(
//               child: Text(AppStrings.logout,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.w600)),
//             ),
//             content: Text(
//               textAlign: TextAlign.center,
//               AppStrings.confirmLogout,
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
//             ),
//             actionsAlignment: MainAxisAlignment.spaceAround,
//             actions: [
//               OutlinedButton(
//                 onPressed: cancelButton,
//                 child: Text(AppStrings.cancel,
//                     style: const TextStyle(color: Colors.grey)),
//               ),
//               // TextButton(
//               //   onPressed: cancelButton,
//               //   child: Text(AppStrings.cancel,
//               //       style: const TextStyle(color: Colors.grey)),
//               // ),
//               ElevatedButton(
//                 onPressed: logoutButton,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).primaryColor,
//                 ),
//                 child: Text(AppStrings.logout,
//                     style: Theme.of(context).textTheme.labelLarge),
//               ),
//             ]),
//       ),
//     );
//   }
// }
