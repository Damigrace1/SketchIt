// import 'package:flutter/material.dart';

// Future<void> _showTextInputDialog() async {
//   String inputText = '';
//   await showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Add Text'),
//         content: TextField(
//           onChanged: (value) {
//             inputText = value;
//           },
//           decoration: InputDecoration(hintText: "Enter your text"),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Cancel'),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.pop(context);
//               _addTextToCanvas(inputText);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
