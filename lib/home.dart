import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

import 'inverted_circle_clipper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  O3DController o3dController = O3DController();
  PageController mainPageController = PageController();
  PageController textPageController = PageController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: Stack(
          children: [
            O3D(
              src: 'assets/walking_girl_cat_walk.glb',
              controller: o3dController,
              ar: false,
              autoPlay: true,
              autoRotate: false,
              cameraControls: false,
              cameraTarget: CameraTarget(-0.25, 1.5, 1.5),
              cameraOrbit: CameraOrbit(0, 90, 1),
            ),
            PageView(
              controller: mainPageController,
              children: [
                const Center(),
                const Center(),
                ClipPath(
                  clipper: InvertedCircleClipper(),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Container(
                width: 100,
                height: double.infinity,
                margin: const EdgeInsets.all(12.0),
                child: PageView(
                  controller: textPageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('Daily Goals'),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              const Expanded(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text('74'),
                                ),
                              ),
                              Transform.translate(
                                  offset: const Offset(0, 20),
                                  child: const Text('%'))
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.local_fire_department_outlined,
                              color: Colors.red,
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '1,840',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Calories',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.do_not_step_outlined,
                              color: Colors.purple,
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '5,840',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Steps',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.hourglass_bottom_outlined,
                              color: Colors.blueAccent,
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '3.5',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Hours',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('Journal'),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Transform.translate(
                                  offset: const Offset(0, 20),
                                  child: const Text('<')),
                              const Expanded(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text('12'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'January 2024',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text('Profiles'),
                            ),
                          ),
                          Text(
                            'Sophia',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '23 years old',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (page) {
            mainPageController.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
            textPageController.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);

            if (page == 0) {
              o3dController.cameraTarget(-.25, 1.5, 1.5);
              o3dController.cameraOrbit(0, 90, 1);
            } else if (page == 1) {
              o3dController.cameraTarget(0, 1.8, 0);
              o3dController.cameraOrbit(-90, 90, 1.5);
            } else if (page == 2) {
              o3dController.cameraTarget(0, 3, 0);
              o3dController.cameraOrbit(0, 90, -3);
            }

            setState(() {
              this.page = page;
            });
          },
          currentIndex: page,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined), label: 'analytics'),
            BottomNavigationBarItem(
                icon: Icon(Icons.timer_outlined), label: 'timer'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'profile'),
          ],
        ),
      ),
    );
  }
}
