class ErrorMessageModel {
  bool? success;
  String? message; 
  List<ErrorSources>? errorSources;
  Err? err;
  String? stack;

  ErrorMessageModel(
      {this.success, this.message, this.errorSources, this.err, this.stack});

  ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['errorSources'] != null) {
      errorSources = <ErrorSources>[];
      json['errorSources'].forEach((v) {
        errorSources!.add(ErrorSources.fromJson(v));
      });
    }
    err = json['err'] != null ? Err.fromJson(json['err']) : null;
    stack = json['stack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (errorSources != null) {
      data['errorSources'] = errorSources!.map((v) => v.toJson()).toList();
    }
    if (err != null) {
      data['err'] = err!.toJson();
    }
    data['stack'] = stack;
    return data;
  }
}

class ErrorSources {
  String? path;
  String? message;

  ErrorSources({this.path, this.message});

  ErrorSources.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['message'] = message;
    return data;
  }
}

class Err {
  int? statusCode;

  Err({this.statusCode});

  Err.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    return data;
  }
}
