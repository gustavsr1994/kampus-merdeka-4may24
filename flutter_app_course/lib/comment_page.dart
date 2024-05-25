import 'package:flutter/material.dart';
import 'package:flutter_app_course/controllers/comment_provider.dart';
import 'package:flutter_app_course/edit_form_comment_page.dart';
import 'package:flutter_app_course/form_comment_page.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void initState() {
    super.initState();
    context.read<CommentProvider>().getComment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Daftar Product'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormCommentPage(),
                ));
          },
          child: const Icon(Icons.add),
        ),
        body: bodyData(context, context.watch<CommentProvider>().state));
  }

  Widget bodyData(BuildContext context, CommentState state) {
    switch (state) {
      case CommentState.success:
        var dataResult = context.watch<CommentProvider>().listComment;
        return ListView.builder(
          itemCount: dataResult!.length,
          itemBuilder: (context, index) => Card(
            elevation: 2,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(color: Colors.black)),
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJHB2LmJDE8mRo5vCggGcP-G5Jkov0nOYt700GGxzzQg&s',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataResult[index].subject ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(dataResult[index].comment ?? ''),
                      Row(
                        children: [
                          InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditFormComment(
                                      id: dataResult[index].id ?? 0,
                                    ),
                                  )),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () => context
                                  .read<CommentProvider>()
                                  .deleteComment(
                                      context, dataResult[index].id ?? 0),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      case CommentState.nodata:
        return const Center(
          child: Text('No Data Comment'),
        );
      case CommentState.error:
        return Center(
          child: Text(context.watch<CommentProvider>().messageError),
        );
      default:
        return const CircularProgressIndicator();
    }
  }
}
