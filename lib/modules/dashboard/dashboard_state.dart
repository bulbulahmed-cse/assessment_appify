import '../../model/communities.dart';

class DashboardState {
  List<Communities>? allCommunities;


  DashboardState({this.allCommunities});

  DashboardState init() {
    return DashboardState();
  }

  DashboardState clone({List<Communities>? allCommunities}) {
    return DashboardState(
      allCommunities: allCommunities ?? this.allCommunities
    );
  }
}
