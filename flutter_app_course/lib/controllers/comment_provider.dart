import 'package:flutter/material.dart';
import 'package:flutter_app_course/models/comment_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app_course/models/comment_request_model.dart';
import 'package:flutter_app_course/models/comment_response_model.dart';

import '../models/comment_request_update_model.dart';

class CommentProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  List<Data>? listComment;
  var state = CommentState.initial;
  var messageError = '';

  int idDataSelected = 0;

  Future getComment() async {
    try {
      var response = await Dio().get('http://10.0.2.2:8080/api/comment');
      var result = CommentModel.fromJson(response.data);
      if (result.data!.isEmpty) {
        state = CommentState.nodata;
      } else {
        state = CommentState.success;
        listComment = result.data;
      }
    } catch (e) {
      state = CommentState.error;
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future insertComment(
    BuildContext context,
  ) async {
    try {
      var requestModel = {
        "subject": subjectController.text,
        "comment": commentController.text
      };
      await Dio().post(
        'http://10.0.2.2:8080/api/comment',
        data: requestModel,
      );

      Navigator.pop(context);
      getComment();
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future detailComment(int id) async {
    try {
      messageError = '';
      var response = await Dio().get('http://10.0.2.2:8080/api/comment/$id');
      var result = CommentResponseModel.fromJson(response.data);
      idDataSelected = id;
      subjectController.text = result.data!.subject ?? '-';
      commentController.text = result.data!.comment ?? '-';
    } catch (e) {
      state = CommentState.error;
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future updateComment(
    BuildContext context,
  ) async {
    try {
      var requestModel = {
        "id": idDataSelected,
        "subject": subjectController.text,
        "comment": commentController.text
      };
      await Dio().put('http://10.0.2.2:8080/api/comment', data: requestModel);
      // var result = CommentResponseModel.fromJson(response.data);
      Navigator.pop(context);
      getComment();
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }

  Future deleteComment(BuildContext context, int id) async {
    try {
      await Dio().delete('http://10.0.2.2:8080/api/comment/$id');
      getComment();
    } catch (e) {
      messageError = e.toString();
    }
    notifyListeners();
  }
}

enum CommentState { initial, loading, success, error, nodata }
