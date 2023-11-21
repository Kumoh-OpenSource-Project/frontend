import 'dart:io';
import 'package:flutter/material.dart';
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
            onPressed: () {
              Navigator.pop(context);
            },
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
              const TextField(
                decoration: InputDecoration(
                  hintText: '제목',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                cursorColor: Colors.white,
              ),
              if (_pickedImages.isNotEmpty) _buildImagePreview(),
              const TextField(
                decoration: InputDecoration(
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
            value: 'observation_tool',
            child: Text('관측 도구 게시판'),
          ),
          DropdownMenuItem<String>(
            value: 'observation_location',
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
