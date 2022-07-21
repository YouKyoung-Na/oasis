import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'fee.dart';

// SharedPreferences 인스턴스를 어디서든 접근 가능하도록 전역 변수로 선언
late SharedPreferences prefs;

void main() async {
  // main() 함수에서 async를 쓰려면 필요
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // firebase 앱 시작

  // shared_preferences 인스턴스 생성
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SharedPreferences에서 온보딩 완료 여부 조회
    // isOnboarded에 해당하는 값어서 null을 반환하는 경우 false 할당
    bool isOnboarded = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Jua'),
      ),
      home: isOnboarded ? HomePage() : OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          // 첫 번째 페이지
          PageViewModel(
            title: "뭐시당가?",
            body: "AI 학습 데이터와 일자리를 동시에 !",
            image: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Image.asset('assets/logo3.png'),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 149, 191, 233),
                fontSize: 49,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
          // 두 번째 페이지
          PageViewModel(
            title: "한 번의 터치로 !",
            body: "지금 시작하세요",
            image: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Image.asset('assets/logosq.png'),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 149, 191, 233),
                fontSize: 49,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
        ],
        next: Text("다음 !",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        done: Text("시작 !",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        onDone: () {
          // Done 클릭시 isOnboarded = true로 저장
          //prefs.setBool("isOnboarded", true);

          // Done 클릭시 페이지 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  //세번째 페이지
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {},
        ),
        title: Image.asset(
          'assets/logolb.png',
          height: 80,
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 149, 191, 233),
        actions: [
          // 삭제 버튼
          IconButton(
            onPressed: () {
              // SharedPreferences에 저장된 모든 데이터 삭제
              //prefs.clear();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Image.asset(
                  "assets/logo3.png",
                  width: 200,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: '성함',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AfterLogin()),
                    );
                  },
                  child: Text('시작'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AfterLogin extends StatelessWidget {
  // 네번째 페이지
  const AfterLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {},
        ),
        title: Image.asset(
          'assets/logolb.png',
          height: 80,
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 149, 191, 233),
        actions: [
          // 삭제 버튼
          IconButton(
            onPressed: () {
              // SharedPreferences에 저장된 모든 데이터 삭제
              //prefs.clear();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("어느 것이 강아지 인가요?", style: TextStyle(fontSize: 33)),
              Text("간단하고 재미있게 수익 창출하기", style: TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.only(top: 1, bottom: 20),
                child: Stack(alignment: Alignment.bottomRight, children: [
                  Image.asset(
                    "assets/cnd.jpg",
                    width: 500,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, right: 12),
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => FivePage()),
                        );
                      },
                      child: Text(
                        '지금 시작하기',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "쉬운 난이도",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Image.asset(
                        "assets/ani.jpg",
                        width: 180,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Image.asset(
                          "assets/f.jpg",
                          width: 180,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "동물",
                    style: TextStyle(fontSize: 17),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 170),
                    child: Text(
                      "과일",
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Image.asset(
                        "assets/wheat-1556698_640.jpg",
                        width: 180,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Image.asset(
                          "assets/fish-3322230_640.jpg",
                          width: 180,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "농업",
                    style: TextStyle(fontSize: 17),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 170),
                    child: Text(
                      "수산업",
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "어려운 난이도",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Image.asset(
                            "assets/south-korea-5901194_640.png",
                            width: 180,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 255, 255, 255),
                        onSurface: Color.fromARGB(
                            255, 255, 255, 255), // Background color
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => NinePage()),
                        );
                      },
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "사투리",
                    style: TextStyle(fontSize: 17),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 170),
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FivePage extends StatelessWidget {
  // 다섯번째 페이지
  const FivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {},
          ),
          title: Image.asset(
            'assets/logolb.png',
            height: 80,
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 149, 191, 233),
          actions: [
            // 삭제 버튼
            IconButton(
              onPressed: () {
                // SharedPreferences에 저장된 모든 데이터 삭제
                //prefs.clear();
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    width: 190,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 255, 255, 255), // Background color
                      ),
                      onPressed: () {},
                      child: Text(
                        '쉬운 난이도',
                        style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 149, 191, 233)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 0,
                    bottom: 15,
                  ),
                  width: 190,
                  height: 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 255, 255, 255), // Background color
                    ),
                    onPressed: () {},
                    child: Text(
                      '어려운 난이도',
                      style: TextStyle(
                          fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "동물의 종류를 맞춰보세요 !",
                style: TextStyle(fontSize: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/0.jpg'),
            ),
            Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 50, bottom: 15, right: 15, left: 30),
                  width: 170,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SixPage()),
                      );
                    },
                    child: Text(
                      '고양이',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 50,
                    bottom: 15,
                  ),
                  width: 170,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SixPage()),
                      );
                    },
                    child: Text(
                      '강아지',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class SixPage extends StatelessWidget {
  // 여섯번째 페이지
  const SixPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {},
          ),
          title: Image.asset(
            'assets/logolb.png',
            height: 80,
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 149, 191, 233),
          actions: [
            // 삭제 버튼
            IconButton(
              onPressed: () {
                // SharedPreferences에 저장된 모든 데이터 삭제
                //prefs.clear();
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    width: 190,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 255, 255, 255), // Background color
                      ),
                      onPressed: () {},
                      child: Text(
                        '쉬운 난이도',
                        style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 149, 191, 233)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 0,
                    bottom: 15,
                  ),
                  width: 190,
                  height: 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 255, 255, 255), // Background color
                    ),
                    onPressed: () {},
                    child: Text(
                      '어려운 난이도',
                      style: TextStyle(
                          fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "동물의 종류를 맞춰보세요 !",
                style: TextStyle(fontSize: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/1.jpg'),
            ),
            Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 50, bottom: 15, right: 15, left: 30),
                  width: 170,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SevenPage()),
                      );
                    },
                    child: Text(
                      '고양이',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 50,
                    bottom: 15,
                  ),
                  width: 170,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SevenPage()),
                      );
                    },
                    child: Text(
                      '강아지',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class SevenPage extends StatelessWidget {
  // 일곱번째 페이지
  const SevenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {},
          ),
          title: Image.asset(
            'assets/logolb.png',
            height: 80,
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 149, 191, 233),
          actions: [
            // 삭제 버튼
            IconButton(
              onPressed: () {
                // SharedPreferences에 저장된 모든 데이터 삭제
                //prefs.clear();
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    width: 190,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 255, 255, 255), // Background color
                      ),
                      onPressed: () {},
                      child: Text(
                        '쉬운 난이도',
                        style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 149, 191, 233)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 0,
                    bottom: 15,
                  ),
                  width: 190,
                  height: 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 255, 255, 255), // Background color
                    ),
                    onPressed: () {},
                    child: Text(
                      '어려운 난이도',
                      style: TextStyle(
                          fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "동물의 종류를 맞춰보세요 !",
                style: TextStyle(fontSize: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/149.jpg'),
            ),
            Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 50, bottom: 15, right: 15, left: 30),
                  width: 170,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '고양이',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 50,
                    bottom: 15,
                  ),
                  width: 170,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => EightPage()),
                      );
                    },
                    child: Text(
                      '강아지',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class EightPage extends StatelessWidget {
  // 여덟번째 페이지
  const EightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AfterLogin()),
              );
            },
          ),
          title: Image.asset(
            'assets/logolb.png',
            height: 80,
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 149, 191, 233),
          actions: [
            // 삭제 버튼
            IconButton(
              onPressed: () {
                // SharedPreferences에 저장된 모든 데이터 삭제
                //prefs.clear();
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    width: 190,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 255, 255, 255), // Background color
                      ),
                      onPressed: () {},
                      child: Text(
                        '쉬운 난이도',
                        style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 149, 191, 233)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 0,
                    bottom: 15,
                  ),
                  width: 190,
                  height: 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 255, 255, 255), // Background color
                    ),
                    onPressed: () {},
                    child: Text(
                      '어려운 난이도',
                      style: TextStyle(
                          fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "동물의 종류를 맞춰보세요 !",
                style: TextStyle(fontSize: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/150.jpg'),
            ),
            Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 50, bottom: 15, right: 15, left: 30),
                  width: 170,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '고양이',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 50,
                    bottom: 15,
                  ),
                  width: 170,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '강아지',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class NinePage extends StatelessWidget {
  // 아홉번째 페이지
  const NinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AfterLogin()),
              );
            },
          ),
          title: Image.asset(
            'assets/logolb.png',
            height: 80,
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 149, 191, 233),
          actions: [
            // 삭제 버튼
            IconButton(
              onPressed: () {
                // SharedPreferences에 저장된 모든 데이터 삭제
                //prefs.clear();
              },
              icon: Icon(Icons.delete),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      bottom: 15,
                    ),
                    width: 190,
                    height: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 255, 255, 255), // Background color
                      ),
                      onPressed: () {},
                      child: Text(
                        '쉬운 난이도',
                        style: TextStyle(
                            fontSize: 22, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 0,
                    bottom: 15,
                  ),
                  width: 190,
                  height: 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 255, 255, 255), // Background color
                    ),
                    onPressed: () {},
                    child: Text(
                      '어려운 난이도',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 149, 191, 233)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "다음을 사투리로 읽어주세요 !",
                style: TextStyle(fontSize: 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/cut-1297554_640.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(
                      top: 50,
                      bottom: 15,
                    ),
                    width: 170,
                    height: 100,
                    child: Icon(Icons.mic,
                        color: Color.fromARGB(255, 149, 191, 233), size: 150)),
              ],
            )
          ],
        ));
  }
}
