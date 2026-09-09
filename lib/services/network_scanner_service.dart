import 'dart:io';

import 'package:network_tools/network_tools.dart';

import '../models/device_model.dart';

class NetworkScannerService {
  String _normalizeNumbers(String value) {
    const arabicNumbers = '٠١٢٣٤٥٦٧٨٩';
    const englishNumbers = '0123456789';

    for (int i = 0; i < arabicNumbers.length; i++) {
      value = value.replaceAll(
        arabicNumbers[i],
        englishNumbers[i],
      );
    }

    return value;
  }

  String _normalizeNetworkPrefix(String value) {
    value = _normalizeNumbers(value).trim();

    final parts = value.split('.');

    if (parts.length == 4) {
      value =
      '${parts[0]}.${parts[1]}.${parts[2]}';
    }

    return value;
  }

  Future<List<DeviceModel>> scanNetwork(
      String networkPrefix,
      ) async {
    final List<DeviceModel> devices = [];

    networkPrefix =
        _normalizeNetworkPrefix(networkPrefix);

    final testIp = '$networkPrefix.1';

    if (InternetAddress.tryParse(testIp) == null) {
      throw Exception(
        'Invalid network address: $networkPrefix',
      );
    }

    print(
      'NETSHIELD SCANNING: '
          '$networkPrefix.1 - $networkPrefix.254',
    );

    final stream =
    HostScannerService.instance
        .getAllPingableDevices(
      networkPrefix,
      firstHostId: 1,
      lastHostId: 254,
      timeoutInSeconds: 1,
    );

    final Set<String> discoveredIps = {};

    await for (final host in stream) {
      final ip = _normalizeNumbers(
        host.address.toString(),
      );

      if (discoveredIps.contains(ip)) {
        continue;
      }

      discoveredIps.add(ip);

      print(
        'NETSHIELD DEVICE FOUND: $ip',
      );

      devices.add(
        DeviceModel(
          ipAddress: ip,
          hostname: ip,
          isOnline: true,
        ),
      );
    }

    // ترتيب الأجهزة حسب عنوان IP
    devices.sort(
          (a, b) => _ipToNumber(a.ipAddress)
          .compareTo(_ipToNumber(b.ipAddress)),
    );

    print(
      'NETSHIELD TOTAL DEVICES: '
          '${devices.length}',
    );

    return devices;
  }

  int _ipToNumber(String ip) {
    final parts = ip.split('.');

    if (parts.length != 4) {
      return 0;
    }

    try {
      return (int.parse(parts[0]) << 24) +
          (int.parse(parts[1]) << 16) +
          (int.parse(parts[2]) << 8) +
          int.parse(parts[3]);
    } catch (_) {
      return 0;
    }
  }
}