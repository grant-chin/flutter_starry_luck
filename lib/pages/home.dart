// ignore_for_file: non_constant_identifier_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starry_luck/common/eventbus.dart';
import 'package:flutter_starry_luck/controller/user.dart';
import 'package:flutter_starry_luck/widget/primary_btn.dart';
import 'package:get/get.dart';
import '/widget/page_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int get _xp => UserController.xp.value;
  int get _xpUp => UserController.xpUp.value;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF212121),
      child: Column(
        children: [
          PageHeader(),
          ContentBox()
        ],
      ),
    );
  }

  Widget ContentBox() {
    return Expanded(child: CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 204,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF9747FF), Color(0xFF6112C7)],
                    stops: [0, 1], // 调整渐变范围
                  ),
                  image: DecorationImage(image: AssetImage('assets/images/bg/check_in_mask.png'), fit: BoxFit.cover)
                ),
              ),
              Positioned(right: 0, child: Swing(
                infinite: true,
                duration: Duration(seconds: 20),
                child: Image.asset('assets/images/bg/check_in_cover.png', height: 204)
              )),
              Positioned(
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('KEEP CHECKING IN', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'BlackHanSans')),
                    Text('Reach the Grand Prize!', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 20),
                    HeartBeat(
                      infinite: true,
                      child: PrimaryBtn(radius: 8, text: 'See more', width: 111, height: 40, func: () => Get.toNamed('/check_in'))
                    )
                  ],
                )
              )
            ]
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 58 + 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/bg/subtitle_top.png', height: 20),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Get.toNamed('/galactic_hand'),
                  child: Image.asset('assets/images/bg/game_top.png')
                ),
                SizedBox(height: 20),
                Image.asset('assets/images/bg/subtitle_hot.png', height: 20),
                SizedBox(height: 10),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                        child: Wrap(
                          spacing: 10,
                          children: [
                            GameItem('nebula_rush'),
                            GameItem('stellar_gift'),
                            GameItem('frostflare'),
                            GameItem('starflare'),
                            GameItem('quest_roll'),
                            GameItem('galactic_hand'),
                          ],
                        )
                      )
                    );
                  }
                ),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    bus.emit('tabChange', 2);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 128 * MediaQuery.of(context).size.width / 402,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/bg/push_your_limits.png'), fit: BoxFit.cover)
                    ),
                    child: Row(children: [
                      Container(
                        width: 180,
                        margin: EdgeInsets.only(top: 74, left: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Current', style: TextStyle(color: Color.fromRGBO(33, 33, 33, 0.6), fontSize: 11, fontWeight: FontWeight.bold)),
                                Text('Next', style: TextStyle(color: Color.fromRGBO(33, 33, 33, 0.6), fontSize: 11, fontWeight: FontWeight.bold)),
                              ]
                            ),
                            Container(
                              width: 180,
                              height: 12,
                              margin: EdgeInsets.only(top: 4),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(33, 33, 33, 0.56),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Row(
                                children: [
                                  Obx(() => Container(
                                    width: 176 * (_xp < _xpUp ? _xp / _xpUp : 1),
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ])
                  )
                )
              ]
            ),
          ),
        ])
      )
    ]));
  }
  Widget GameItem(name, { width }) {
    return GestureDetector(
      onTap: () => Get.toNamed('/$name'),
      child: Image.asset('assets/images/bg/game_$name.png', width: (width ?? 112) / 1)
    );
  }
}