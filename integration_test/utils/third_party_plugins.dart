import 'package:firebase_core/firebase_core.dart';
import 'package:focus_box/firebase_options.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> setupThirdPartyDependencies() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
