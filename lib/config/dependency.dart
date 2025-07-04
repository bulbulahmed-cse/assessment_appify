import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency.config.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
GetIt instance = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)

void configureInjection() {
  GetIt.I.allowReassignment = true;
  init(instance,environment: Environment.dev);
}
