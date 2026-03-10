class Api {
  //base Url

  static const String mainAppUrl = "https://metafit.sa/";
  static const String baseUrl = "${mainAppUrl}qr_c/New_api/";

  static const String doServerLoginApiCall = "login_by_mobile";
  static const String doFireBasePhoneTokenApiCall = "insert_update_token";
  static const String doFingerPrintApiCall = "Basma_Today";
  static const String doNewMessageCall = "save_message";
  static const String doServerTablesApiCall = "Report_Basma";
  static const String doServerGetMessagesApiCall = "get_messages";

  static const String doServerCalenderApiCall = "report_calender";
}

class NewApi {
  static const String mainAppUrl = "https://metafit.sa/Api/";
  //static Box<CodeEntity> box = Hive.box<CodeEntity>(kCodeDataBox);

  static String get baseUrl => mainAppUrl;

  static String get imageBaseUrl => mainAppUrl;

  static const String doServerLoginApiCall = "login_app";
  static const String doServerRegisterApiCall = "register";
  static const String doServerChangePasswordApiCall = "update_pass";
  static const String doServerUpdateProfileApiCall = "update_profile_image";
  static const String doServerUpdateSignatureApiCall = "Add_signature";
  static const String doServerGetProfileApiCall = "getProfile";

  static const String doServerNewBasma = "add_hdor_ensraf";

  static const String doServerSendMessageApiCall = "SendMessage";
  static const String doServerAllMessageApiCall = "InboxMessages";
  static const String doServerSentMessageApiCall = "SentMessages";

  static const String doServerMessageDetailsApiCall = "ViewMessage";
  static const String doServerEmployeesApiCall = "AllEmplyees";
  static const String doServerSeenMessageApiCall = "SeenMessage";
  static const String doServerDeleteMessageApiCall = "DeleteMessage";

  static const String doServerAboutAppApiCall = "getAppinfo";
  static const String doServerPrivacyAndPolicyCall = "getAppPolicy";
  static const String doServerAlltypeOzonat = "Ozonat_types";
  static const String doServerAllBranches = "All_Branches";

  static const String doServerAddEzen = "Add_Ezn";
  static const String doServerAllEznApiCall = "Get_Ezn_List";
  static const String doServerDeleteEznApiCall = "Delete_ezn";
  static const String doServerEditEzen = "Edit_Ezn";
  static const String doServerWaredEznApiCall = "Get_Wared_Ezn_List";
  static const String doServerEgraaEznApiCall = "Egraa_ezn";

  static const String doServerAlltypeVacation = "Agazat_types";
  static const String doServerAddVacation = "Add_Agaza";
  static const String doServerAllVacationApiCall = "Get_agaza_List";
  static const String doServerDeleteVacationApiCall = "Delete_agaza";
  static const String doServerEditVacation = "Edit_Agaza";
  static const String doServerEgraaVacationApiCall = "Egraa_agaza";
//news
  static const String doServerGetNewsList = "All_News";

  //inBody

  static const String doServerGetInbodyList = "All_Inbody";

  //Captains
  static const String doServerGetCaptainsList = "All_Captains";
//offer
  static const String doServerGetOfferList = "All_Offers";
  static const String doServerAddFavOffer = "add_offer_favourite";

  //send invitation
  static const String doServerSendInvitation = "Add_invitation";

  //Exercises
  static const String doServerGetExercisesList = "All_Tmareen";
  static const String doServerExercisesCat = "All_Cats";

  //ads
  static const String doServerAdsList = "All_sliders";
//Subscribtions
  static const String doServerGetSubscribtions = "Subs_List";

  static const String doServerAddSubscribtions = "add_app_subs";

  static const String stopedServerSubscribtions = "add_stopped_subs";

  //my subscribtions
  static const String doServerGetMySubscribtions = "My_subs";

  ///
  static const String doServerSeenTa3mem = "SeenTa3mem";

  static const String doServerAddAnswerMosalat = "Add_mosala_response";

  static const String doServerGetLawa2hList = "Get_lawa2h_list";
  static const String doServerSeenLayha = "SeenLayha";

  static const String doServerGetEnzaratList = "Get_Enzarat_list";
  static const String doServerSeenEnzarat = "SeenEnzar";

  static const String doServerEvaluationTypes = "get_evaluation_types";
  static const String doServerAllEmpTaqeem = "All_Emp_Taqeem";
  static const String doServerAllManagerTaqeem = "All_Emp_Manager_Taqeem";
  static const String doServerAllBnodTaqeem = "get_all_bnod_taqeem";
  static const String addTaqeem = "AddTaqeem";
  static const String editTaqeem = "EditTaqeem";

  static const String lastTaqeem = "All_Taqeem_list";
  static const String myTaqeem = "My_Taqeem_list";

  static const String doServerMonth = "Months_List";

  static const String doServerEditTaqeem = "EditTaqeem";
  static const String doServerDeleteTaqeem = "Delete_Taqeem";
  static const String doSplashScreens = "GymSplashScreens";

  static const String doServerServicesList = "AppServices";
}

class CodeApi {
  static const String mainAppUrl = "https://metafit.sa/";
  static const String baseUrl = "${mainAppUrl}basma/Api/";
  static const String getCodeUrl = "All_Gym";
}
