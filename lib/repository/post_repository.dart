import 'package:appifylab_assessment/https/urls.dart';
import 'package:appifylab_assessment/model/comment.dart';
import 'package:appifylab_assessment/utils/api_client.dart';
import 'package:appifylab_assessment/utils/share_helper.dart';

class PostRepository{
  ApiClient client = ApiClient();

  void close(){
    client.close();
  }

  Future<List<Comment>> getComments({
    required String feedId,
    required isReply,
    String? more,
  }) async {
    List<Comment> allComment = [];
    await client.request(
        url: isReply?Urls.getCommentsReply(feedId):Urls.getComments(feedId),
        method: Method.GET,
        onSuccess: (data){
          List list = data as List;
          for (var e in list) {
            allComment.add(Comment.fromJson(e));
          }
          print(list);
        },
        onError: (){}
    );
    return allComment;
  }

  Future createPost({
  required String content,
    String? bgColor,

  required Function onSuccess,
  required Function onError,
  }) async {
    await client.request(
      url: Urls.createPost,
      method: Method.POST,
      body: <String, dynamic>{
        'community_id': '2914',
        'space_id': '5883',
        'feed_txt': content,
        'uploadType': 'text',
        'activity_type': 'group',
        'is_background': bgColor==null?'0':'1',
        'bg_color': bgColor,
      },
      onSuccess: (data){
        onSuccess(data);
      },
      onError: onError
    );
  }

  Future createComment({
    required String commentText,
     required String feedId,
    required String feedUserId,
    required bool isReply,
    required String? parentId,
  }) async {
    await client.request(
        url: Urls.createComment,
        method: Method.POST,
        body: isReply==true?{
          'comment_txt': commentText,
          'feed_id': feedId,
          "parrent_id": parentId,
          'commentSource': 'COMMUNITY',
        }:<String, dynamic>{
          'comment_txt': commentText,
          'feed_id': feedId,
          'commentSource': 'COMMUNITY',
        },
        onSuccess: (data){
         return true;
        },
        onError: (){}

    );
    return false;
  }

  Future updateReaction({
  required String feedId,reactionType,action,
  required Function onSuccess,
  required Function onError,
  }) async {
    await client.request(
      url: Urls.updateReaction,
      method: Method.POST,
      body: <String, String>{
        'feed_id': feedId,
        'reaction_type': reactionType,
        'action': action,
        'reactionSource': 'COMMUNITY',
      },
      onSuccess: (data){
        onSuccess(data);
      },
      onError: onError
    );
  }
}