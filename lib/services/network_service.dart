import 'package:network_info_plus/network_info_plus.dart';

import '../models/network_info.dart';

class NetworkService {
  final NetworkInfo _networkInfo = NetworkInfo();

  Future<NetworkInfoModel> getNetworkInfo() async {
    String wifiName = 'Unknown';
    String ipAddress = 'Unknown';
    String gateway = 'Unknown';
    String subnet = 'Unknown';

    // Wi-Fi Name
    try {
      wifiName =
          await _networkInfo.getWifiName() ?? 'Unknown';
    } catch (_) {
      wifiName = 'Unavailable';
    }

    // IP Address
    try {
      ipAddress =
          await _networkInfo.getWifiIP() ?? 'Unknown';
    } catch (_) {
      ipAddress = 'Unavailable';
    }

    // Gateway
    try {
      gateway =
          await _networkInfo.getWifiGatewayIP() ?? 'Unknown';
    } catch (_) {
      gateway = 'Unavailable';
    }

    // Subnet Mask
    try {
      subnet =
          await _networkInfo.getWifiSubmask() ?? 'Unknown';

      if (subnet.trim().isEmpty) {
        subnet = 'Unknown';
      }
    } catch (_) {
      subnet = 'Unavailable';
    }

    return NetworkInfoModel(
      wifiName: wifiName,
      ipAddress: ipAddress,
      gateway: gateway,
      subnet: subnet,
      connectionType: 'Wi-Fi',
    );
  }
}