import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/modules/dashboard/view/single_post.dart';
import 'package:appifylab_assessment/routes/route.dart';
import 'package:appifylab_assessment/utils/app_colors.dart';
import 'package:appifylab_assessment/utils/share_helper.dart';
import 'package:appifylab_assessment/widgets/swipe_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gen/assets.gen.dart';
import '../dashboard_bloc.dart';
import '../dashboard_event.dart';
import '../dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  DashboardBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DashboardBloc()..add(InitEvent()),
      child: BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, DashboardState state) {
    bloc ??= BlocProvider.of<DashboardBloc>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColor.primary,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+34, left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                Icon(
                  Icons.menu,
                  size: 24,
                  color: Colors.white,
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Python Developer Community',
                        style: appTheme(context).textTheme.headlineLarge!.copyWith(
                            color: Colors.white
                        ),
                      ),
                      SizedBox(height: 6,),
                      Text(
                        '#General',
                        style: appTheme(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SwipeRefresh(
              controller: bloc!.refreshController,
              onRefresh: ()=> bloc!.add(InitEvent()),
              onLoading: ()=> bloc!.getData(),
              children: [
                communityList(state)
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFFffffff),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 5  horizontally
                5.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        child: Row(
          children: [
              Expanded(
                child:
                InkWell(
                  onTap: (){},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.community.svg(
                        height: 18
                      ),
                      SizedBox(height: 4,),
                      Text(
                        'Community'
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child:
                InkWell(
                  onTap: ()=> bloc!.add(Logout()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.logout.svg(
                        height: 18
                      ),
                      SizedBox(height: 4,),
                      Text(
                        'Logout'
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget communityList(DashboardState state) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16).copyWith(
        top: 16
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey)
          ),
          child: Row(
            children: [
              Assets.userPng.image(
                height: 60,
                width: 54
              ),
              SizedBox(width: 16,),
              Expanded(
                child: Text(
                  'Write something here...',
                  style: appTheme().textTheme.headlineLarge!.copyWith(
                    color: Colors.grey
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: ()=> bloc!.add(CreatePost()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8
                    )
                  )
                ),
                child: Text(
                  'Post',
                  style: appTheme().textTheme.headlineLarge!.copyWith(
                    color: Colors.white
                  ),
                )
              )
            ],
          ),
        ),
        SizedBox(height: 30,),
        ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: state.allCommunities?.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return SinglePost(state.allCommunities![index]);
          },
        ),
      ],
    );
  }
}

