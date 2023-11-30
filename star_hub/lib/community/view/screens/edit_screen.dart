import 'package:flutter/material.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/view_model/detail_post_viewmodel.dart';

class EditPage extends StatefulWidget {
  final DetailPostEntity post;
  final DetailPostViewModel viewModel;
  final int type;

  const EditPage(
      {Key? key,
      required this.post,
      required this.viewModel,
      required this.type})
      : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.post.content);
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = widget.viewModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 수정하기'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _contentController,
              maxLines: null, // Allow multiple lines
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: '내용을 작성하세요.',
              ),
              cursorColor: Colors.white,
            ),
            const SizedBox(height: kPaddingMiddleSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String editedContent = _contentController.text;
                    viewmodel.updatePost(
                        widget.type, widget.post.id, _contentController.text);
                    Navigator.pop(context, editedContent);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Background color
                    onPrimary: Colors.black, // Text color
                  ),
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
