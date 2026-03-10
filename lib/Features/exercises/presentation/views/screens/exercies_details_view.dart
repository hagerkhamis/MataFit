import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyms/features/exercises/domain/entities/exercise_entity.dart';
import 'package:gyms/features/exercises/presentation/views/widgets/exercies_details_body.dart';

import '../../../../bottom_nav/presentation/manger/cubit/bottom_nav_cubit.dart';

class ExerciesDetailsView extends StatelessWidget {
  const ExerciesDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    ExerciseEntity exerciseEntity;

    exerciseEntity = BlocProvider.of<BottomNavCubit>(context).details!;

    return SafeArea(
      child: Scaffold(
        body: ExerciesDetailsBody(exerciseEntity: exerciseEntity),
      ),
    );
  }
}
