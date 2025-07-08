import 'package:appifylab_assessment/config/dependency.dart';
import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/model/auth.dart';
import 'package:appifylab_assessment/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';
import 'create_post_bloc.dart';
import 'create_post_event.dart';
import 'create_post_state.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreatePostBloc()..add(InitEvent()),
      child: BlocBuilder<CreatePostBloc, CreatePostState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, CreatePostState state) {
    final bloc = BlocProvider.of<CreatePostBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
         children: [
            Row(
              children: [
                TextButton(
                  onPressed: backPage,
                  child: Text(
                    'Close',
                    style: appTheme(context).textTheme.headlineLarge!.copyWith(color: Colors.grey, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Create Post",
                    style: appTheme(context).textTheme.headlineLarge!.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: () => bloc.add(CreatePost()),
                  child: Text(
                    'Create',
                    style: appTheme(
                      context,
                    ).textTheme.headlineLarge!.copyWith(color: Color(0xFF6662FF), fontSize: 20),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Form(
                key: bloc.formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      32.verticalSpace,
                      Container(
                        decoration: BoxDecoration(
                          gradient: bloc.state.selectedGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(

                          controller: bloc.postContent,
                          style: appTheme(context).textTheme.bodyLarge!.copyWith(fontSize: 16,
                          color: bloc.state.selectedGradient == null || gradientsColor.first == state.selectedGradient ||  gradientsColor.last == state.selectedGradient? Colors.black : Colors.white),
                          maxLines: 6,
                          autofocus: true,
                          cursorColor: Colors.red,
                          validator: (text) {
                            if ((text ?? '').isEmpty) {
                              return "Please write what's on your mind";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.all(16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintText: "What's on your mind?",
                            hintStyle: appTheme(context).textTheme.bodyLarge!.copyWith(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ),
                      32.verticalSpace,
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 8,
                        runSpacing: 16,
                        children: gradientsColor
                            .map(
                              (e) => Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              gradient: e,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: InkWell(
                              onTap: () => bloc.add(GradientColorChangeEvent(e)),
                              child: bloc.state.selectedGradient == e ? Icon(Icons.check, color: AppColor.primary) : null,
                            ),
                          ),
                        )
                            .toList(),
                      ),
                      32.verticalSpace,
                     GridView(
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         mainAxisSpacing: 8,
                         crossAxisSpacing: 8,
                         childAspectRatio: 2.6,
                       ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [

                          InkWell(
                           // onTap: () => bloc.add(CreatePostEvent(fileType: "video")),
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  10.horizontalSpace,
                                  Assets.image02.svg(
                                    height: 24,
                                    width: 24,
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "Photo Gallery",
                                    style: appTheme(context).textTheme.titleMedium,),
                                  10.horizontalSpace,
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                           // onTap: () => bloc.add(CreatePostEvent(fileType: "video")),
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  10.horizontalSpace,
                                  Assets.videoAi.svg(
                                    height: 24,
                                    width: 24,
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "Video Gallery",
                                    style: appTheme(context).textTheme.titleMedium,),
                                  10.horizontalSpace,
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                           // onTap: () => bloc.add(CreatePostEvent(fileType: "video")),
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  10.horizontalSpace,
                                  Assets.camera01.svg(
                                    height: 24,
                                    width: 24,
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "Capture Photo",
                                    style: appTheme(context).textTheme.titleMedium,),
                                  10.horizontalSpace,
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                           // onTap: () => bloc.add(CreatePostEvent(fileType: "video")),
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  10.horizontalSpace,
                                  Assets.video02.svg(
                                    height: 24,
                                    width: 24,
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "Capture Video",
                                    style: appTheme(context).textTheme.titleMedium,),
                                  10.horizontalSpace,
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                           // onTap: () => bloc.add(CreatePostEvent(fileType: "video")),
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  10.horizontalSpace,
                                  Assets.fileAttachment.svg(
                                    height: 24,
                                    width: 24,
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "File",
                                    style: appTheme(context).textTheme.titleMedium,
                                  ),
                                  10.horizontalSpace,
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                           // onTap: () => bloc.add(CreatePostEvent(fileType: "video")),
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  10.horizontalSpace,
                                  Assets.analytics01.svg(
                                    height: 24,
                                    width: 24,
                                  ),
                                  10.horizontalSpace,
                                  Text(
                                    "Poll",
                                    style: appTheme(context).textTheme.titleMedium,
                                  ),
                                  10.horizontalSpace,
                                ],
                              ),
                            ),
                          ),
                        ],
                     ),
                      32.verticalSpace,
                      CheckboxListTile(
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        checkboxScaleFactor: 1.3,
                        contentPadding: EdgeInsets.zero,
                        value: bloc.state.isAnonymous?? false,
                        onChanged: (value) => bloc.add(AnonymousChangeEvent(value!)),
                        title: Text(
                          "Post Anonymously",
                          style: appTheme(context).textTheme.bodyLarge!.copyWith(fontSize: 16),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      )
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
