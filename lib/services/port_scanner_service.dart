// import 'dart:io';
//
// class PortScannerService {
//   /// المنافذ التي سنفحصها
//   final List<int> commonPorts = [
//     21,   // FTP
//     22,   // SSH
//     23,   // Telnet
//     25,   // SMTP
//     53,   // DNS
//     80,   // HTTP
//     110,  // POP3
//     139,  // NetBIOS
//     143,  // IMAP
//     443,  // HTTPS
//     445,  // SMB
//     3389, // RDP
//     8080,
//   ];
//
//   Future<List<int>> scanPorts(String ip) async {
//     final List<int> openPorts = [];
//
//     for (final port in commonPorts) {
//       try {
//         final socket = await Socket.connect(
//           ip,
//           port,
//           timeout: const Duration(milliseconds: 500),
//         );
//
//         socket.destroy();
//
//         openPorts.add(port);
//       } catch (_) {
//         // المنفذ مغلق أو غير متاح
//       }
//     }
//
//     return openPorts;
//   }
// }

import 'dart:io';

class PortScanResult {
  final int port;
  final String service;
  final String risk;
  final bool isOpen;

  PortScanResult({
    required this.port,
    required this.service,
    required this.risk,
    required this.isOpen,
  });
}

class PortScannerService {
  final List<int> commonPorts = [
    21,
    22,
    23,
    25,
    53,
    80,
    110,
    139,
    143,
    443,
    445,
    3389,
    8080,
  ];

  Future<List<PortScanResult>> scanPorts(String ip) async {
    final List<PortScanResult> results = [];

    for (final port in commonPorts) {
      final bool isOpen = await _checkPort(ip, port);

      if (isOpen) {
        results.add(
          PortScanResult(
            port: port,
            service: getServiceName(port),
            risk: getRiskLevel(port),
            isOpen: true,
          ),
        );
      }
    }

    return results;
  }

  Future<bool> _checkPort(
      String ip,
      int port,
      ) async {
    try {
      final socket = await Socket.connect(
        ip,
        port,
        timeout: const Duration(milliseconds: 700),
      );

      socket.destroy();

      return true;
    } catch (_) {
      return false;
    }
  }

  String getServiceName(int port) {
    switch (port) {
      case 21:
        return 'FTP';

      case 22:
        return 'SSH';

      case 23:
        return 'Telnet';

      case 25:
        return 'SMTP';

      case 53:
        return 'DNS';

      case 80:
        return 'HTTP';

      case 110:
        return 'POP3';

      case 139:
        return 'NetBIOS';

      case 143:
        return 'IMAP';

      case 443:
        return 'HTTPS';

      case 445:
        return 'SMB';

      case 3389:
        return 'RDP';

      case 8080:
        return 'HTTP Test Server';

      default:
        return 'Unknown';
    }
  }

  String getRiskLevel(int port) {
    switch (port) {
      case 21:
      case 23:
      case 139:
      case 445:
      case 3389:
        return 'High';

      case 22:
      case 25:
      case 110:
      case 143:
      case 8080:
        return 'Medium';

      case 53:
      case 80:
      case 443:
        return 'Low';

      default:
        return 'Unknown';
    }
  }
}