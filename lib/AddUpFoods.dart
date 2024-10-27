import 'package:flutter/material.dart';
// main.dart 파일을 import 합니다

class IngredientConfirmationPage extends StatelessWidget {
  const IngredientConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // 제목을 중간에 배치
        title: const Text(
          '식재료 등록',
          style: TextStyle(
            fontWeight: FontWeight.w900, // 텍스트를 더 두껍게 설정
            fontSize: 20, // 폰트 크기 조절
            color: Colors.black, // 글씨 색상 설정
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        actions: const [
          Icon(Icons.close, color: Colors.black),
        ],
      ),
      body: Container(
        // 위에서 아래로 갈수록 색이 진해지는 그라데이션 배경
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '2024년 9월 5일',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              '냉장실',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildIngredientItem(
                      '더건강한샌드위치햄', '2024.09.21', 'assets/bacon.png'),
                  _buildIngredientItem(
                      '서울체다SLICE치즈20', '2024.09.21', 'assets/cheese.png'),
                  _buildIngredientItem(
                      'The좋은도넛(8개입)', '2024.09.08', 'assets/donut.png'),
                  _buildIngredientItem(
                      '속편한우유저지방', '2024.09.12', 'assets/milk.png'),
                  _buildIngredientItem(
                      'The싱싱한양파(3개입)', '2024.10.02', 'assets/onion.png'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '냉동실',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildIngredientItem(
                      'CJ 비비고 김치만두 16개', '2024.11.14', 'assets/dumpling.png'),
                  _buildIngredientItem(
                      '볶음밥에 넣어먹으면 짱', '2024.11.14', 'assets/shrimp.png'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 등록 버튼을 눌렀을 때 main.dart로 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF29A487), // 버튼 색상 설정
                  padding:
                      const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                ),
                child: const Text(
                  '등록하기',
                  style: TextStyle(
                    color: Colors.white, // 텍스트 색상을 흰색으로 설정
                    fontSize: 18, // 텍스트 크기를 18로 설정
                    fontWeight: FontWeight.bold, // 텍스트를 더 두껍게 설정
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 아이콘 대신 이미지 사용
  Widget _buildIngredientItem(String name, String date, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
                width: 30, // 이미지 크기 조정
                height: 30,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10), // 이미지와 텍스트 사이 간격
              Text(name, style: const TextStyle(fontSize: 14)),
            ],
          ),
          Text(date, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}
