class FileUploadResponse {
  String? message;
  String? pathname;

  FileUploadResponse({this.message, this.pathname});

  FileUploadResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    pathname = json['pathname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['pathname'] = pathname;
    return data;
  }
}