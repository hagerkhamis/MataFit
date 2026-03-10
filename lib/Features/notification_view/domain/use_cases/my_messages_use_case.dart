
import '../../data/data_sources/remote_data_source/all_messages_remote_data_source.dart';

import '../repositories/my_messages_repo.dart';

abstract class UseCase<type, Param> {
  Future<AllMessagesResponse> callAllMessages(String userId, String seen);
}

class MyMessagesUseCase extends UseCase<AllMessagesResponse, void> {
  final MessagesRepo myMessagesRepository;
  MyMessagesUseCase(this.myMessagesRepository);
  @override
  Future<AllMessagesResponse> callAllMessages(
      String userId, String seen) async {
    return await myMessagesRepository.fetchAllMessages(userId, seen);
  }



 


}
