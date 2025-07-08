class Urls{
  static const String baseUrl = 'https://ezyappteam.ezycourse.com/api/app';
  static const String login = '$baseUrl/student/auth/login';
  static const String logout = '$baseUrl/student/auth/logout';
  static const String getCommunity = '$baseUrl/teacher/community/getFeed?status=feed';
  static const String createPost = '$baseUrl/teacher/community/createFeedWithUpload';
  static const String createComment = '$baseUrl/student/comment/createComment';
  static const String updateReaction = '$baseUrl/teacher/community/createLike';

  static String getComments(String id) => '$baseUrl/student/comment/getComment/$id';
  static String getCommentsReply(String id) => '$baseUrl/student/comment/getReply/$id';
}