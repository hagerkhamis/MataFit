// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:gyms/features/notification_view/data/models/my_messages_model/datum.dart';
import 'package:gyms/features/notification_view/domain/use_cases/my_messages_use_case.dart';

part 'my_messages_state.dart';

class MyMessagesCubit extends Cubit<MyMessagesState> {
  MyMessagesUseCase myMessagesUseCase;
  MyMessagesCubit(this.myMessagesUseCase) : super(MyMessagesInitial());

  Future<void> getAllMessages(String userId, String seen) async {
    emit(const FetchLoading());
    final result = await myMessagesUseCase.callAllMessages(userId, seen);

    emit(result.fold(FetchFailed.new, FetchSuccessful.new));
  }
}
