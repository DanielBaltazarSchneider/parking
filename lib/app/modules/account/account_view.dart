import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/data/constants/app_colors.dart';
import 'package:parking/app/modules/account/widgets/form_new_parking.dart';
import 'package:parking/app/modules/parking/home_parking/widgets/cardVehicleData.dart';
import 'package:parking/app/widgets/show_modal.dart';

import 'account_controller.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: AppColors.primary,
            body: SingleChildScrollView(
              child: SafeArea(
                child: SizedBox(
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/parking.gif",
                          width: width * 0.65,
                        ),
                      ),
                      Text(
                        "Bem vindo de volta!",
                        style: TextStyle(fontSize: width * 0.065),
                      ),
                      Column(
                        children: [
                          Text(
                            "Estacionamentos cadastrados",
                            style: TextStyle(fontSize: width * 0.035),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: width * 0.1),
                                for (int i = 0; i < _.account.listParking.length; i++) ...[
                                  Padding(
                                    padding: EdgeInsets.only(top: width * 0.05),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        InkWell(
                                          onTap: () => _.navigateToParkingView(context, i),
                                          child: Card(
                                            child: Container(
                                              margin: EdgeInsets.all(width * 0.01),
                                              padding: EdgeInsets.all(width * 0.01),
                                              width: width * 0.5,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _.account.listParking[i].name.toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: width * 0.03,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  CardVehicleData(
                                                      assetImage: "assets/images/car1_exit.png",
                                                      elevation: 0,
                                                      shadowColor: Colors.white,
                                                      color: Colors.white,
                                                      available: _.account.listParking[i].smallAvailableLength,
                                                      unavailable: _.account.listParking[i].smallLength -
                                                          _.account.listParking[i].smallAvailableLength,
                                                      total: _.account.listParking[i].smallLength),
                                                  CardVehicleData(
                                                    assetImage: "assets/images/car2.png",
                                                    elevation: 0,
                                                    shadowColor: Colors.white,
                                                    color: Colors.white,
                                                    available: _.account.listParking[i].mediumAvailableLength,
                                                    unavailable: _.account.listParking[i].mediumLength -
                                                        _.account.listParking[i].mediumAvailableLength,
                                                    total: _.account.listParking[i].mediumLength,
                                                  ),
                                                  CardVehicleData(
                                                    assetImage: "assets/images/car3.png",
                                                    elevation: 0,
                                                    shadowColor: Colors.white,
                                                    color: Colors.white,
                                                    available: _.account.listParking[i].largeAvailableLength,
                                                    unavailable: _.account.listParking[i].largeLength -
                                                        _.account.listParking[i].largeAvailableLength,
                                                    total: _.account.listParking[i].largeLength,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -20,
                                          right: -10,
                                          child: IconButton(
                                            onPressed: () => _.deleteParking(i),
                                            icon: const Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                SizedBox(width: width * 0.1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => ShowModal.show(context,
                            clild: FormNewParking(
                              onSubmit: (value) => value != "" ? _.createParking(value) : null,
                            ),
                            maxHeight: true),
                        child: const Text("CRIAR ESTACIONAMENTO"),
                      ),
                      SizedBox(height: width * 0.05),
                    ],
                  ),
                ),
              ),
            ),
            // body: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Center(
            //       child: Container(
            //         width: width * 0.3,
            //         height: width * 0.3,
            //         decoration: BoxDecoration(
            //           color: Colors.amber,
            //           borderRadius: BorderRadius.circular(width),
            //         ),
            //         child: Center(
            //           child: Image.asset(
            //             "assets/images/car1_exit.png",
            //             width: width * 0.2,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Text(
            //       "Bem vindo de volta!",
            //       style: TextStyle(fontSize: width * 0.065),
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           "Estacionamentos cadastrados",
            //           style: TextStyle(fontSize: width * 0.035),
            //         ),
            //         GetBuilder<AccountController>(
            //             // init: AccountController(),
            //             builder: (_) {
            //           return Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               SizedBox(width: width * 0.1),
            //               for (int i = 0; i < _.account.listParking.length; i++) ...[
            //                 Padding(
            //                   padding: EdgeInsets.only(top: width * 0.05),
            //                   child: Stack(
            //                     clipBehavior: Clip.none,
            //                     children: [
            //                       InkWell(
            //                         onTap: () => _.navigateToParkingView(context),
            //                         child: Card(
            //                           child: Container(
            //                             margin: EdgeInsets.all(width * 0.01),
            //                             padding: EdgeInsets.all(width * 0.01),
            //                             width: width * 0.5,
            //                             child: Column(
            //                               mainAxisAlignment: MainAxisAlignment.center,
            //                               children: [
            //                                 Text(
            //                                   _.account.listParking[i].name.toUpperCase(),
            //                                   style: TextStyle(
            //                                     fontSize: width * 0.03,
            //                                     color: Colors.black,
            //                                     fontWeight: FontWeight.bold,
            //                                   ),
            //                                 ),
            //                                 CardVehicleData(
            //                                     assetImage: "assets/images/car1_exit.png",
            //                                     elevation: 0,
            //                                     shadowColor: Colors.white,
            //                                     color: Colors.white,
            //                                     available: _.account.listParking[i].smallAvailableLength,
            //                                     unavailable: _.account.listParking[i].smallLength - _.account.listParking[i].smallAvailableLength,
            //                                     total: _.account.listParking[i].smallLength),
            //                                 CardVehicleData(
            //                                   assetImage: "assets/images/car2.png",
            //                                   elevation: 0,
            //                                   shadowColor: Colors.white,
            //                                   color: Colors.white,
            //                                   available: _.account.listParking[i].mediumAvailableLength,
            //                                   unavailable: _.account.listParking[i].mediumLength - _.account.listParking[i].mediumAvailableLength,
            //                                   total: _.account.listParking[i].mediumLength,
            //                                 ),
            //                                 CardVehicleData(
            //                                   assetImage: "assets/images/car3.png",
            //                                   elevation: 0,
            //                                   shadowColor: Colors.white,
            //                                   color: Colors.white,
            //                                   available: _.account.listParking[i].largeAvailableLength,
            //                                   unavailable: _.account.listParking[i].largeLength - _.account.listParking[i].largeAvailableLength,
            //                                   total: _.account.listParking[i].largeLength,
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       Positioned(
            //                         top: -20,
            //                         right: -10,
            //                         child: IconButton(
            //                           onPressed: () => _.deleteParking(i),
            //                           icon: const Icon(
            //                             Icons.remove_circle,
            //                             color: Colors.red,
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //               SizedBox(width: width * 0.1),
            //             ],
            //           );
            //         }),
            //       ],
            //     ),
          );
        });
  }
}
