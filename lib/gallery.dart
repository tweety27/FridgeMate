import 'dart:typed_data';
import 'package:camera/camera.dart'; // CameraDescription 인식을 위해 추가
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'scan.dart'; // TakePictureScreen을 가져오기 위해 import

class GalleryPage extends StatefulWidget {
  final CameraDescription camera; // 카메라 객체를 전달받을 수 있도록 수정

  const GalleryPage({Key? key, required this.camera}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<AssetEntity> images = [];
  List<Uint8List> webImages = []; // 웹에서 선택한 이미지 저장

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _fetchWebImages(); // 웹에서 파일 선택
    } else {
      _fetchImages(); // 모바일에서 갤러리 접근
    }
  }

  // 모바일에서 갤러리 이미지 불러오기
  Future<void> _fetchImages() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );
      if (albums.isNotEmpty) {
        List<AssetEntity> media =
            await albums[0].getAssetListPaged(page: 0, size: 60);
        setState(() {
          images = media;
        });
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  // 웹에서 파일 선택기 사용
  Future<void> _fetchWebImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        webImages = result.files.map((file) => file.bytes!).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 140), // '최근 항목'의 위치 조정
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  '최근 항목',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 5), // 텍스트와 아이콘 사이 간격
                Image.asset(
                  'assets/arrow_down.png',
                  width: 12,
                  height: 6,
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 10, top: 16), // X:317에 맞추기 위한 여백 조정
              child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Image.asset(
                    'assets/close_black_button.png',
                    width: 14,
                    height: 14,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(4),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: kIsWeb ? webImages.length + 1 : images.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(
                      camera: widget.camera, // 카메라 페이지로 이동
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.grey[300],
                child:
                    const Icon(Icons.camera_alt, color: Colors.white, size: 50),
              ),
            );
          }
          if (!kIsWeb) {
            return FutureBuilder<Uint8List?>(
              future: images[index - 1].thumbnailData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  );
                }
                return Container(color: Colors.grey[300]);
              },
            );
          } else {
            return Image.memory(
              webImages[index - 1],
              fit: BoxFit.cover,
            );
          }
        },
      ),
    );
  }
}
