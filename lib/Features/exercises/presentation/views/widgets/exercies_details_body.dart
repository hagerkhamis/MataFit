import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gyms/core/utils/constants.dart';
import 'package:gyms/core/utils/gaps.dart';
import 'package:gyms/features/exercises/presentation/views/widgets/exercise_info_card.dart';

import '../../../domain/entities/exercise_entity.dart';

class ExerciesDetailsBody extends StatelessWidget {
  final ExerciseEntity exerciseEntity;

  const ExerciesDetailsBody({super.key, required this.exerciseEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 16),
        //   child: CustomAppBar(
        //     title: "تفاصيل التمرين",
        //   ),
        // ),
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    FontAwesomeIcons.circleArrowLeft,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                      value: progress.progress, color: kPrimaryColor),
                ),
                imageUrl: exerciseEntity.mainImage!,
                height: 200,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 50,
                ),
                SvgPicture.asset(
                  "assets/images/clock.svg",
                  height: 15,
                  color: Colors.grey[800],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${exerciseEntity.restInSec} ثانية',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),

                const SizedBox(
                  width: 25,
                ),
                Text(
                  '|',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                // const SizedBox(height: 4),
                SvgPicture.asset(
                  "assets/images/calories.svg",
                  height: 15,
                  color: Colors.grey[700],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${exerciseEntity.tkrar} مرة  ',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),

                const SizedBox(
                  width: 50,
                ),
              ],
            ),
          ),
        ),
        Gaps.vGap30,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ExerciseInfoCard(title: 'الهدف', value: 'خسارة '),
              ExerciseInfoCard(title: 'القسم', value: exerciseEntity.catName!),
              ExerciseInfoCard(
                  title: 'المستوى', value: exerciseEntity.tamrenFor!),
            ],
          ),
        ),
        Gaps.vGap30,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exerciseEntity.title!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(exerciseEntity.instructions!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 12.0,

                    // letterSpacing: 1.0,
                    //     height: 2.5 //You can set your custom height here
                  )),
              const SizedBox(height: 150),
            ],
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 24),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       ElevatedButton(
        //         onPressed: () {},
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.red,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //         ),
        //         child: const Text(
        //           'المواعيد',
        //           style: TextStyle(color: Colors.white, fontSize: 16),
        //         ),
        //       ),
        //       Text(
        //         '3 أسابيع - 20 تمرين',
        //         style: TextStyle(
        //           fontSize: 20,
        //           color: Colors.grey[700],
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
  //
}
