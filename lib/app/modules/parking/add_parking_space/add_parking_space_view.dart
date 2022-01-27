import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';
import 'package:parking/app/modules/parking/add_parking_space/add_parking_espace_controller.dart';
import 'package:parking/app/modules/parking/add_parking_space/widgets/card_add_parking_space.dart';

class AddParkingSpaceView extends StatelessWidget {
  const AddParkingSpaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final AddParkingSpaceController _controller = Get.put(AddParkingSpaceController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Criar vagas"),
        leading: InkWell(
          onTap: () => Nav.back(context: context),
          child: const Icon(Icons.keyboard_arrow_left_sharp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
          child: Column(
            children: [
              Column(
                children: [
                  GetBuilder<AddParkingSpaceController>(
                      id: "smallSpace",
                      builder: (_) {
                        return CardAddParkingSpace(
                          imageAsset: "assets/images/car1_exit.png",
                          title: "Pequeno",
                          totalSpaces: _.smallSpace,
                          onTapAdd: () => _.addSmallSpace(),
                          onTapRemove: () => _.removeSmallSpace(),
                        );
                      }),
                  Divider(),
                  GetBuilder<AddParkingSpaceController>(
                      id: "mediumSpace",
                      builder: (_) {
                        return CardAddParkingSpace(
                          imageAsset: "assets/images/car2.png",
                          title: "Médio",
                          totalSpaces: _.mediumSpace,
                          onTapAdd: () => _.addMediumSpace(),
                          onTapRemove: () => _.removeMediumSpace(),
                        );
                      }),
                  Divider(),
                  GetBuilder<AddParkingSpaceController>(
                      id: "largeSpace",
                      builder: (_) {
                        return CardAddParkingSpace(
                          imageAsset: "assets/images/car3.png",
                          title: "Grande",
                          totalSpaces: _.largeSpace,
                          onTapAdd: () => _.addLargeSpace(),
                          onTapRemove: () => _.removeLargeSpace(),
                        );
                      }),
                ],
              ),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () => _controller.generateAndBack(context),
                icon: const Icon(Icons.save),
                label: const Text("Criar"),
              ),
              const Divider(),
              const Text("Após criar as vagas, será possível alterar suas posições"),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
