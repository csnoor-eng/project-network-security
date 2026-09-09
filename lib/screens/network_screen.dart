import 'package:flutter/material.dart';

import '../models/network_info.dart';
import '../services/network_service.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() =>
      _NetworkScreenState();
}

class _NetworkScreenState
    extends State<NetworkScreen> {
final NetworkService _networkService =
NetworkService();

NetworkInfoModel? networkInfo;

bool isLoading = true;

@override
void initState() {
super.initState();
loadNetworkInfo();
}

Future<void> loadNetworkInfo() async {
setState(() {
isLoading = true;
});

try {
final result =
await _networkService.getNetworkInfo();

if (!mounted) return;

setState(() {
networkInfo = result;
isLoading = false;
});
} catch (_) {
if (!mounted) return;

setState(() {
isLoading = false;
});
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
'Network Information',
style: TextStyle(
fontWeight: FontWeight.bold,
),
),
),

body: isLoading
? const Center(
child:
CircularProgressIndicator(),
)
: RefreshIndicator(
onRefresh: loadNetworkInfo,

child: ListView(
padding:
const EdgeInsets.all(20),

children: [
const Icon(
Icons.wifi,
size: 80,
color: Colors.blueAccent,
),

const SizedBox(height: 15),

const Center(
child: Text(
'Current Network',
style: TextStyle(
fontSize: 24,
fontWeight:
FontWeight.bold,
),
),
),

const SizedBox(height: 30),

_infoCard(
icon: Icons.wifi,
title: 'Wi-Fi Name',
value:
networkInfo?.wifiName ??
'Unknown',
),

_infoCard(
icon: Icons.language,
title: 'IP Address',
value:
networkInfo?.ipAddress ??
'Unknown',
),

_infoCard(
icon: Icons.router,
title: 'Gateway',
value:
networkInfo?.gateway ??
'Unknown',
),

_infoCard(
icon:
Icons.account_tree,
title: 'Subnet Mask',
value:
networkInfo?.subnet ??
'Unknown',
),

_infoCard(
icon: Icons.security,
title: 'Connection',
value:
networkInfo
?.connectionType ??
'Unknown',
),

const SizedBox(height: 20),

SizedBox(
height: 55,

child:
ElevatedButton.icon(
onPressed:
loadNetworkInfo,

icon: const Icon(
Icons.refresh,
),label: const Text(
  'Refresh Network Information',
  style: TextStyle(
    fontSize: 16,
  ),
),
),
),
],
),
),
);
}

Widget _infoCard({
  required IconData icon,
  required String title,
  required String value,
}) {
  return Card(
    margin:
    const EdgeInsets.only(bottom: 15),

    child: ListTile(
      leading: CircleAvatar(
        backgroundColor:
        Colors.blueAccent
            .withOpacity(0.15),

        child: Icon(
          icon,
          color: Colors.blueAccent,
        ),
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white60,
          fontSize: 14,
        ),
      ),

      subtitle: Padding(
        padding:
        const EdgeInsets.only(top: 5),

        child: Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
}