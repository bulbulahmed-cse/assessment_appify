import 'package:flutter/material.dart';

class CreatePostState {
  final LinearGradient? selectedGradient;
  final bool? isAnonymous;

  CreatePostState({
    this.selectedGradient,
    this.isAnonymous,
});

  CreatePostState init() {
    return CreatePostState();
  }

  CreatePostState clone(
      {LinearGradient? selectedGradient,
      bool? isAnonymous}
      ) {
    return CreatePostState(
      selectedGradient: selectedGradient ?? this.selectedGradient,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }

  CreatePostState selectGradient(LinearGradient? gradient) {
    return CreatePostState(
      selectedGradient: gradient,
    );
  }
}
