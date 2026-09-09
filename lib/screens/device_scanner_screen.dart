import 'package:flutter/material.dart';

import '../models/device_model.dart';
import '../services/network_scanner_service.dart';
import '../services/network_service.dart';
import 'device_details_screen.dart';

class DeviceScannerScreen extends StatefulWidget {
  const DeviceScannerScreen({super.key});

  @override
  State<DeviceScannerScreen> createState() =>
      _DeviceScannerScreenState();
}

class _DeviceScannerScreenState
    extends State<DeviceScannerScreen> {
final NetworkService _networkService =
NetworkService();

final NetworkScannerService _scannerService =
NetworkScannerService();

List<DeviceModel> devices = [];

bool isScanning = false;

String status = 'Ready to scan';

String phoneIp = '';

String networkPrefix = '';

Future<void> scanNetwork() async {
setState(() {
isScanning = true;
devices = [];
status = 'Getting network information...';
});

try {
final networkInfo =
await _networkService.getNetworkInfo();

phoneIp =
networkInfo.ipAddress.trim();

if (phoneIp == 'Unknown' ||
phoneIp == 'Unavailable' ||
!phoneIp.contains('.')) {
if (!mounted) return;

setState(() {
isScanning = false;
status =
'Could not determine device IP';
});

return;
}

final parts = phoneIp.split('.');

if (parts.length != 4) {
if (!mounted) return;

setState(() {
isScanning = false;
status = 'Invalid IP address';
});

return;
}

networkPrefix =
'${parts[0]}.${parts[1]}.${parts[2]}';

if (!mounted) return;

setState(() {
status =
'Scanning $networkPrefix.0/24...';
});

final result =
await _scannerService.scanNetwork(
networkPrefix,
);

if (!mounted) return;

setState(() {
devices = result;
isScanning = false;
status =
'${devices.length} device(s) found';
});
} catch (e) {
if (!mounted) return;

setState(() {
isScanning = false;
status = 'Scan failed: $e';
});
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
'Device Scanner',
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
Icons.devices,
size: 80,
color: Colors.blueAccent,
),

const SizedBox(height: 15),

const Text(
'Network Devices',
style: TextStyle(
fontSize: 25,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 10),

Text(
status,
textAlign: TextAlign.center,
style: const TextStyle(
color: Colors.white60,
fontSize: 15,
),
),

if (phoneIp.isNotEmpty) ...[
const SizedBox(height: 8),

Text(
'Your IP: $phoneIp',
style: const TextStyle(
color: Colors.white54,
),
),
],

const SizedBox(height: 25),

SizedBox(
width: double.infinity,
height: 55,

child: ElevatedButton.icon(
onPressed:
isScanning
? null
: scanNetwork,

icon: isScanning
? const SizedBox(width: 20,
  height: 20,
  child:
  CircularProgressIndicator(
    strokeWidth: 2,
  ),
)
    : const Icon(
  Icons.search,
),

  label: Text(
    isScanning
        ? 'Scanning...'
        : 'Scan Network',
    style:
    const TextStyle(
      fontSize: 17,
    ),
  ),
),
),

  const SizedBox(height: 20),

  Expanded(
    child: devices.isEmpty
        ? const Center(
      child: Text(
        'No devices found',
        textAlign:
        TextAlign.center,
        style: TextStyle(
          color:
          Colors.white54,
          fontSize: 16,
        ),
      ),
    )
        : ListView.builder(
      itemCount:
      devices.length,

      itemBuilder:
          (context, index) {
        final device =
        devices[index];

        final bool
        isThisDevice =
            device.ipAddress ==
                phoneIp;

        return Card(
          margin:
          const EdgeInsets
              .only(
            bottom: 12,
          ),

          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DeviceDetailsScreen(
                        ipAddress: device.ipAddress,
                      ),
                ),
              );
            },
            leading:
            CircleAvatar(
              child: Icon(
                isThisDevice
                    ? Icons
                    .smartphone
                    : Icons
                    .devices,
              ),
            ),

            title: Text(
              device.ipAddress,
              style:
              const TextStyle(
                fontWeight:
                FontWeight
                    .bold,
              ),
            ),

            subtitle:
            Text(
              isThisDevice
                  ? 'This Device'
                  : 'Network Device',
            ),

            trailing:
            const Icon(
              Icons
                  .check_circle,
              color:
              Colors.green,
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