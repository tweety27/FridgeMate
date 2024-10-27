import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'scan.dart'; // scan.dart 파일에서 TakePictureScreen을 가져옵니다.
import 'gallery.dart'; // gallery.dart 파일에서 GalleryPage를 가져옵니다.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "FridgeMate",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "Pretandard",
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon:
                    const Icon(Icons.qr_code_scanner, color: Color(0xFF4B4B4B)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Positioned(
                            left: 135,
                            top: 60,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                width: 200,
                                height: 150,
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Stack(
                                  children: [
                                    const Positioned(
                                      left: 67,
                                      top: 8,
                                      child: Text(
                                        '식재료 등록',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      top: 30,
                                      child: Image.asset(
                                        'assets/line.png',
                                        width: 190,
                                        height: 1,
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      top: 68,
                                      child: Image.asset(
                                        'assets/line.png',
                                        width: 190,
                                        height: 1,
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      top: 106,
                                      child: Image.asset(
                                        'assets/line.png',
                                        width: 190,
                                        height: 1,
                                      ),
                                    ),
                                    Positioned(
                                      left: 149,
                                      top: 37,
                                      child: Image.asset(
                                        'assets/camera.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    Positioned(
                                      left: 16,
                                      top: 40,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TakePictureScreen(
                                                      camera: camera),
                                            ),
                                          );
                                        },
                                        child: const SizedBox(
                                          width: 80,
                                          height: 17,
                                          child: Text(
                                            '영수증 촬영',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 149,
                                      top: 75,
                                      child: Image.asset(
                                        'assets/photo.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    Positioned(
                                      left: 16,
                                      top: 78,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  GalleryPage(camera: camera),
                                            ),
                                          );
                                        },
                                        child: const SizedBox(
                                          width: 90,
                                          height: 17,
                                          child: Text(
                                            '주문내역 첨부',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 149,
                                      top: 113,
                                      child: Image.asset(
                                        'assets/pencil.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    const Positioned(
                                      left: 16,
                                      top: 116,
                                      child: SizedBox(
                                        width: 80,
                                        height: 17,
                                        child: Text(
                                          '직접 입력',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.notifications_none_rounded,
                    color: Color(0xFF4B4B4B)),
                onPressed: () {
                  print("Notification icon clicked");
                },
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFDF4),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "나의 냉장고",
                    style: TextStyle(
                      fontFamily: "Pretandard",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "우유와 계란 유통기한이 얼마 남지 않았어요!\n오늘은 계란찜 어때요?",
                    style: TextStyle(
                      fontFamily: "Pretandard",
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildFridgeSection(
                    "냉동실",
                    [
                      _buildFridgeItemWithImage(
                          "모짜렐라 치즈", "D-5", "assets/cheese.png"),
                      _buildFridgeItemWithImage(
                          "냉동 삼겹살", "D-7", "assets/meat.png"),
                      _buildFridgeItemWithImage(
                          "냉동 밥", "D-10", "assets/rice.png"),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildFridgeSection(
                    "냉장실",
                    [
                      _buildFridgeItemWithImage("우유", "D-2", "assets/milk.png"),
                      _buildFridgeItemWithImage("계란", "D-3", "assets/egg.png"),
                      _buildFridgeItemWithImage(
                          "베이컨", "D-4", "assets/bacon.png"),
                      _buildFridgeItemWithImage(
                          "배추김치", "D-7", "assets/kimchi.png"),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "이번 달 버린 재료",
                    style: TextStyle(
                      fontFamily: "Pretandard",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "💬 30구 대신 15구 계란을 구매해 보세요",
                    style: TextStyle(
                      fontFamily: "Pretandard",
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // 밑에 바부분
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white, // 배경색을 흰색으로 설정
          unselectedItemColor: Color(0xFFB6BCC2), // 기본 비활성 색상
          selectedItemColor: Color(0xFF4B4B4B), // 활성 색상
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/recipes.png'),
                size: 24,
                color: Color(0xFFB6BCC2), 
              ),
              label: '레시피',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/home.png'),
                size: 24,
                color: Color(0xFF4B4B4B), 
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/mypage.png'),
                size: 24,
                color: Color(0xFFB6BCC2), 
              ),
              label: '마이페이지',
            ),
          ],
        ),
      ),
    );
  }

  // 냉동, 냉장 칸 만들기
  Widget _buildFridgeSection(String sectionTitle, List<Widget> items) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items,
            ),
          ],
        ),
      ),
    );
  }

  // 색재료, d-day , 이미지 넣어서 하나씩 만들어주는 위젯
  Widget _buildFridgeItemWithImage(
      String itemName, String daysLeft, String imagePath) {
    Color backgroundColor;
    Color textColor;

    if (daysLeft == "D-1" || daysLeft == "D-2") {
      backgroundColor = const Color(0xFFF64D3E);
      textColor = Colors.white;
    } else {
      backgroundColor = const Color(0xFFD9D9D9);
      textColor = Colors.black;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              itemName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Positioned(
          top: -15,
          right: -10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              daysLeft,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
