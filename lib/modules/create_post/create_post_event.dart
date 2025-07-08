import 'package:flutter/material.dart';

abstract class CreatePostEvent {}

class InitEvent extends CreatePostEvent {}
class CreatePost extends CreatePostEvent {}

class GradientColorChangeEvent extends CreatePostEvent {
  final LinearGradient gradient;

  GradientColorChangeEvent(this.gradient);
}

class AnonymousChangeEvent extends CreatePostEvent {
  final bool isAnonymous;

  AnonymousChangeEvent(this.isAnonymous);
}