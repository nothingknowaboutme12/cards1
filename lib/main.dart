import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late Animation cardAnimation, displayedCard, cntanranimation, iconAnimation;
  late AnimationController controller;
  @override
  initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    cardAnimation = Tween(
      begin: 0.0,
      end: -0.040,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    displayedCard = Tween(
      begin: 0.0,
      end: -0.07,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));
    iconAnimation = Tween(
      begin: 1.0,
      end: -0.0007,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));
    cntanranimation = Tween(begin: 0.0, end: 0.020).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn)));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var devsize = MediaQuery.of(context).size.height;
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return MaterialApp(
          title: 'Attractive cards',
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(
                'Near Me',
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              actions: [
                FlutterLogo(
                  size: 33,
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomCard(
                        color: Colors.amber,
                        matrix4: Matrix4.translationValues(
                            0, devsize * displayedCard.value, 0),
                      ),
                      CustomCard(
                        color: Colors.grey,
                        matrix4: Matrix4.translationValues(
                            0, devsize * cardAnimation.value, 0),
                      ),
                      CustomCard(
                        chld: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "Assets/Men2.jpg",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 320,
                        left: 20,
                        child: Container(
                          height: 80,
                          width: 320,
                          transform: Matrix4.translationValues(
                              0, devsize * cntanranimation.value, 0),
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "kalya",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "59KM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.grey.shade600),
                                    ),
                                  ],
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "Fate is WonderFul",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    transform: Matrix4.translationValues(
                        0, devsize * iconAnimation.value, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        bottomContainer(
                          chld: Icon(
                            Icons.cancel,
                            size: 50,
                          ),
                        ),
                        bottomContainer(
                          chld: Icon(
                            Icons.bubble_chart,
                            size: 50,
                          ),
                        ),
                        bottomContainer(
                          chld: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class bottomContainer extends StatelessWidget {
  bottomContainer({
    this.chld,
  });
  Widget? chld;
  // Matrix4? matrix4;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 40,
      child: chld,
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({
    this.matrix4,
    this.chld,
    this.color,
  });
  Widget? chld;
  Matrix4? matrix4;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 378,
      width: 380,
      child: chld,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      transform: matrix4,
    );
  }
}
