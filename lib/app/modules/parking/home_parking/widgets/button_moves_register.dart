import 'package:flutter/material.dart';

class ButtonMoveRegister extends StatelessWidget {
  const ButtonMoveRegister({Key? key, required this.title, required this.assetImage, required this.onTap}) : super(key: key);

  final String title;
  final String assetImage;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.4,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: InkWell(
              onTap: () => onTap(),
              child: SizedBox(
                width: width * 0.35,
                height: width * 0.35,
                child: Card(
                  shadowColor: Colors.amber,
                  elevation: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        assetImage,
                        width: width * 0.1,
                      ),
                      // Icon(
                      //   MdiIcons.arrowLeftBoldOutline,
                      //   size: width * 0.1,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () => onTap(),
              child: Container(
                width: width * 0.4,
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Card(
                  color: Colors.grey.shade50,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(title),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
