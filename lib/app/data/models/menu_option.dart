import 'package:flutter/material.dart';

// Model class to hold menu option data (language and theme)
class MenuOptions<K, T> {
  final K key;
  final T value;
  final IconData? icon;

  MenuOptions({required this.key, required this.value, this.icon});
}
