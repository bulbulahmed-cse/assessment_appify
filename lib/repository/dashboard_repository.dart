import 'package:appifylab_assessment/https/urls.dart';
import 'package:appifylab_assessment/model/auth.dart';
import 'package:appifylab_assessment/model/communities.dart';
import 'package:appifylab_assessment/utils/api_client.dart';
import 'package:appifylab_assessment/utils/share_helper.dart';

import '../model/comment.dart';

class DashboardRepository{
  ApiClient client = ApiClient();

  void close(){
    client.close();
  }

  Future getCommunities({
    String? more,
    required Function onSuccess,
    required Function onError,
  }) async {
    await client.request(
      url: Urls.getCommunity,
      method: Method.POST,
      body: <String, String>{
        'community_id': '2914',
        'space_id': '5883',
        'more': more ?? '',
      },
      onSuccess: (data){
        List list = data as List;
        List<Communities> allCommunities = [];
        for (var e in list) {
          allCommunities.add(Communities.fromJson(e));
        }
        onSuccess(allCommunities);
      },
      onError: onError
    );
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
}