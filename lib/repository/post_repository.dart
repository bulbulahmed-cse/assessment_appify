import 'package:appifylab_assessment/https/urls.dart';
import 'package:appifylab_assessment/utils/api_client.dart';
import 'package:appifylab_assessment/utils/share_helper.dart';

class PostRepository{
  ApiClient client = ApiClient();

  void close(){
    client.close();
  }

  Future createPost({
  required String content,
  required Function onSuccess,
  required Function onError,
  }) async {
    await client.request(
      url: Urls.createPost,
      method: Method.POST,
      body: <String, String>{
        'community_id': '2914',
        'space_id': '5883',
        'feed_txt': content,
        'uploadType': 'text',
        'activity_type': 'group',
        'is_background': '0',
      },
      onSuccess: (data){
        onSuccess(data);
      },
      onError: onError
    );
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