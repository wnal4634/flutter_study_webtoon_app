import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 동작 감지
      onTap: () {
        // 버튼 클릭했다는 뜻
        Navigator.push(
          // 네비게이션 푸쉬를 쓰면 애니메이션으로 이동효과
          context,
          // MaterialPageRoute( //애니메이션 생성
          //   builder: (context) => DetailScreen(
          //     title: title,
          //     thumb: thumb,
          //     id: id,
          //   ),
          //   fullscreenDialog: true, // 아래에서 위로 올라옴
          // ),
          PageRouteBuilder(
            //애니메이션 생성
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0); //0.0 1.0으로 하면 수직, 1.0 0.0 수평
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(
                CurveTween(
                  curve: curve,
                ),
              );
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, anmation, secondaryAnimation) =>
                DetailScreen(id: id, title: title, thumb: thumb),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            // 두 화면 사이에 애니메이션을 주는 컴포넌트 (이미지 움직이면서 다음 화면 넘어가는 효과)
            tag: id, // 같은 아이디로 연결 (detail_screen.dart 에도 같은 Hero 컴포넌트와 아이디가 있음)
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                      color: Colors.black.withOpacity(0.5),
                    )
                  ]),
              child: Image.network(
                thumb,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
