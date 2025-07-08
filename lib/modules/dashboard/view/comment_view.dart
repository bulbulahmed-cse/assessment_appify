import 'package:appifylab_assessment/model/communities.dart';
import 'package:appifylab_assessment/modules/dashboard/dashboard_bloc.dart';
import 'package:appifylab_assessment/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../../model/comment.dart';
import '../../../repository/post_repository.dart';
import '../../../utils/app_colors.dart';
import '../dashboard_event.dart';

class CommentSection extends StatefulWidget {
  final Communities post;
  final PostRepository repository;
  final DashboardBloc bloc;
  final bool? isReply;
  final String feedId;


  const CommentSection({
    required this.post,
    required this.bloc,
    required this.repository,
    required this.feedId,
    this.isReply = false,
    super.key,
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  late Future<List<Comment>> futureCache;
  final TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    futureCache = widget.repository.getComments(feedId: widget.feedId, isReply: widget.isReply ?? false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCache,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return Column(
          children: [
            widget.isReply == true
                ? buildCommentItem(
              post: widget.post,
              repository: widget.repository,
              bloc: widget.bloc,
              isReply: widget.isReply,
              feedId: widget.feedId,
              asyncSnapshot: snapshot,
            )
                : Expanded(
              child: buildCommentItem(
                post: widget.post,
                repository: widget.repository,
                bloc: widget.bloc,
                isReply: widget.isReply,
                feedId: widget.feedId,
                asyncSnapshot: snapshot,
              ),
            ),
            8.verticalSpace,
            if(!widget.isReply!)
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Write a comment...",
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            onSubmitted: (value) {

                            },
                          ),
                        ),
                        SizedBox(
                          width: 70.w,
                          child: ElevatedButton(
                            onPressed: () {
                              if(commentController.text.isNotEmpty) {
                                widget.bloc.add(
                                  CreateCommentEvent(
                                    commentText: commentController.text,
                                    feedId: widget.post.id.toString(),
                                    isReply: widget.isReply ?? false,
                                    parentId: widget.feedId,
                                    feedUserId: widget.post.user?.id.toString(),
                                    then: (){
                                      commentController.clear();
                                      futureCache = widget.repository.getComments(feedId: widget.feedId, isReply: false);
                                      setState(() {});
                                    }
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            ),
                            child: Assets.vector.svg(height: 22.w, width: 22.w),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildCommentItem({
    required Communities post,
    required PostRepository repository,
    required DashboardBloc bloc,
    final bool? isReply,
    required String feedId,
    required AsyncSnapshot asyncSnapshot,
  }) {
    return ListView.separated(
      shrinkWrap: isReply ?? false,
      physics: isReply ?? false ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => 10.verticalSpace,
      padding: EdgeInsets.all(16.w).copyWith(left: (isReply??false)?30.w:16.w),
      itemCount: (asyncSnapshot.data as List<Comment>).length,
      itemBuilder: (context, index) {
        Comment comment = (asyncSnapshot.data as List<Comment>)[index];
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: comment.user?.profilePic ?? '',
                      height: 34,
                      width: 34,
                      placeholder: (context, url) => Assets.userPng.image(height: 34, width: 34),
                      errorWidget: (context, url, error) => Assets.userPng.image(height: 34, width: 34),
                      fit: BoxFit.cover,
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.user?.fullName ?? '',
                          style: appTheme(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
                        ),
                        4.verticalSpace,
                        Text(
                          comment.commentTxt ?? '',
                          style: appTheme(context).textTheme.bodyLarge!.copyWith(color: Colors.black54),
                        ),
                        4.verticalSpace,
                        Row(
                          children: [
                            Text(
                              (comment.createdAt ?? DateTime.now().toString()).timeEgo,
                              style: appTheme(context).textTheme.bodyMedium!.copyWith(color: Colors.black54),
                            ),
                            8.horizontalSpace,
                            InkWell(
                              onTap: () {
                                // widget.bloc.add(
                                //   SelectReplyEvent(
                                //     id: comment.id.toString(),
                                //     name: comment.user?.fullName ?? '',
                                //   )
                                // );
                                // Handle reply action
                              },
                              child: Text(
                                "Reply",
                                style: appTheme(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(color: Color(0xFF6662FF), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (comment.replyCount != null && comment.replyCount! > 0)
              CommentSection(
                post: post,
                bloc: bloc,
                repository: repository,
                isReply: true,
                feedId: comment.id.toString(),
              ),
          ],
        );
      },
    );
  }
}



