import 'package:flutter/material.dart';

class UpdateManifest { const UpdateManifest({required this.version, required this.storeUrl, this.force = false}); final String version; final String storeUrl; final bool force; }
abstract class UpdateService { Future<UpdateManifest?> checkForUpdate(String currentVersion); }
class OfficialDistributionUpdateService implements UpdateService { const OfficialDistributionUpdateService({required this.manifestUri}); final Uri manifestUri; @override Future<UpdateManifest?> checkForUpdate(String currentVersion) async { return null; } }
class UpdateErrorView extends StatelessWidget { const UpdateErrorView({super.key, required this.message, required this.onRetry}); final String message; final VoidCallback onRetry; @override Widget build(BuildContext context) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.cloud_off, size: 48), const SizedBox(height: 12), Text(message), TextButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Retry'))])); }
