import 'package:flutter/material.dart';
import '../responsive/adaptive_scaffold.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(child: child);
  }
}
