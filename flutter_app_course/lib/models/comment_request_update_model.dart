class CommentRequestUpdateModel {
  int? id;
  String? subject;
  String? comment;

  CommentRequestUpdateModel({this.id, this.subject, this.comment});

  CommentRequestUpdateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject'] = subject;
    data['comment'] = comment;
    return data;
  }
}
