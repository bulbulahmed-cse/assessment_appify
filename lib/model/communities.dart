import 'package:appifylab_assessment/model/comment.dart';

class Communities {
  Communities({
      this.id, 
      this.schoolId, 
      this.userId, 
      this.courseId, 
      this.communityId, 
      this.groupId, 
      this.feedTxt, 
      this.status, 
      this.slug, 
      this.title, 
      this.activityType, 
      this.isPinned, 
      this.fileType, 
      this.files, 
      this.likeCount, 
      this.commentCount, 
      this.shareCount, 
      this.shareId, 
      this.metaData, 
      this.createdAt, 
      this.updatedAt, 
      this.feedPrivacy, 
      this.isBackground, 
      this.bgColor, 
      this.pollId, 
      this.lessonId, 
      this.spaceId, 
      this.videoId, 
      this.streamId, 
      this.blogId, 
      this.scheduleDate, 
      this.timezone, 
      this.isAnonymous, 
      this.meetingId, 
      this.sellerId, 
      this.publishDate, 
      this.coachingFeedId, 
      this.isFeedEdit, 
      this.name, 
      this.pic, 
      this.uid, 
      this.isPrivateChat, 
      this.group, 
      this.poll, 
      this.like, 
      this.follow, 
      this.user, 
      this.savedPosts, 
      this.likeType, 
      this.comments, 
      this.meta,});

  Communities.fromJson(dynamic json) {
    id = json['id'];
    schoolId = json['school_id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    communityId = json['community_id'];
    groupId = json['group_id'];
    feedTxt = json['feed_txt'];
    status = json['status'];
    slug = json['slug'];
    title = json['title'];
    activityType = json['activity_type'];
    isPinned = json['is_pinned'];
    fileType = json['file_type'];
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files?.add(v);
      });
    }
    likeCount = json['like_count'];
    commentCount = json['comment_count'];
    shareCount = json['share_count'];
    shareId = json['share_id'];
    metaData = json['meta_data'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    feedPrivacy = json['feed_privacy'];
    isBackground = json['is_background'];
    bgColor = json['bg_color'];
    pollId = json['poll_id'];
    lessonId = json['lesson_id'];
    spaceId = json['space_id'];
    videoId = json['video_id'];
    streamId = json['stream_id'];
    blogId = json['blog_id'];
    scheduleDate = json['schedule_date'];
    timezone = json['timezone'];
    isAnonymous = json['is_anonymous'];
    meetingId = json['meeting_id'];
    sellerId = json['seller_id'];
    publishDate = json['publish_date'];
    coachingFeedId = json['coaching_feed_id'];
    isFeedEdit = json['is_feed_edit'];
    name = json['name'];
    pic = json['pic'];
    uid = json['uid'];
    isPrivateChat = json['is_private_chat'];
    group = json['group'];
    poll = json['poll'];
    like = json['like'] != null ? Like.fromJson(json['like']) : null;
    follow = json['follow'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    savedPosts = json['savedPosts'];
    likeType = [];
    if (json['likeType'] != null) {
      json['likeType'].forEach((v) {
        likeType?.add(LikeType.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(v);
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  num? id;
  num? schoolId;
  num? userId;
  dynamic courseId;
  num? communityId;
  dynamic groupId;
  String? feedTxt;
  String? status;
  String? slug;
  String? title;
  String? activityType;
  num? isPinned;
  String? fileType;
  List<dynamic>? files;
  num? likeCount;
  num? commentCount;
  num? shareCount;
  num? shareId;
  dynamic metaData;
  String? createdAt;
  String? updatedAt;
  String? feedPrivacy;
  num? isBackground;
  dynamic bgColor;
  dynamic pollId;
  dynamic lessonId;
  num? spaceId;
  dynamic videoId;
  dynamic streamId;
  dynamic blogId;
  dynamic scheduleDate;
  dynamic timezone;
  dynamic isAnonymous;
  dynamic meetingId;
  dynamic sellerId;
  String? publishDate;
  dynamic coachingFeedId;
  bool? isFeedEdit;
  String? name;
  String? pic;
  num? uid;
  num? isPrivateChat;
  dynamic group;
  dynamic poll;
  Like? like;
  dynamic follow;
  User? user;
  dynamic savedPosts;
  List<LikeType>? likeType;
  List<Comment>? comments;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['school_id'] = schoolId;
    map['user_id'] = userId;
    map['course_id'] = courseId;
    map['community_id'] = communityId;
    map['group_id'] = groupId;
    map['feed_txt'] = feedTxt;
    map['status'] = status;
    map['slug'] = slug;
    map['title'] = title;
    map['activity_type'] = activityType;
    map['is_pinned'] = isPinned;
    map['file_type'] = fileType;
    if (files != null) {
      map['files'] = files?.map((v) => v.toJson()).toList();
    }
    map['like_count'] = likeCount;
    map['comment_count'] = commentCount;
    map['share_count'] = shareCount;
    map['share_id'] = shareId;
    map['meta_data'] = metaData;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['feed_privacy'] = feedPrivacy;
    map['is_background'] = isBackground;
    map['bg_color'] = bgColor;
    map['poll_id'] = pollId;
    map['lesson_id'] = lessonId;
    map['space_id'] = spaceId;
    map['video_id'] = videoId;
    map['stream_id'] = streamId;
    map['blog_id'] = blogId;
    map['schedule_date'] = scheduleDate;
    map['timezone'] = timezone;
    map['is_anonymous'] = isAnonymous;
    map['meeting_id'] = meetingId;
    map['seller_id'] = sellerId;
    map['publish_date'] = publishDate;
    map['coaching_feed_id'] = coachingFeedId;
    map['is_feed_edit'] = isFeedEdit;
    map['name'] = name;
    map['pic'] = pic;
    map['uid'] = uid;
    map['is_private_chat'] = isPrivateChat;
    map['group'] = group;
    map['poll'] = poll;
    if (like != null) {
      map['like'] = like?.toJson();
    }
    map['follow'] = follow;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['savedPosts'] = savedPosts;
    if (likeType != null) {
      map['likeType'] = likeType?.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }

}

class Meta {
  Meta({
      this.views,});

  Meta.fromJson(dynamic json) {
    views = json['views'];
  }
  num? views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['views'] = views;
    return map;
  }

}

class LikeType {
  LikeType({
      this.reactionType, 
      this.feedId, 
      this.meta,});

  LikeType.fromJson(dynamic json) {
    reactionType = json['reaction_type'];
    feedId = json['feed_id'];
    meta = json['meta'];
  }
  String? reactionType;
  num? feedId;
  dynamic meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reaction_type'] = reactionType;
    map['feed_id'] = feedId;
    map['meta'] = meta;
    return map;
  }

}

class User {
  User({
      this.id, 
      this.fullName, 
      this.profilePic, 
      this.isPrivateChat, 
      this.expireDate, 
      this.status, 
      this.pauseDate, 
      this.userType, 
      this.meta,});

  User.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    isPrivateChat = json['is_private_chat'];
    expireDate = json['expire_date'];
    status = json['status'];
    pauseDate = json['pause_date'];
    userType = json['user_type'];
    meta = json['meta'];
  }
  num? id;
  String? fullName;
  String? profilePic;
  num? isPrivateChat;
  dynamic expireDate;
  String? status;
  dynamic pauseDate;
  String? userType;
  dynamic meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['profile_pic'] = profilePic;
    map['is_private_chat'] = isPrivateChat;
    map['expire_date'] = expireDate;
    map['status'] = status;
    map['pause_date'] = pauseDate;
    map['user_type'] = userType;
    map['meta'] = meta;
    return map;
  }

}

class Like {
  Like({
      this.id, 
      this.feedId, 
      this.userId, 
      this.reactionType, 
      this.createdAt, 
      this.updatedAt, 
      this.isAnonymous, 
      this.meta,});

  Like.fromJson(dynamic json) {
    id = json['id'];
    feedId = json['feed_id'];
    userId = json['user_id'];
    reactionType = json['reaction_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAnonymous = json['is_anonymous'];
    meta = json['meta'];
  }
  num? id;
  num? feedId;
  num? userId;
  String? reactionType;
  String? createdAt;
  String? updatedAt;
  num? isAnonymous;
  dynamic meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['feed_id'] = feedId;
    map['user_id'] = userId;
    map['reaction_type'] = reactionType;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_anonymous'] = isAnonymous;
    map['meta'] = meta;
    return map;
  }

}