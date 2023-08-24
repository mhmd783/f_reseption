
// import 'dart:typed_data';


// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';
// import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

// import '../client/client.dart';

// class mange extends GetxController {
//   clie? clientmodel;
//   List<String> logs = [];
//   int port = 8080;
//   Stream<NetworkAddress>? stream;
//   NetworkAddress? address;
//   int n = 0;
//   @override
//   void onInit() {
    
//     getIpAddress();
    
//     super.onInit();
//   }

//   getIpAddress() async {
//     stream = NetworkAnalyzer.discover("192.168.1",port);
//     //final ipAddress = InternetAddress('192.168.1.3');
//     stream!.listen((NetworkAddress networkAddress) {
//       if (networkAddress.exists) {
//         address = networkAddress;
//         clientmodel = clie(
//             hostName: "${address!.ip}",
//             onData: onData,
//             onError: onError,
//             port: port);
//       }
//       print(stream);
//     });

//     update();
//   }

//   void sendMessage(String message) {
//     clientmodel!.write(message);
//   }

//   onData(Uint8List data) {
//     final message = String.fromCharCodes(data);
//     logs.add(message);
//     print(message);
//     update();
//   }

//   onError(dynamic error) {
//     debugPrint("Error: $error");
//   }
// }
// //http://localhost/pfa/refreshtime.php