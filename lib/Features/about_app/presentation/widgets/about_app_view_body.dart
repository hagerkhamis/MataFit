import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/media_query_sizes.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../manager/cubit/about_app_cubit.dart';

class AboutAppViewBody extends StatelessWidget {
  const AboutAppViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AboutAppCubit>(context).getAboutAppData();
    SizeConfig().init(context);
    return Column(
      children: [
        BlocBuilder<AboutAppCubit, AboutAppState>(
          builder: (context, state) {
            if (state is AboutAppSuccessful) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 13.h, bottom: SizeConfig.screenHeight! * 0.05),
                        child: Text(state.data![0].appName!,
                            textAlign: TextAlign.right),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          state.data![0].aboutApp!,
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  )
                ],
              );
            } else if (state is AboutAppLoading) {
              return const CustomLoadingWidget();
            } else {
              return const CustomErrorWidget();
            }
          },
        )
      ],
    );
  }
}
