import 'package:flutter/material.dart';
import 'package:flutter_3d_cards/Model.dart';
import 'package:flutter_3d_cards/View/3D_CardDetail.dart';

import 'CardHoriznotal.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Playlist',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 3, child: CardBody()),
          Expanded(flex: 2, child: CardHorizontal())
        ],
      ),
    );
  }
}

class CardBody extends StatefulWidget {
  @override
  _CardBodyState createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody>
    with SingleTickerProviderStateMixin {
  bool selectableMode = false;
  AnimationController? animationControllerSelection;
  int? selectedIndex;
  double value = 0.15;

  Future<void> onCardSelected(Card3D card, int index) async {
    setState(() {
      selectedIndex = index;
    });
    final duration = Duration(milliseconds: 750);
    await Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (context, animation, _) =>
          FadeTransition(opacity: animation, child: CardsDetail(card: card)),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    animationControllerSelection = AnimationController(
      vsync: this,
      lowerBound: 0.15,
      upperBound: 0.5,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationControllerSelection!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
        animation: animationControllerSelection!,
        builder: (context, snapshot) {
          final selectionValue = animationControllerSelection!.value;
          return GestureDetector(
            onTap: () {
              if (!selectableMode) {
                animationControllerSelection!.forward().whenComplete(() {
                  setState(() {
                    selectableMode = true;
                  });
                });
              } else {
                animationControllerSelection!.reverse().whenComplete(() {
                  setState(() {
                    selectableMode = false;
                  });
                });
              }
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(selectionValue),
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth * 0.45,
                color: Colors.white,
                child: Stack(
                  children: List.generate(
                      4,
                      (index) => Card3DItem(
                            card: cardList[index],
                            height: constraints.maxHeight / 2,
                            percent: selectionValue,
                            depth: index,
                            onCardSelected: (card) {
                              onCardSelected(card, index);
                            },
                          )).reversed.toList(),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class Card3DItem extends StatelessWidget {
  Card3DItem({
    required this.card,
    required this.depth,
    required this.height,
    required this.percent,
    this.onCardSelected,
  });

  final Card3D card;
  final double percent;
  final double height;
  final int depth;
  final ValueChanged<Card3D>? onCardSelected;

  @override
  Widget build(BuildContext context) {
    final bottomMargin = height / 4.0;
    return Positioned(
        left: 0,
        right: 0,
        top: height + -depth * height / 2.0 * percent - bottomMargin,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(0.0, 0.0, depth * 50.0),
          child: InkWell(
            onTap: () {
              onCardSelected!(card);
            },
            child: SizedBox(
              height: height,
              child: Card3DWidget(
                cardModel: card,
              ),
            ),
          ),
        ));
  }
}
