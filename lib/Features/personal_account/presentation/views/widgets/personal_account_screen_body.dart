import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gyms/core/utils/gaps.dart';
import 'package:gyms/core/widgets/custom_button.dart';
import 'package:gyms/core/widgets/custom_cached_network_image.dart';
import 'package:gyms/features/personal_account/presentation/manager/cubit/get_profile_cubit.dart';
import 'package:hive/hive.dart';

import '../../../../../core/locale/app_localizations.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles2.dart';
import '../../../../auth/login/domain/entities/employee_entity.dart';
import 'custom_setting_row.dart';

class PersonalAccountScreenBody extends StatelessWidget {
  const PersonalAccountScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    late AppLocalizations locale;
    locale = AppLocalizations.of(context)!;
    var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);

    //var boxLogOut = Hive.box<int>(kLogoutOptionDataBox);
    if (box.get(kEmployeeDataBox) != null) {
      BlocProvider.of<GetProfileCubit>(context)
          .getProfile(box.get(kEmployeeDataBox)!.memId!.toString());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 15),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .80,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, kUpdateProfileScreenRoute);
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * .15,
                          height: MediaQuery.of(context).size.height * .07,
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12)),
                          child: CustomCashedNetworkImage(
                            imageUrl: box.get(kEmployeeDataBox) != null
                                ? box.get(kEmployeeDataBox)!.imgPath!
                                : "",
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.translate("welcome")!,
                            style: TextStyle(
                              color: const Color(0xff8b8989),
                              fontSize: 11.sp,
                            ),
                          ),
                          Text(
                            box.get(kEmployeeDataBox) != null
                                ? box.get(kEmployeeDataBox)!.name!
                                : " ",
                            style: TextStyle(
                                color: const Color(0xff4e4d4d),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Container(
                    //   width: 43,
                    //   height: 43,
                    //   decoration: BoxDecoration(
                    //       color: kPrimaryColor.withOpacity(0.2),
                    //       borderRadius: BorderRadius.circular(12)),
                    //   child: IconButton(
                    //     onPressed: () {
                    //       BlocProvider.of<BottomNavCubit>(context)
                    //           .navigationQueue
                    //           .addLast(BlocProvider.of<BottomNavCubit>(context)
                    //               .bottomNavIndex);
                    //       BlocProvider.of<BottomNavCubit>(context)
                    //           .updateBottomNavIndex(kEditProfileScreen);
                    //     },
                    //     icon: Icon(
                    //       Icons.edit,
                    //       color: kSecondaryColor,
                    //       size: 22.sp,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Gaps.vGap20,
              Text(
                locale.translate('setting')!,
                style: Styles.textStyle20.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
              const SizedBox(height: 15),
              // CustomSettingRow(
              //     text: locale.translate('notifications')!,
              //     path: 'assets/icon/notification_icon.png',
              //     function: () {
              //       Navigator.pushNamed(context, kNotificationScreenRoute);
              //     }),
              CustomSettingRow(
                  text: "الملف الشخصي",
                  path: 'assets/icon/user_id_icon.png',
                  function: () {
                    Navigator.pushNamed(context, kProfileScreenRoute);
                  }),
              CustomSettingRow(
                  text: "ارسال دعوة",
                  path: 'assets/icon/user_id_icon.png',
                  function: () {
                    Navigator.pushNamed(context, kSendInvitationScreenRoute);
                  }),
              // CustomSettingRow(
              //     text: "الأخبار",
              //     path: 'assets/icon/user_id_icon.png',
              //     function: () {
              //       Navigator.pushNamed(context, kNewsScreenRoute);
              //     }),
              CustomSettingRow(
                  text: locale.translate('about_app')!,
                  path: 'assets/icon/list_icon.png',
                  function: () {
                    Navigator.pushNamed(context, kAboutAppScreenRoute);
                  }),
              CustomSettingRow(
                  text: locale.translate('privacy_policy')!,
                  path: 'assets/icon/secure_icon.png',
                  function: () {
                    Navigator.pushNamed(context, kPrivacyAndPolicyScreenRoute);
                  }),
              CustomSettingRow(
                  text: "اشتركاتي",
                  path: 'assets/icon/list_icon.png',
                  function: () {
                    Navigator.pushNamed(context, kMySubscribtionsScreen);
                  }),
              CustomSettingRow(
                  text: "احصائياتي",
                  path: 'assets/icon/notification_icon.png',
                  function: () {
                    Navigator.pushNamed(context, kAllIndodyScreenRoute);
                  }),
              CustomSettingRow(
                  text: locale.translate('change_password')!,
                  path: 'assets/icon/lock_icon.png',
                  function: () {
                    Navigator.pushNamed(context, kChangePasswordScreenRoute);
                  }),
              // CustomSettingRow(
              //     text: "تغيير الصورة الشخصية",
              //     path: 'assets/icon/secure_icon.png',
              //     function: () {
              //       Navigator.pushNamed(context, kUpdateProfileScreenRoute);
              //     }),
              Gaps.vGap20,
              BlocBuilder<GetProfileCubit, GetProfileState>(
                builder: (context, state) {
                  if (state is getProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetProfileSuccessful) {
                    return state.data.logoutOption == 1
                        ? Center(
                            child: Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: CustomButton(
                              onTapAvailable: true,
                              buttonText: locale.translate('logout')!,
                              buttonTapHandler: () {
                                var box =
                                    Hive.box<EmployeeEntity>(kEmployeeDataBox);
                                box.clear();
                                Navigator.pushReplacementNamed(
                                    context, kLoginScreenRoute);
                              },
                              screenWidth:
                                  MediaQuery.of(context).size.width * .7,
                            ),
                          ))
                        : const SizedBox();
                  }

                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
