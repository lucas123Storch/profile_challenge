import 'package:profile_challenge/models/app_config.dart';

const bool isProduction = bool.fromEnvironment("dart.vm.product");

AppConfig testConfig = AppConfig(
  webAppUrl: "https://clipe-backend.herokuapp.com/api/v1",
);

AppConfig productionConfig = AppConfig(
  webAppUrl: "https://clipe-backend.herokuapp.com/api/v1",
);

AppConfig environment = isProduction ? productionConfig : testConfig;
