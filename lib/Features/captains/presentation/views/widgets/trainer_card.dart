import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gyms/core/utils/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gyms/core/widgets/custom_image.dart';
import 'package:gyms/features/captains/presentation/views/widgets/trainer_info.dart';
import 'package:gyms/features/captains/domain/entities/captains_entity.dart';

class TrainerCard extends StatelessWidget {
  const TrainerCard({
    super.key,
    required this.captainsEntity,
  });

  final CaptainsEntity captainsEntity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: CachedNetworkImage(
            imageUrl: captainsEntity.imagePath ?? "",
            height: 200,
            fit: BoxFit.fill,
            width: 400,
            placeholder: (context, url) => const BlankImageWidget(),
            errorWidget: (context, url, error) => const BlankImageWidget(),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 7,
          bottom: -10,
          child: CircleAvatar(
            backgroundColor: kPrimaryColor,
            child: SvgPicture.asset(
              "assets/images/Group.svg",
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 7,
          bottom: -60,
          child: TrainerInfo(
            name: captainsEntity.name ?? "",
            role: 'مدرب أول',
          ),
        ),
      ],
    );
  }
}
