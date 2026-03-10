// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import '../../../data/models/news.dart';
import '../../../domain/use_cases/news_use_case.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsUseCase newsUseCase;
  NewsCubit(this.newsUseCase) : super(NewsInitial());

  Future<void> getAllNews(String userId) async {
    emit(const FetchLoading());
    final result = await newsUseCase.callAllNews(userId);

    emit(result.fold(FetchFailed.new, FetchSuccessful.new));
  }
}
