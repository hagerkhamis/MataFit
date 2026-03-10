import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyms/core/widgets/custom_simple_app_bar.dart';
import 'package:gyms/core/widgets/empty_widget.dart';
import 'package:gyms/features/notification_view/data/models/my_messages_model/datum.dart';
import 'package:gyms/features/notification_view/presentation/manager/my_messages_cubit.dart';
import 'package:gyms/features/notification_view/presentation/views/widgets/all_messages_list_item.dart';
import 'package:hive/hive.dart';

import '../../../../../core/locale/app_localizations.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/media_query_sizes.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../core/widgets/error_text.dart';
import '../../../../auth/login/domain/entities/employee_entity.dart';
import '../../../../bottom_nav/presentation/manger/cubit/bottom_nav_cubit.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    getNotSeenMessages(context);
    late AppLocalizations locale;
    locale = AppLocalizations.of(context)!;
    SizeConfig().init(context);
    var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // CustomAppBar(
            //   icon: const Icon(Icons.arrow_forward),
            //   function: () {
            //     Navigator.pop(context);
            //   },
            // ),

            BlocBuilder<MyMessagesCubit, MyMessagesState>(
              builder: (context, state) {
                if (state is FetchSuccessful) {
                  AllMessagesList messagesList = state.data!;

                  return Column(
                    children: [
                      // Gaps.vGap30,
                      RefreshIndicator(
                        onRefresh: () async {
                          return getNotSeenMessages(context);
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                BlocProvider.of<BottomNavCubit>(context)
                                    .navigationQueue
                                    .addLast(
                                        BlocProvider.of<BottomNavCubit>(context)
                                            .bottomNavIndex);
                                BlocProvider.of<BottomNavCubit>(context)
                                  ..updateBottomNavIndex(
                                    kMessagesDetailsView,
                                  )
                                  ..getMessageId(
                                      state.data![index].msgId.toString());
                              },
                              child: AllMessagesListItem(
                                messagesList: messagesList,
                                itemIndex: index,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is FetchLoading) {
                  return const Center(
                    child: CustomLoadingWidget(
                      loadingText: "جاري تحميل الرسائل",
                    ),
                  );
                } else if (state is FetchFailed) {
                  return EmptyWidget(
                    text: state.message,
                  );
                } else if (box.get(kEmployeeDataBox) == null) {
                  return ErrorText(
                      image: "assets/images/should_login.png",
                      text: AppLocalizations.of(context)!
                          .translate('you_should_login_first')!);
                } else {
                  return const ErrorText(text: "حدث خطأ ما");
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> getNotSeenMessages(context) async {
    var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);

    if (box.get(kEmployeeDataBox) != null) {
      await BlocProvider.of<MyMessagesCubit>(context)
          .getAllMessages(box.get(kEmployeeDataBox)!.memId.toString(), "0");
    }
  }
}
