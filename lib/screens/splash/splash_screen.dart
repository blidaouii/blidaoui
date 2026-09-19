import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class SplashScreen extends StatefulWidget { const SplashScreen({super.key, required this.onComplete}); final Widget Function() onComplete; @override State<SplashScreen> createState() => _SplashScreenState(); }
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();
  @override void initState() { super.initState(); Timer(const Duration(milliseconds: 1200), () { if (mounted) Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => widget.onComplete(), transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child))); }); }
  @override void dispose() { _controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(body: Center(child: ScaleTransition(scale: CurvedAnimation(parent: _controller, curve: Curves.elasticOut), child: Column(mainAxisSize: MainAxisSize.min, children: [Container(width: 104, height: 104, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppTheme.green, Color(0xFF11B982)]), borderRadius: BorderRadius.circular(32), boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)]), child: const Icon(Icons.casino, color: Colors.white, size: 58)), const SizedBox(height: 22), Text('LUDO DZ', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 4, color: AppTheme.green)), const SizedBox(height: 6), const Text('PLAY WITH PRIDE', style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.bold, color: AppTheme.red))])));
}
