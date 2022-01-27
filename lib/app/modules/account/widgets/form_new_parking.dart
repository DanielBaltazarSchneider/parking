import 'package:flutter/material.dart';

class FormNewParking extends StatelessWidget {
  FormNewParking({Key? key, required this.onSubmit}) : super(key: key);

  TextEditingController inputController = TextEditingController();
  final Function(String value) onSubmit;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey,
                Colors.amber,
                Colors.amber,
              ],
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.local_parking_sharp),
                    title: TextField(
                      controller: inputController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Nome do estacionamento",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.65,
                    child: ElevatedButton(
                      child: const Text('Criar'),
                      onPressed: () {
                        onSubmit(inputController.text);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
