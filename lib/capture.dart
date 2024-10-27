import 'dart:io';
import 'package:flutter/material.dart';
import 'AddUpFoods.dart'; // AddUpFoods 파일 import

class CaptureScreen extends StatefulWidget {
  final String imagePath;

  const CaptureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  _CaptureScreenState createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 설정 (2초 동안 위아래로 이동)
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // 반복적으로 위아래로 움직이도록 설정

    // 애니메이션의 위치를 상하로 이동하도록 설정
    _animation = Tween<double>(begin: 20, end: 65).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // 애니메이션 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IngredientConfirmationPage()),
          );
        },
        child: Stack(
          children: [
            // 사용자가 촬영한 이미지를 배경으로 설정
            Positioned.fill(
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),

            // 어두운 오버레이 레이어
            Container(
              color: Colors.black.withOpacity(0.5),
            ),

            // 상단 닫기 버튼
            Positioned(
              top: 20,
              right: 20,
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

            // 영수증 테두리 및 아이콘
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 43,
              top: 255,
              child: SizedBox(
                width: 86,
                height: 86,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
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
            ),

            // 스캔 라인 애니메이션
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 43,
                  top: 255 + _animation.value, // 애니메이션 값에 따라 위치 설정
                  child: Image.asset(
                    'assets/scanning_line.png',
                    width: 86,
                    height: 20,
                  ),
                );
              },
            ),

            // 중앙의 설명 텍스트
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 115,
              top: 370,
              child: SizedBox(
                width: 230,
                height: 68,
                child: const Text(
                  '영수증 정보를 읽고 있어요!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SUIT',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
