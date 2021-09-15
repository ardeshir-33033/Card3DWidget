import 'package:flutter/material.dart';

import '../Model.dart';

class CardHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Recently Played'),
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cardList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card3DWidget(cardModel: cardList[index]),
                  );
                }))
      ],
    );
  }
}


class Card3DWidget extends StatelessWidget {
  Card3DWidget({required this.cardModel});

  final Card3D cardModel;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset(
          cardModel.imageAddress,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

