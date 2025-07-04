class Urls{
  static const String baseUrl = 'https://ezyappteam.ezycourse.com/api/app';
  static const String login = '$baseUrl/student/auth/login';
  static const String logout = '$baseUrl/student/auth/logout';
  static const String getCommunity = '$baseUrl/teacher/community/getFeed?status=feed';
  static const String createPost = '$baseUrl/teacher/community/createFeedWithUpload';
  static const String updateReaction = '$baseUrl/teacher/community/createLike';
}