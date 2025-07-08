import 'package:appifylab_assessment/model/communities.dart';

class Comment {
  Comment({
      this.id, 
      this.schoolId, 
      this.feedId, 
      this.userId, 
      this.replyCount, 
      this.likeCount, 
      this.commentTxt, 
      this.parrentId, 
      this.createdAt, 
      this.updatedAt, 
      this.file, 
      this.privateUserId, 
      this.isAuthorAndAnonymous, 
      this.gift, 
      this.sellerId, 
      this.giftedCoins, 
      this.replies, 
      this.user, 
      this.totalLikes, 
      this.commentlike, 
      this.reactionTypes,});

  Comment.fromJson(dynamic json) {
    id = json['id'];
    schoolId = json['school_id'];
    feedId = json['feed_id'];
    userId = json['user_id'];
    replyCount = json['reply_count'];
    likeCount = json['like_count'];
    commentTxt = json['comment_txt'];
    parrentId = json['parrent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    file = json['file'];
    privateUserId = json['private_user_id'];
    isAuthorAndAnonymous = json['is_author_and_anonymous'];
    gift = json['gift'];
    sellerId = json['seller_id'];
    giftedCoins = json['gifted_coins'];

    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['totalLikes'] != null) {
      totalLikes = [];
      json['totalLikes'].forEach((v) {
        totalLikes?.add(v);
      });
    }
    commentlike = json['commentlike'];
    if (json['reaction_types'] != null) {
      reactionTypes = [];
      json['reaction_types'].forEach((v) {
        reactionTypes?.add(v);
      });
    }
  }
  num? id;
  num? schoolId;
  num? feedId;
  num? userId;
  num? replyCount;
  num? likeCount;
  String? commentTxt;
  num? parrentId;
  String? createdAt;
  String? updatedAt;
  dynamic file;
  dynamic privateUserId;
  num? isAuthorAndAnonymous;
  dynamic gift;
  dynamic sellerId;
  dynamic giftedCoins;
  List<dynamic>? replies;
  User? user;
  List<LikeType>? totalLikes;
  dynamic commentlike;
  List<dynamic>? reactionTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['school_id'] = schoolId;
    map['feed_id'] = feedId;
    map['user_id'] = userId;
    map['reply_count'] = replyCount;
    map['like_count'] = likeCount;
    map['comment_txt'] = commentTxt;
    map['parrent_id'] = parrentId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['file'] = file;
    map['private_user_id'] = privateUserId;
    map['is_author_and_anonymous'] = isAuthorAndAnonymous;
    map['gift'] = gift;
    map['seller_id'] = sellerId;
    map['gifted_coins'] = giftedCoins;
    if (replies != null) {
      map['replies'] = replies?.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (totalLikes != null) {
      map['totalLikes'] = totalLikes?.map((v) => v.toJson()).toList();
    }
    map['commentlike'] = commentlike;
    if (reactionTypes != null) {
      map['reaction_types'] = reactionTypes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class User {
  User({
      this.id, 
      this.fullName, 
      this.profilePic, 
      this.userType, 
      this.meta,});

  User.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    userType = json['user_type'];
    meta = json['meta'];
  }
  num? id;
  String? fullName;
  String? profilePic;
  String? userType;
  dynamic meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['profile_pic'] = profilePic;
    map['user_type'] = userType;
    map['meta'] = meta;
    return map;
  }

}