import 'package:flutter/material.dart';

class CarouselItem {
  final String animationURL;
  final String title;
  final Widget page;

  const CarouselItem({
    required this.animationURL,
    required this.title,
    required this.page,
  });
}
