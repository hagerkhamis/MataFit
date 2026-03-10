
import '../../domain/repositories/my_messages_repo.dart';
import '../data_sources/remote_data_source/all_messages_remote_data_source.dart';


class MessagesRepositoryImp extends MessagesRepo {
  final AllMessagesRemoteDataSource myMessagesRemoteDataSource;


  MessagesRepositoryImp(
      this.myMessagesRemoteDataSource,
    );

  @override
  Future<AllMessagesResponse> fetchAllMessages(
      String userId, String seen) async {
    var userData =
        await myMessagesRemoteDataSource.fetchAllMessages(userId, seen);

    return userData;
  }




}
