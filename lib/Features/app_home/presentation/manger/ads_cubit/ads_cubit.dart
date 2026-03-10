// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:gyms/features/app_home/data/models/ads_model/ads_model.dart';
import 'package:gyms/features/app_home/domain/use_cases/finger_print_use_case.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  FingerPrintUseCase servicesUseCase;
  AdsCubit(this.servicesUseCase) : super(AdsInitialal());

  Future<void> getAllAdsList() async {
    emit(const FetchAdsLoading());
    final result = await servicesUseCase.fetchAllAds();

    emit(result.fold(FetchAdsFailed.new, FetchAdsSuccessful.new));
  }
}
