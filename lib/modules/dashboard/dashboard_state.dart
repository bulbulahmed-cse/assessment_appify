import '../../model/communities.dart';
import '../../model/reply.dart';

class DashboardState {
  List<Communities>? allCommunities;
  bool? isCommentVisible = false;
  Reply? reply;


  DashboardState({this.allCommunities, this.isCommentVisible, this.reply});

  DashboardState init() {
    return DashboardState();
  }

  DashboardState clone({List<Communities>? allCommunities,
  bool? isCommentVisible}) {
    return DashboardState(
      allCommunities: allCommunities ?? this.allCommunities,
      isCommentVisible: isCommentVisible ?? this.isCommentVisible,
    );
  }

  DashboardState replyClone({Reply? reply}) {
    return DashboardState(
      reply: reply,
    );
  }
}
