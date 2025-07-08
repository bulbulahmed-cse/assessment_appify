abstract class DashboardEvent {}

class InitEvent extends DashboardEvent {}
class Logout extends DashboardEvent {}
class CreatePost extends DashboardEvent {}
class CommentVisibilityChangeEvent extends DashboardEvent {
  final bool isVisible;

  CommentVisibilityChangeEvent(this.isVisible);
}

class GetCommentsEvent extends DashboardEvent {
  final String feedId;
  final String? parentId;
  final bool isReply;

  GetCommentsEvent({
    required this.feedId,
    this.isReply = false,
    this.parentId,
  });
}

class CreateCommentEvent extends DashboardEvent {
  final String commentText;
  final String feedId;
  final bool isReply;
  final String? parentId;
  final String? feedUserId;
  final Function then;

  CreateCommentEvent({
    required this.commentText,
    required this.feedId,
    this.isReply = false,
    this.parentId, required this.then,
    required this.feedUserId,
  });
}

class SelectReplyEvent extends DashboardEvent {
  final String id;
  final String name;

  SelectReplyEvent({
    required this.id,
    required this.name,
  });
}