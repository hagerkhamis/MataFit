import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:gyms/features/personal_account/presentation/manager/cubit/get_profile_cubit.dart';
import 'package:gyms/core/utils/gaps.dart';
import 'package:gyms/core/utils/hex_color.dart';
import 'package:gyms/core/widgets/custom_cached_network_image.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../auth/login/domain/entities/employee_entity.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({super.key});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);

  @override
  void initState() {
    _onInit();
    super.initState();
  }

  void _onInit() async {
    await BlocProvider.of<GetProfileCubit>(context)
        .getProfile(box.get(kEmployeeDataBox)!.memId!.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<GetProfileCubit, GetProfileState>(
          builder: (context, state) {
            if (state is getProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetProfileSuccessful) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, kUpdateProfileScreenRoute);
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width * .49,
                        height: MediaQuery.of(context).size.height * .30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: kPrimaryColor),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              //width: MediaQuery.of(context).size.width * .49,
                              height: MediaQuery.of(context).size.height * .006,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: HexColor("#ffee2b"),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .49,
                              height: MediaQuery.of(context).size.height * .22,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: HexColor("#ffee2b"),
                                  borderRadius: BorderRadius.circular(100)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: CustomCashedNetworkImage(
                                    imageUrl: state.data.data.imgPath!,
                                    width:
                                        MediaQuery.of(context).size.width * .48,
                                    height: MediaQuery.of(context).size.height *
                                        .212,
                                  )),
                            ),
                          ],
                        ),
                      ),

                      // Container(
                      //     width: MediaQuery.of(context).size.width * .5,
                      //     height: MediaQuery.of(context).size.height * .25,
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         color: kPrimaryColor,
                      //         borderRadius: BorderRadius.circular(100)),
                      //     child: CustomCashedNetworkImage(
                      //       imageUrl: box.get(kEmployeeDataBox) != null
                      //           ? box.get(kEmployeeDataBox)!.image!
                      //           : "",
                      //       width: MediaQuery.of(context).size.width * .45,
                      //       height: MediaQuery.of(context).size.height * .2,
                      //     )),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     CustomCashedNetworkImage(
                  //       width: 100,
                  //       height: 100,
                  //       imageUrl: box.get(kEmployeeDataBox) != null
                  //           ? box
                  //               .get(kEmployeeDataBox)!
                  //               .empSignature!
                  //           : "",
                  //     ),
                  //   ],
                  // ),

                  Gaps.vGap30,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الإسـم  : ${state.data.data.name.toString()}",
                        style: TextStyle(
                            //    color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w900),
                      ),
                      Gaps.vGap10,
                      Text(
                        "الكـود  : ${state.data.data.mCode.toString()}",
                        style: TextStyle(
                            //         color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w900),
                      ),
                      Gaps.vGap10,
                      Text(
                        "الفرع : ${state.data.data.branchName.toString()}",
                        style: TextStyle(
                            //    color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w900),
                      ),
                      Gaps.vGap10,
                      Text(
                        "الجـوال : ${state.data.data.phone.toString()}",
                        style: TextStyle(
                            //    color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),

                  Gaps.vGap10,

                  // state.data.data.qrcodePath != null
                  //     ? CustomCashedNetworkImage(
                  //         imageUrl:
                  //             "${NewApi.imageBaseUrl}${state.data.data.qrcodePath!}",
                  //         width: MediaQuery.of(context).size.width * .55,
                  //         height: MediaQuery.of(context).size.height * .18,
                  //       )
                  //     : const SizedBox(),
                  Gaps.vGap5,
                  CustomCashedNetworkImage(
                    imageUrl: "${state.data.data.barcodePath!}",
                    width: MediaQuery.of(context).size.width * .75,
                    height: MediaQuery.of(context).size.height * .18,
                  )
                  // Center(
                  //     child: Padding(
                  //   padding: EdgeInsets.only(bottom: 12.h),
                  //   child: CustomButton(
                  //     onTapAvailable: true,
                  //     buttonText: locale.translate('logout')!,
                  //     buttonTapHandler: () {
                  //       var box = Hive.box<EmployeeEntity>(
                  //           kEmployeeDataBox);
                  //       box.clear();
                  //       Navigator.pushReplacementNamed(
                  //           context, kCodeScreenRoute);
                  //     },
                  //     screenWidth:
                  //         MediaQuery.of(context).size.width * .7,
                  //   ),
                  // )),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
