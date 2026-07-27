import 'package:flutter/material.dart';

class AppTheme {
    static ThemeData get light {
        return ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.green,
            scaffoldBackgroundColor: const Color(0xfff5f5f7),
        );
    }
}