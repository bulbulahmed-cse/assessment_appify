import 'dart:async';

import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/repository/post_repository.dart';
import 'package:appifylab_assessment/utils/helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'create_post_event.dart';
import 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  PostRepository repository = PostRepository();
  TextEditingController postContent = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  CreatePostBloc() : super(CreatePostState().init()) {
    on<InitEvent>(_init);
    on<CreatePost>(_createPost);
    on<GradientColorChangeEvent>((event, emit) {
      if(state.selectedGradient == event.gradient) {
        emit(state.selectGradient(
          null,
        ));
        return;
      }
      emit(state.clone(selectedGradient: event.gradient));
    });

    on<AnonymousChangeEvent>((event, emit) {
      emit(state.clone(isAnonymous: event.isAnonymous));
    });
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<CreatePostState> emit) async {
    emit(state.clone());
  }

  FutureOr<void> _createPost(CreatePost event, Emitter<CreatePostState> emit) async {
    if(!formKey.currentState!.validate()) return;
    Helper.showProgress();
    await repository.createPost(
      content: postContent.text,
      bgColor: state.selectedGradient!=null?feedBackGroundGradientColors[gradientsColor.indexOf(state.selectedGradient)]:null,
      onSuccess: (data){
        backPage();
        backPage(true);
      },
      onError: (data){
        backPage();
      }
    );
  }
}
