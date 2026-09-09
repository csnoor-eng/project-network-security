class NetworkInfoModel {
  final String wifiName;
  final String ipAddress;
  final String gateway;
  final String subnet;
  final String connectionType;

  NetworkInfoModel({
    required this.wifiName,
    required this.ipAddress,
    required this.gateway,
    required this.subnet,
    required this.connectionType,
  });
}