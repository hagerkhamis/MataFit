typedef AboutAppDataList = List<Datum>?;

class Datum {
  String? appName;
  String? aboutApp;
  dynamic appLogo;

  Datum({this.appName, this.aboutApp, this.appLogo});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        appName: json['app_name'] as String?,
        aboutApp: json['about_app'] as String?,
        appLogo: json['app_logo'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'app_name': appName,
        'about_app': aboutApp,
        'app_logo': appLogo,
      };
}
