// import 'package:flutter/material.dart';
//
// import '../services/port_scanner_service.dart';
//
// class DeviceDetailsScreen extends StatefulWidget {
//   final String ipAddress;
//
//   const DeviceDetailsScreen({
//     super.key,
//     required this.ipAddress,
//   });
//
//   @override
//   State<DeviceDetailsScreen> createState() =>
//       _DeviceDetailsScreenState();
// }
//
// class _DeviceDetailsScreenState
//     extends State<DeviceDetailsScreen> {
// final PortScannerService _portScannerService =
// PortScannerService();
//
// List<int> openPorts = [];
//
// bool isScanning = false;
//
// String status = 'Ready to scan ports';
//
// Future<void> scanPorts() async {
// setState(() {
// isScanning = true;
// openPorts = [];
// status = 'Scanning ports...';
// });
//
// try {
// final result =
// await _portScannerService.scanPorts(
// widget.ipAddress,
// );
//
// if (!mounted) return;
//
// setState(() {
// openPorts = result;
// isScanning = false;
//
// if (openPorts.isEmpty) {
// status = 'No open ports found';
// } else {
// status =
// '${openPorts.length} open port(s) found';
// }
// });
// } catch (e) {
// if (!mounted) return;
//
// setState(() {
// isScanning = false;
// status = 'Scan failed';
// });
// }
// }
//
// String getServiceName(int port) {
// switch (port) {
// case 21:
// return 'FTP';
//
// case 22:
// return 'SSH';
//
// case 23:
// return 'Telnet';
//
// case 25:
// return 'SMTP';
//
// case 53:
// return 'DNS';
//
// case 80:
// return 'HTTP';
//
// case 110:
// return 'POP3';
//
// case 139:
// return 'NetBIOS';
//
// case 143:
// return 'IMAP';
//
// case 443:
// return 'HTTPS';
//
// case 445:
// return 'SMB';
//
// case 3389:
// return 'RDP';
//
//   case 8080:
//     return 'HTTP(Test Server)';
//
// default:
// return 'Unknown';
// }
// }
//
// @override
// Widget build(BuildContext context) {
// return Scaffold(
// appBar: AppBar(
// title: const Text(
// 'Device Details',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
//
// body: Padding(
// padding: const EdgeInsets.all(20),
//
// child: Column(
// children: [
// const Icon(
// Icons.computer,
// size: 80,
// color: Colors.blueAccent,
// ),
//
// const SizedBox(height: 15),
//
// const Text(
// 'Selected Device',
// style: TextStyle(
// fontSize: 24,
// fontWeight: FontWeight.bold,
// ),
// ),
//
// const SizedBox(height: 10),
//
// Text(
// widget.ipAddress,
// style: const TextStyle(
// fontSize: 18,
// color: Colors.white70,
// ),
// ),
//
// const SizedBox(height: 25),
//
// SizedBox(
// width: double.infinity,
// height: 55,
//
// child: ElevatedButton.icon(
// onPressed:
// isScanning ? null : scanPorts,
//
// icon: isScanning
// ? const SizedBox(
// width: 20,
// height: 20,
// child:
// CircularProgressIndicator(
// strokeWidth: 2,
// ),
// )
// : const Icon(Icons.security),
//
// label: Text(
// isScanning
// ? 'Scanning...'
// : 'Scan Open Ports',
// style: const TextStyle(
// fontSize: 17,
// ),
// ),
// ),
// ),
//
// const SizedBox(height: 20),
//
// Text(
// status,
// textAlign: TextAlign.center,
// style: const TextStyle(
// color: Colors.white60,
// ),
// ),
//
// const SizedBox(height: 20),Expanded(
//     child: openPorts.isEmpty
//         ? const Center(
//       child: Text(
//         'No open ports found',
//         style: TextStyle(
//           color: Colors.white54,
//           fontSize: 16,
//         ),
//       ),
//     )
//         : ListView.builder(
//       itemCount: openPorts.length,
//
//       itemBuilder:
//           (context, index) {
//         final port =
//         openPorts[index];
//
//         return Card(
//           margin:
//           const EdgeInsets.only(
//             bottom: 12,
//           ),
//
//           child: ListTile(
//             leading:
//             const CircleAvatar(
//               child: Icon(
//                 Icons
//                     .lan,
//               ),
//             ),
//
//             title: Text(
//               'Port $port',
//               style:
//               const TextStyle(
//                 fontWeight:
//                 FontWeight
//                     .bold,
//               ),
//             ),
//
//             subtitle: Text(
//               getServiceName(
//                 port,
//               ),
//             ),
//
//             trailing:
//             const Icon(
//               Icons
//                   .warning_amber,
//               color:
//               Colors.orange,
//             ),
//           ),
//         );
//       },
//     ),
//   ),
// ],
// ),
// ),
// );
// }
// }

import 'package:flutter/material.dart';

import '../services/port_scanner_service.dart';

class DeviceDetailsScreen extends StatefulWidget {
  final String ipAddress;

  const DeviceDetailsScreen({
    super.key,
    required this.ipAddress,
  });

  @override
  State<DeviceDetailsScreen> createState() =>
      _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState
    extends State<DeviceDetailsScreen> {
final PortScannerService _portScannerService =
PortScannerService();

List<PortScanResult> openPorts = [];

bool isScanning = false;

String status = 'Ready to scan ports';

Future<void> scanPorts() async {
setState(() {
isScanning = true;
openPorts = [];
status = 'Scanning ports...';
});

try {
final results =
await _portScannerService.scanPorts(
widget.ipAddress,
);

if (!mounted) return;

setState(() {
openPorts = results;
isScanning = false;

if (openPorts.isEmpty) {
status = 'No open ports found';
} else {
status =
'${openPorts.length} open port(s) found';
}
});
} catch (e) {
if (!mounted) return;

setState(() {
isScanning = false;
status = 'Scan failed: $e';
});
}
}

Color riskColor(String risk) {
switch (risk) {
case 'High':
return Colors.red;

case 'Medium':
return Colors.orange;

case 'Low':
return Colors.green;

default:
return Colors.grey;
}
}

IconData riskIcon(String risk) {
switch (risk) {
case 'High':
return Icons.warning;

case 'Medium':
return Icons.warning_amber;

case 'Low':
return Icons.check_circle;

default:
return Icons.help;
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
'Device Security',
style: TextStyle(
fontWeight: FontWeight.bold,
),
),
),

body: Padding(
padding: const EdgeInsets.all(20),

child: Column(
children: [
const Icon(
Icons.computer,
size: 80,
color: Colors.blueAccent,
),

const SizedBox(height: 15),

const Text(
'Device Security Scan',
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 10),

Text(
widget.ipAddress,
style: const TextStyle(
fontSize: 18,
color: Colors.white70,
),
),

const SizedBox(height: 25),

SizedBox(
width: double.infinity,
height: 55,

child: ElevatedButton.icon(
onPressed:
isScanning ? null : scanPorts,

icon: isScanning
? const SizedBox(
width: 20,
height: 20,
child:
CircularProgressIndicator(
strokeWidth: 2,
),
)
: const Icon(Icons.security),

label: Text(
isScanning
? 'Scanning...'
: 'Scan Open Ports',
style: const TextStyle(
fontSize: 17,
),
),
),
),

const SizedBox(height: 20),

Text(
status,
textAlign: TextAlign.center,
style: const TextStyle(
color: Colors.white60,
),
),

const SizedBox(height: 20),Expanded(
    child: openPorts.isEmpty
        ? const Center(
      child: Text(
        'No open ports found',
        style: TextStyle(
          color: Colors.white54,
          fontSize: 16,
        ),
      ),
    )
        : ListView.builder(
      itemCount: openPorts.length,

      itemBuilder:
          (context, index) {
        final result =
        openPorts[index];

        final color =
        riskColor(
          result.risk,
        );

        return Card(
          margin:
          const EdgeInsets.only(
            bottom: 12,
          ),

          child: ListTile(
            leading:
            CircleAvatar(
              child: Icon(
                Icons
                    .lan,
                color: color,
              ),
            ),

            title: Text(
              'Port ${result.port}',
              style:
              const TextStyle(
                fontWeight:
                FontWeight
                    .bold,
              ),
            ),

            subtitle: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                const SizedBox(
                  height: 5,
                ),

                Text(
                  'Service: ${result.service}',
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  'Risk: ${result.risk}',
                  style:
                  TextStyle(
                    color: color,
                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),
              ],
            ),

            trailing:
            Icon(
              riskIcon(
                result.risk,
              ),
              color: color,
            ),
          ),
        );
      },
    ),
  ),
],
),
),
);
}
}