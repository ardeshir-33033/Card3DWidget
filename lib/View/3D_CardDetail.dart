import 'package:flutter/material.dart';
import 'package:flutter_3d_cards/Model.dart';
import 'package:flutter_3d_cards/View/CardHoriznotal.dart';

class CardsDetail extends StatelessWidget {
  const CardsDetail({
    required this.card,
  });

  final Card3D? card;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black45,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Align(
              child: SizedBox(
                  height: 150.0, child: Card3DWidget(cardModel: card!))),
          SizedBox(
            height: 20,
          ),
          Text(
            card!.title ?? "",
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5,),
          Text(card!.author ?? "")
        ],
      ),
    );
  }
}
