import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkban/core/plate_helper.dart';
import 'package:parkban/data/database/plate/store_plate.dart';
import 'package:parkban/data/database/reserve/store_reserve.dart';

import '../../../../core/share_controller/settings_controller.dart';

class GridItem extends StatelessWidget {
  const GridItem({Key? key, required this.item, required this.onPress, required this.id}) : super(key: key);
  final String item;
  final String id;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPress,
      padding: EdgeInsets.zero,
      child: GetX<SettingsController>(
          builder: (settingsController) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: CupertinoColors.inactiveGray),
                borderRadius: BorderRadius.circular(15),
                color: (StoreReserve.readFromBox(item) == id) ? CupertinoColors.systemYellow : settingsController.darkTheme.value ? CupertinoColors.darkBackgroundGray : CupertinoColors.systemGrey6,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("جایگاه $item", style: const TextStyle(fontSize: 28),),
                    const SizedBox(height: 10,),
                    Directionality(textDirection: TextDirection.rtl, child: Text(changePlateStructureForPlaces(StorePlate.readFromBox(item)['plateType'],StorePlate.readFromBox(item)['plateNo']))),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
