import 'package:flutter_bloc_demo/configs.dart';
import 'package:flutter_bloc_demo/utils/package_info.dart';

Future<PackageInfo> getPackageInfo() {
  return PackageInfo.fromPlatform();
}

String getEnvBuild() {
  if (const bool.fromEnvironment('dart.vm.product') == true) {
    return 'R';
  } else {
    return 'D + ${buildFlavor.toString().split('.').last}';
  }
}

Future<void> appSetup() async {
  final packageInfo = await getPackageInfo();
  appVersion =
      '${packageInfo.version}+${packageInfo.buildNumber} ${getEnvBuild()}';
}
