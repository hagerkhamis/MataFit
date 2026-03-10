import 'package:gyms/features/my_subscribtions/data/data_sources/my_subscribtions_remote_data_source.dart';
import 'package:gyms/features/my_subscribtions/data/data_sources/stoped_subscribtions_remote_data_source.dart';

abstract class MySubscribtionsRepo {
  Future<MySubscribtionsResponse> fetchMySubscribtions();
  Future<StopedSubscribtionsResponse> stopedSubscribtions(
      fromDate, subId, reason, numDays, typeFK);
}
