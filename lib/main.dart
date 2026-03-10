import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyms/features/auth/login/domain/entities/employee_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:gyms/features/new_bsama_add_Fingerprint/domain/entities/new_finger_print_entity.dart';
import 'package:gyms/core/utils/simple_bloc_observer.dart';

import 'app.dart';
import 'core/utils/constants.dart';
import 'core/utils/functions/setup_service_locator.dart' as di;

void main() async {
// inside main
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await di.init();
  Hive.registerAdapter(EmployeeEntityAdapter());
  Hive.registerAdapter(NewFingerPrintEntityAdapter());

  await Hive.openBox<EmployeeEntity>(kEmployeeDataBox);
  await Hive.openBox<NewFingerPrintEntity>(kNewFingerPrintDataBox);
  await Hive.openBox('local_storage');
  await Hive.openBox<int>(kLogoutOptionDataBox);

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  runApp(const FingerPrint());
}
