import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/controllers/home_controller.dart';
import 'package:tiktok_app/controllers/video_player_controller.dart';
import 'package:tiktok_app/views/video_player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final controller = Get.find<HomeController>();
  final List lstScreen = [
    VideoPlayerScreen(),
    const Center(
      child: Text('Search Screen'),
    ),
    const Center(
      child: Text('Add Screen'),
    ),
    const Center(
      child: Text('Message Screen'),
    ),
    const Center(
      child: Text('Profile Screen'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: lstScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          print('index : $index');
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {
                    controller.pickVideo();
                  },
                  child: SizedBox(
                    width: 45,
                    height: 30,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                          ),
                          width: 38,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              250,
                              45,
                              108,
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            right: 10,
                          ),
                          width: 38,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              32,
                              211,
                              234,
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: double.infinity,
                            width: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Home"),
        ],
      ),
    );
  }
}
