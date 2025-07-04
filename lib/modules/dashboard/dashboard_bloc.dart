import 'dart:async';

import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/repository/auth_repository.dart';
import 'package:appifylab_assessment/repository/dashboard_repository.dart';
import 'package:appifylab_assessment/utils/helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../model/communities.dart';
import '../../routes/route.dart';
import '../../utils/share_helper.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  AuthRepository authRepository = AuthRepository();
  DashboardRepository repository = DashboardRepository();
  RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );
  String? more;

  DashboardBloc() : super(DashboardState().init()) {
    on<InitEvent>(_init);
    on<Logout>(_logout);
    on<CreatePost>(_createPost);
  }

  @override
  Future<void> close() {
    authRepository.close();
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<DashboardState> emit) async {
    more = null;
    getData();
  }

  Future getData() async {
    await repository.getCommunities(
      more: more,
      onSuccess: (data){
        if((state.allCommunities??[]).isEmpty){
          emit(state.clone(allCommunities: data));
        } else {
          List<Communities> all = state.allCommunities!;
          all.addAll(data);
          emit(state.clone(allCommunities: all));
        }
        if(data.length < 15){
          more = null;
          refreshController.loadNoData();
        } else {
          more = data.last.id.toString();
        }
      },
      onError: (data){
        backPage();
      }
    );
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  FutureOr<void> _logout(Logout event, Emitter<DashboardState> emit) async {
    await showCupertinoDialog(
      context: appContext,
      barrierDismissible: true,
      builder: (context){
        return CupertinoAlertDialog(
          content: Text(
            "Are you sure, you want to log out?"
          ),
          title: Text(
            "Logout"
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: (){
                backPage();
                authRepository.doLogout(
                  onSuccess: (data){},
                  onError: (data){}
                );
              },
              child: Text(
                "Yes",
                style: appTheme(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              )
            ),
            CupertinoDialogAction(
              onPressed: backPage,
              child: Text(
                "No",
                style: appTheme(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              )
            ),
          ],
        );
      }
    );
  }

  FutureOr<void> _createPost(CreatePost event, Emitter<DashboardState> emit) async {
    bool? status = await goToPage(Routes.createPost);
    if(status ?? false){
      refreshController.requestRefresh();
    }
  }
}
