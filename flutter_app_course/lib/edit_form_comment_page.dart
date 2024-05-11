import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/comment_provider.dart';

class EditFormComment extends StatefulWidget {
  final int id;
  const EditFormComment({required this.id, super.key});

  @override
  State<EditFormComment> createState() => _EditFormCommentState();
}

class _EditFormCommentState extends State<EditFormComment> {
  @override
  void initState() {
    super.initState();
    context.read<CommentProvider>().detailComment(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var commentProvider = context.watch<CommentProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Comment'),
      ),
      body: Form(
        key: commentProvider.formKey,
        child: ListView(
          children: [
            const Text(
              'Subject',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
                controller: commentProvider.subjectController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tolong isi field ini';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))))),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Comment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
                controller: commentProvider.commentController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tolong isi field ini';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))))),
            const SizedBox(
              height: 10,
            ),
            Text(commentProvider.messageError),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, elevation: 5),
              onPressed: () {
                context.read<CommentProvider>().updateComment(context);
              },
              child: const Text("Update",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            // bodyMessage()
          ],
        ),
      ),
    );
  }
}
