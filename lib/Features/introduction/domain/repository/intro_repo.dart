import 'package:gyms/features/introduction/data/dat_source/remote_data_source/all_intro_remote_data_source.dart';

abstract class IntroRepository {
  Future<AllIntroResponse> fetchAllServices();
}
