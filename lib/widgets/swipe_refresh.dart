import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../utils/app_colors.dart';
class SwipeRefresh extends StatelessWidget {
  final RefreshController controller;
  final VoidCallback onRefresh;
  final VoidCallback? onLoading;
  final List<Widget>? children;
  final Widget? child;
  final bool enablePullUp;
  final ScrollController? scrollController;
  final EdgeInsets? padding;
  const SwipeRefresh({required this.controller,required this.onRefresh,this.onLoading,this.children,this.child,this.enablePullUp=false,this.scrollController, this.padding, super.key});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      scrollController: scrollController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      header: WaterDropMaterialHeader(backgroundColor: AppColor.white,color: AppColor.primary,),
      footer: const ClassicFooter(
        noDataText: '',
        loadingIcon: CupertinoActivityIndicator(),
      ),
      enablePullDown: true,
      primary: false,
      enablePullUp: onLoading!=null ? true : false,
      controller: controller,
      child: child ?? ListView(
        padding: padding ?? EdgeInsets.zero,
        shrinkWrap: true,
        children: children ?? [],
      ),
    );
  }
}

