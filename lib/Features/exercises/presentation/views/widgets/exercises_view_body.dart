import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyms/features/bottom_nav/presentation/manger/cubit/bottom_nav_cubit.dart';
import 'package:gyms/features/exercises/data/models/my_messages_model/exercise.dart';
import 'package:gyms/features/exercises/data/models/my_messages_model/exercise_cat.dart';
import 'package:gyms/features/exercises/presentation/manager/exercise_cat_cubit/exercise_cat_cubit.dart';
import 'package:gyms/core/utils/gaps.dart';
import 'package:gyms/features/app_home/presentation/views/widgets/custom_tab_button.dart';
import 'package:gyms/features/exercises/presentation/views/widgets/exercise_card.dart';
import 'package:hive/hive.dart';
import 'package:gyms/core/widgets/empty_widget.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../auth/login/domain/entities/employee_entity.dart';
import '../../manager/exercise_cubit/exercise_cubit.dart';

// ignore: must_be_immutable
class ExercisesViewBody extends StatefulWidget {
  const ExercisesViewBody({super.key});

  @override
  State<ExercisesViewBody> createState() => _ExercisesViewBodyState();
}

class _ExercisesViewBodyState extends State<ExercisesViewBody> {
  var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);
  int activeIndex = 0;

  @override
  void initState() {
    _onInit();
    super.initState();
  }

  void _onInit() async {
    if (box.get(kEmployeeDataBox) != null) {
      await BlocProvider.of<ExerciseCatCubit>(context)
          .getAllExerciseCat(box.get(kEmployeeDataBox)!.memId!.toString());
      await BlocProvider.of<ExerciseCubit>(context).getAllExercise("4");
    }
  }

  @override
  Widget build(BuildContext context) {
    //  getAllMessages(context);

    return Column(
      children: [
        Gaps.vGap10,
        SizedBox(
          height: 40,
          child: BlocBuilder<ExerciseCatCubit, ExerciseCatState>(
            builder: (context, state) {
              if (state is FetchExerciseCatSuccessful) {
                AllExercisesCatList catsList = state.data!;

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: GestureDetector(
                          onTap: () {
                            activeIndex = index;
                            setState(() {});

                            BlocProvider.of<ExerciseCubit>(context)
                                .getAllExercise(
                                    catsList[index].catId.toString());
                          },
                          child: CustomTabButton(
                            selected: activeIndex == index,
                            label: catsList[index].catName!,
                          ),
                        ),
                      );
                    });
              } else if (state is FetchExerciseCatLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchExerciseCatFailed) {
                return const SizedBox();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Gaps.vGap10,
        SizedBox(
          height: 500,
          child: BlocBuilder<ExerciseCubit, ExerciseState>(
            builder: (context, state) {
              if (state is FetchSuccessful) {
                AllExercisesList offersList = state.data!;

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, kExercisesDetailsScreenRoute);

                        BlocProvider.of<BottomNavCubit>(context)
                            .getDetails(state.data![index]);

                        BlocProvider.of<BottomNavCubit>(context)
                            .getList(state.data);
                      },
                      child: ExerciseCard(
                        offersList: offersList[index],
                      ),
                    );
                  },
                );
              } else if (state is FetchLoading) {
                return const Center(
                  child: CustomLoadingWidget(
                    loadingText: "جاري تحميل التمارين",
                  ),
                );
              } else if (state is FetchFailed) {
                return const EmptyWidget(
                  text: "لا يوجد تمارين",
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
