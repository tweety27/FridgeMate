import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'capture.dart';
import 'gallery.dart'; // gallery.dart 파일 import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(FridgeMateApp(camera: firstCamera));
}

class FridgeMateApp extends StatelessWidget {
  final CameraDescription camera;

  const FridgeMateApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fridgemate',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TakePictureScreen(camera: camera),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  double _overlayOpacity = 1.0; // 오버레이 투명도 (초기 상태에서 보이도록 설정)
  double _cameraOverlayOpacity = 0.5; // 카메라 배경 어둡기 투명도

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();

    // 2초 후에 오버레이와 카메라 배경의 투명도를 변경하여 서서히 밝아지도록 설정
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _overlayOpacity = 0.0; // 오버레이 요소 서서히 사라짐
        _cameraOverlayOpacity = 0.0; // 카메라 배경 서서히 밝아짐
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                // 카메라 미리보기 화면
                CameraPreview(_controller),

                // 어두운 카메라 배경을 위한 반투명 레이어 (초기에는 어둡게 설정)
                AnimatedOpacity(
                  opacity: _cameraOverlayOpacity,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    color: Colors.black, // 카메라 배경을 어둡게
                  ),
                ),

                // 화면 상단 '닫기' 버튼 (항상 보임)
                Positioned(
                  top: 20,
                  left: 330,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0), // 패딩 추가
                    child: IconButton(
                      icon: Image.asset(
                        'assets/close_button.png',
                        width: 14,
                        height: 14,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),

                // 오버레이 요소들: receipt, receipt_border, 설명 텍스트 (2초 후에 서서히 사라짐)
                AnimatedOpacity(
                  opacity: _overlayOpacity,
                  duration: Duration(milliseconds: 500),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 영수증 테두리와 아이콘
                        SizedBox(
                          width: 86,
                          height: 86,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Image.asset(
                                  'assets/receipt_border.png',
                                  width: 86,
                                  height: 86,
                                ),
                              ),
                              Positioned(
                                left: 26,
                                top: 21,
                                child: Image.asset(
                                  'assets/receipt.png',
                                  width: 36,
                                  height: 47.44,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16), // 텍스트와 간격
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            '영수증 안의 식재료 정보가\n잘 나오도록 찍어주세요',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SUIT',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 하단 촬영 및 갤러리 버튼 (항상 보임)
                Positioned(
                  bottom: 20,
                  left: 10,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'assets/gallery.png',
                            width: 36,
                            height: 36,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GalleryPage(camera: widget.camera),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/capture_button.png',
                            width: 56,
                            height: 56,
                          ),
                          onPressed: () async {
                            try {
                              await _initializeControllerFuture;
                              final image = await _controller.takePicture();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaptureScreen(imagePath: image.path),
                                ),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/switch_camera.png',
                            width: 45,
                            height: 45,
                          ),
                          onPressed: () {
                            // 카메라 전환 기능
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
