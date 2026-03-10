import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyms/features/subscribtions/domain/entities/subscribtions_entity.dart';

import '../../../../../features/subscribtions/presentation/views/widgets/subscribtions_details_body.dart';
import '../../../../bottom_nav/presentation/manger/cubit/bottom_nav_cubit.dart';

class SubscribtionsDetailsView extends StatelessWidget {
  const SubscribtionsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    SubscribtionsEntity subscribtionsEntity;

    subscribtionsEntity = BlocProvider.of<BottomNavCubit>(context).details!;

    return SafeArea(
      child: Scaffold(
        body:
            SubscribtionsDetailsBody(subscribtionsEntity: subscribtionsEntity),
      ),
    );
  }
}
