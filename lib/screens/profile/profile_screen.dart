import 'package:flutter/material.dart';
import '../../profile/profile_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override Widget build(BuildContext context) {
    final profile = ProfileService.instance.profile;
    return Scaffold(appBar: AppBar(title: const Text('Profile')), body: ListView(padding: const EdgeInsets.all(20), children: [
      Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [CircleAvatar(radius: 38, child: Text(profile.avatar, style: const TextStyle(fontSize: 34))), const SizedBox(height: 12), Text(profile.username, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)), Text('Level ${profile.level} • ${profile.xp} XP')]))),
      const SizedBox(height: 12),
      Row(children: [_stat(context, 'Games', profile.gamesPlayed), _stat(context, 'Wins', profile.wins), _stat(context, 'Losses', profile.losses)]),
      Card(child: ListTile(leading: const Icon(Icons.monetization_on), title: const Text('Coins'), trailing: Text('${profile.coins}', style: const TextStyle(fontWeight: FontWeight.bold)))),
    ]));
  }
  Widget _stat(BuildContext context, String label, int value) => Expanded(child: Card(child: Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: Column(children: [Text('$value', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)), Text(label)]))));
}
