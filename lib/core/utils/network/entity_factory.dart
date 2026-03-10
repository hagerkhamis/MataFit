import 'package:gyms/features/app_home/data/models/ads_model/ads_model.dart';
import 'package:gyms/features/app_home/data/models/my_services_model/my_services_model.dart';
import 'package:gyms/features/auth/register/data/models/register_model/branches_model.dart';
import 'package:gyms/features/captains/data/models/captains_model.dart';
import 'package:gyms/features/inbody/data/models/my_inbody_model.dart';

import 'package:gyms/features/introduction/data/models/my_services_model/my_intro_model.dart';
import 'package:gyms/features/my_subscribtions/data/models/my_messages_model/my_subscribtions_model.dart';

import 'package:gyms/features/new_bsama_add_Fingerprint/data/models/finger_print_model/new_finger_print_model.dart';
import 'package:gyms/features/notification_view/data/models/my_messages_model/my_messages_model.dart';
import 'package:gyms/features/offers/data/models/add_offer_model.dart';
import 'package:gyms/features/offers/data/models/my_messages_model/my_offers_model.dart';

import 'package:gyms/features/privacy_and_policy/data/models/privacy_and_policy_model.dart';

import 'package:gyms/features/news/data/models/my_news_model.dart';
import 'package:gyms/features/subscribtions/data/models/delete_and_add_model.dart';
import 'package:gyms/features/subscribtions/data/models/my_messages_model/subscribtions_model.dart';

import '../../../features/about_app/data/models/about_app_model/about_app_model.dart';
import '../../../features/auth/fire_base_token/data/models/token_model.dart';
import '../../../features/auth/login/data/models/login_model/login_model/employee_model.dart';
import '../../../features/auth/register/data/models/register_model/register_model.dart';
import '../../../features/calender/data/models/calender_model/calender_model.dart';
import '../../../features/exercises/data/models/my_messages_model/exercise_cat_model.dart';
import '../../../features/exercises/data/models/my_messages_model/exercise_model.dart';
import 'base_response/general_response.dart';
import 'net_response.dart';

class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (T.toString() == "BaseResponse") {
      return BaseResponse.fromJson(json) as T;
    } else if (T.toString() == "GeneralResponse") {
      return GeneralResponse.fromJson(json) as T;
    } else if (T.toString() == "EmployeeModel") {
      return EmployeeModel.fromJson(json) as T;
    } else if (T.toString() == "TokenModel") {
      return TokenModel.fromJson(json) as T;
    } else if (T.toString() == "CalenderModel") {
      return CalenderModel.fromJson(json) as T;
    } else if (T.toString() == "RegisterModel") {
      return RegisterModel.fromJson(json) as T;
    } else if (T.toString() == "AboutAppModel") {
      return AboutAppModel.fromJson(json) as T;
    } else if (T.toString() == "PrivacyAndPolicyModel") {
      return PrivacyAndPolicyModel.fromJson(json) as T;
    }else if (T.toString() == "MyTa3memModel") {
      return MyNewsModel.fromJson(json) as T;
    } else if (T.toString() == "MyServicesModel") {
      return MyServicesModel.fromJson(json) as T;
    } else if (T.toString() == "MyIntroModel") {
      return MyIntroModel.fromJson(json) as T;
    } else if (T.toString() == "NewFingerPrintModel") {
      return NewFingerPrintModel.fromJson(json) as T;
    } else if (T.toString() == "BranchesModel") {
      return BranchesModel.fromJson(json) as T;
    } else if (T.toString() == "MyNewsModel") {
      return MyNewsModel.fromJson(json) as T;
    } else if (T.toString() == "MyOffersModel") {
      return MyOffersModel.fromJson(json) as T;
    } else if (T.toString() == "AddOfferModel") {
      return AddOfferModel.fromJson(json) as T;
    } else if (T.toString() == "ExerciseCatModel") {
      return ExerciseCatModel.fromJson(json) as T;
    } else if (T.toString() == "ExerciseModel") {
      return ExerciseModel.fromJson(json) as T;
    } else if (T.toString() == "SubscribtionsModel") {
      return SubscribtionsModel.fromJson(json) as T;
    } else if (T.toString() == "AdsModel") {
      return AdsModel.fromJson(json) as T;
    } else if (T.toString() == "CaptainsModel") {
      return CaptainsModel.fromJson(json) as T;
    } else if (T.toString() == "MyMessagesModel") {
      return MyMessagesModel.fromJson(json) as T;
    } else if (T.toString() == "MySubscribtionsModel") {
      return MySubscribtionsModel.fromJson(json) as T;
    } else if (T.toString() == "DeleteAndAddModel") {
      return DeleteAndAddModel.fromJson(json) as T;
    } else if (T.toString() == "MyInbodyModel") {
      return MyInbodyModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
