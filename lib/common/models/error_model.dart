class ErrorModel {
  int? statusCode;
  String? detail;
  String? notEnough;
  ErrorModel({this.statusCode, this.detail});

   ErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    detail = json['detail'];
    notEnough = json['not_enough'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = statusCode;
    json['detail'] = detail;
    json['not_enough'] = notEnough;
    return json;
  }
  
}
