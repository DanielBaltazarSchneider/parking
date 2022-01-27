import 'package:flutter/material.dart';
import 'package:parking/app/data/models/historic.dart';
import 'package:parking/app/data/models/parking_space.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';
import 'package:parking/app/modules/parking/add_parking_space/add_parking_space_view.dart';
import 'package:parking/app/modules/parking/historic/historic_view.dart';
import 'package:parking/app/modules/parking/list_parking_spaces/all/list_all_parking_space.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu(
      {Key? key, required this.onCreateParkingSpaces, required this.listParkingSpace, required this.whenReordering, required this.historic})
      : super(key: key);

  final Function(List<ParkingSpace>) onCreateParkingSpaces;
  final List<ParkingSpace> listParkingSpace;
  final Function whenReordering;
  final Historic historic;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.025),
              width: width,
              color: Colors.amber,
              child: Center(child: Text("Menu")),
            ),
            TextButton(
              onPressed: () async {
                var data = await Nav.to(const AddParkingSpaceView(), context);
                if (data != null) {
                  onCreateParkingSpaces(data);
                } else {
                  onCreateParkingSpaces([]);
                }
                Nav.back(context: context);
              },
              child: Text("Criar vagas"),
            ),
            TextButton(
              onPressed: () async {
                var data = await Nav.to(
                    ListAllParkingSpacesView(
                      listParkingSpace: listParkingSpace,
                    ),
                    context);
                if (data != null) {
                  whenReordering();
                } else {
                  // onCreateParkingSpaces([]);
                }
                Nav.back(context: context);
              },
              child: Text("Listar vagas"),
            ),
            TextButton(
              onPressed: () async {
                var data = await Nav.to(
                    HistoricView(
                      historic: historic,
                    ),
                    context);
                if (data != null) {
                  whenReordering();
                } else {
                  // onCreateParkingSpaces([]);
                }
                Nav.back(context: context);
              },
              child: Text("Hitórico"),
            )
          ],
        ),
      ),
    );
  }
}
