import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

class WritePostPage extends StatefulWidget {
  final String? selectedCategory;

  const WritePostPage({Key? key, this.selectedCategory}) : super(key: key);

  @override
  _WritePostPageState createState() => _WritePostPageState();
}

class _WritePostPageState extends State<WritePostPage> {
  String? selectedCategory;
  final ImagePicker _imagePicker = ImagePicker();
  final List<File> _pickedImages = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
  }

  void _getImageFromGallery() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (_pickedImages.length < 10) {
          _pickedImages.add(File(pickedFile.path));
        }
      });
    }
  }

  void _savePost() async {
    Map<String, dynamic> postData = {
      "type": selectedCategory,
      "title": titleController.text,
      "content": contentController.text,
    };

    if (_pickedImages.isNotEmpty) {
      // List<String> imageUrls = await _uploadImages(_pickedImages);
      postData["photo"] = _pickedImages.map((file) => file.path).toList();
    }

    print(postData);

    Navigator.pop(context);
  }

  // Future<List<String>> _uploadImages(List<File> images) async {
  //   List<String> imageUrls = [];
  //
  //   for (File image in images) {
  //     var request = http.MultipartRequest(
  //       'PUT',
  //       Uri.parse('https://starhubimage.s3.ap-northeast-2.amazonaws.com/articleImage/{image id}'),
  //     );
  //
  //     request.files.add(await http.MultipartFile.fromPath('file', image.path));
  //
  //     var response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       String imageUrl = await response.stream.bytesToString();
  //       imageUrls.add(imageUrl);
  //     } else {
  //       print('Failed to upload image: ${response.reasonPhrase}');
  //     }
  //   }
  //
  //   return imageUrls;
  // }

  void _getImageFromCamera() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        if (_pickedImages.length < 10) {
          _pickedImages.add(File(pickedFile.path));
        }
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _pickedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled =
        titleController.text.isNotEmpty && contentController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('글쓰기', textAlign: TextAlign.center),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: isButtonEnabled ? _savePost : null,
            color: isButtonEnabled ? Colors.white : Colors.grey,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCategoryDropdown(),
              TextField(
                controller: titleController,
                onChanged: (text) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: '제목',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                cursorColor: Colors.white,
              ),
              if (_pickedImages.isNotEmpty) _buildImagePreview(),
              TextField(
                controller: contentController,
                onChanged: (text) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: '내용을 입력하세요',
                  border: InputBorder.none,
                ),
                maxLines: null,
                cursorColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white)),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedCategory,
        decoration: const InputDecoration(
          hintText: '카테고리',
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        items: const [
          DropdownMenuItem<String>(
            value: 'scope',
            child: Text('관측 도구 게시판'),
          ),
          DropdownMenuItem<String>(
            value: 'place',
            child: Text('관측 장소 게시판'),
          ),
          DropdownMenuItem<String>(
            value: 'photo',
            child: Text('사진 자랑 게시판'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedCategory = value;
          });
        },
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _pickedImages.length,
        itemBuilder: (context, index) => Stack(
          alignment: Alignment.topRight,
          children: [
            Image.file(_pickedImages[index]),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () => _removeImage(index),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: _getImageFromCamera,
            color: Colors.white,
          ),
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: _getImageFromGallery,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
