import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/model/communities.dart';
import 'package:appifylab_assessment/repository/dashboard_repository.dart';
import 'package:appifylab_assessment/repository/post_repository.dart';
import 'package:appifylab_assessment/utils/app_colors.dart';
import 'package:appifylab_assessment/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
Map<String, AssetGenImage> likeData = {
  'like': Assets.like,
  'love': Assets.love,
  'haha': Assets.haha,
  'care': Assets.care,
  'angry': Assets.angry,
  'sad': Assets.sad,
  'wow': Assets.wow,
};
class SinglePost extends StatefulWidget {
  final Communities post;
  const SinglePost(this.post,{super.key});

  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  PostRepository repository = PostRepository();
  String? initialReaction;
  @override
  void initState() {
    initialReaction = widget.post.like?.reactionType!.toLowerCase();
    super.initState();
  }

  @override
  void dispose() {
    repository.close();
    super.dispose();
  }

  Future updateReaction(String reaction, action) async {
    await repository.updateReaction(
      feedId: (widget.post.id ?? 0).toString(),
      reactionType: reaction.toUpperCase(),
      action: action,
      onSuccess: (data) {},
      onError: (error) {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.post.user?.profilePic ?? '',
                  height: 34,
                  width: 34,
                  placeholder: (context, url) => Assets.userPng.image(
                    height: 34,
                    width: 34
                  ),
                  errorWidget: (context, url, error) => Assets.userPng.image(
                      height: 34,
                      width: 34
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post?.user?.fullName ?? '',
                      style: appTheme(context).textTheme.headlineMedium,
                    ),
                    4.verticalSpace,
                    Text(
                      (widget.post?.createdAt ?? DateTime.now().toString()).timeEgo,
                      style: appTheme(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              8.horizontalSpace,
              Icon(
                Icons.more_vert_rounded,
                size: 24,
              )
            ],
          ),
          8.verticalSpace,
          Divider(),
          8.verticalSpace,
          Text(
            widget.post.feedTxt ?? '',
            style: appTheme(context).textTheme.bodyLarge,
          ),
          if(widget.post.pic != null)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.2),
                child: CachedNetworkImage(
                  imageUrl: widget.post.pic ?? '',
                  height: 162,
                  width: double.infinity,
                  placeholder: (context, url) => Assets.userPng.image(
                    height: 162,
                    width: double.infinity,
                  ),
                  errorWidget: (context, url, error) => Assets.userPng.image(
                    height: 162,
                    width: double.infinity,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      height: 20,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: (widget.post.likeType ?? []).map((e)=> e.reactionType!.toLowerCase()).toList().asMap().map((key, value){
                          return MapEntry(key,
                              Padding(
                                padding: EdgeInsets.only(left: key * 15),
                                child: likeData[value]!.image(
                                  height: 18,
                                  width: 18,
                                ),
                              )
                          );
                        }).values.toList(),
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      '${widget.post.likeType?.length ?? 0} React'
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Assets.comment.svg(
                    height: 18
                  ),
                  8.horizontalSpace,
                  Text(
                    '${(widget.post.comments?.length ?? 0)} Comments',
                    style: appTheme(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              )
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              ReactionButton<String>(
                toggle: false,
                direction: ReactionsBoxAlignment.rtl,
                onReactionChanged: (Reaction<String>? reaction) {
                  bool isDelete = false;
                  if(initialReaction!= null && initialReaction == reaction?.value){
                    isDelete = true;
                    initialReaction = null;
                    widget.post.like = null;
                    List<LikeType> likes = (widget.post.likeType ?? []).where((element) => element.reactionType!.toLowerCase() == reaction?.value?.toLowerCase()).toList();
                    if(likes.isNotEmpty){
                      likes.removeAt(0);
                      widget.post.likeType = likes;
                    }
                  }
                  if(!isDelete){
                    initialReaction = reaction?.value ?? 'like';
                    if(widget.post.like != null){
                      List<LikeType> likes = (widget.post.likeType ?? []).where((element) => element.reactionType == widget.post.like!.reactionType).toList();
                      if(likes.isNotEmpty){
                        likes.removeAt(0);
                        widget.post.likeType = likes;
                      }
                    }
                    widget.post.like = Like(
                      reactionType: (reaction?.value ?? 'like').toUpperCase(),
                    );
                    widget.post.likeType!.add(LikeType(
                      reactionType: (reaction?.value ?? 'like').toUpperCase(),
                    ));
                  }
                  setState(() {});
                  updateReaction(reaction?.value ?? 'like', isDelete ? 'delete' : 'create');
                },
                reactions: likeData.map((key, value) {
                  return MapEntry(
                    key,
                    Reaction<String>(
                      value: key,
                      icon: value.image(),
                    ),
                  );
                }).values.toList(),
                boxColor: AppColor.white,
                boxRadius: 100,
                boxPadding: REdgeInsets.all(8),
                itemsSpacing: 16,
                itemSize: const Size(34, 34),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    likeData[initialReaction ?? 'like']!.image(
                      height: 18,
                      width: 18,
                    ),
                    6.horizontalSpace,
                    Text(
                      (initialReaction ?? 'like').capitalize(),
                      style: appTheme(context).textTheme.headlineMedium!.copyWith(
                        color: widget.post.like != null ? Color(0xFF6662FF) : Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Assets.commentFilled.svg(
                height: 18
              ),
              6.horizontalSpace,
              Text(
                "Comment",
                style: appTheme(context).textTheme.headlineMedium
              )
            ],
          )
        ],
      ),
    );
  }
}
