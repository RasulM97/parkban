import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/plate/plate_model.dart';
import '../../presentation/widgets/plates/__plates_keys.dart';
import '../../presentation/widgets/plates/army_plate_widget.dart';
import '../../presentation/widgets/plates/general_plate_widget.dart';
import '../../presentation/widgets/plates/government_plate_widget.dart';
import '../../presentation/widgets/plates/military_plate_widget.dart';
import '../../presentation/widgets/plates/motor_government_plate_widget.dart';
import '../../presentation/widgets/plates/motor_plate_widget.dart';
import '../../presentation/widgets/plates/personal_plate_widget.dart';
import '../../presentation/widgets/plates/police_plate_widget.dart';
import '../../presentation/widgets/plates/political_plate_widget.dart';
import '../../presentation/widgets/plates/protocol_plate_widget.dart';
import '../../presentation/widgets/plates/temporary_plate_widget.dart';
import '../../presentation/widgets/plates/transit_plate_widget.dart';
import '../../presentation/widgets/plates/vetrans_plate_widget.dart';
import '../presentation/Widgets/plates/defence_plate_widget.dart';
import '../presentation/Widgets/plates/diplomat_plate_widget.dart';
import '../presentation/Widgets/plates/sepah_plate_widget.dart';



List<String> plateTypes = [
  'شخصي',
  'عمومي',
  'ارتش',
  'سرويس يا خدمت',
  'سياسي يا ديپلمات جديد',
  'معلولين',
  'دولتي',
  'پليس',
  'سپاه',
  'ستاد کل نيروهاي مسلح',
  'وزارت دفاع',
  'ترانزيت',
  'گذر موقت جديد',
  'موتور سيکلت دولتي',
  'تشريفات',
  'موتور سيکلت',
];

Map<String, PlateModel> plateModels = {
  'شخصي': PlateModel(
    idType: 'شخصي',
    listLetters: [
      'ب',
      'ج',
      'د',
      'س',
      'ص',
      'ط',
      'ق',
      'ل',
      'م',
      'ن',
      'و',
      'ه',
      'ي',
    ],
  ),
  'عمومي': PlateModel(
    idType: 'عمومي',
    listLetters: [
      'ع',
      'ت',
      'ک',
    ],
  ),
  'ارتش': PlateModel(
    idType: 'ارتش',
    listLetters: ['ش'],
  ),
  'سرويس يا خدمت': PlateModel(
    idType: 'سرويس يا خدمت',
    listLetters: ['S'],
  ),
  'سياسي يا ديپلمات جديد': PlateModel(
    idType: 'سياسي يا ديپلمات جديد',
    listLetters: ['D'],
  ),
  'معلولين': PlateModel(
    idType: 'معلولين',
    listLetters: [],
  ),
  'دولتي': PlateModel(
    idType: 'دولتي',
    listLetters: ['الف'],
  ),
  'پليس': PlateModel(
    idType: 'پليس',
    listLetters: ['پ'],
  ),
  'سپاه': PlateModel(
    idType: 'سپاه',
    listLetters: ['ث'],
  ),
  'ستاد کل نيروهاي مسلح': PlateModel(
    idType: 'ستاد کل نيروهاي مسلح',
    listLetters: ['ف'],
  ),
  'وزارت دفاع': PlateModel(
    idType: 'وزارت دفاع',
    listLetters: ['ز'],
  ),
  'ترانزيت': PlateModel(
    idType: 'ترانزيت',
    listLetters: [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ],
  ),
  'گذر موقت جديد': PlateModel(
    idType: 'گذر موقت جديد',
    listLetters: ['گ'],
  ),
  'تشريفات': PlateModel(
    idType: 'تشريفات',
    listLetters: [],
  ),
  'موتور سيکلت': PlateModel(
    idType: 'موتور سيکلت',
    listLetters: [],
  ),
  'موتور سيکلت دولتي': PlateModel(
    idType: 'موتور سيکلت دولتي',
    listLetters: [],
  ),
};

Widget makePlate({
  required double width,
  String? idno,
  String? plateType,
  bool enable = false,
  int vrtype = 1,
  Key? key,
}) {
  Widget currentPlate = (vrtype == 1)
      ? PersonalPlate(
    width: width,
    enable: enable,
    key: enable
        ? (plateType != null)
        ? key
        : key
        : null,
  )
      : MotorPlate(
      width: width,
      enable: enable,
      key: enable
          ? (plateType != null)
          ? key
          : key
          : null);

  if (idno != null && plateType != null && idno.isNotEmpty && plateType.isNotEmpty) {
    String idNo = idno.trim();
    String idType = plateType.trim();
    switch (idType) {
      case 'شخصي':
        if (idNo.length == 8) {
          currentPlate = PersonalPlate(
            width: width,
            num1: idNo.substring(0, 2),
            letter: idNo.substring(2, 3),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(2, 3)}-${plateNo.substring(3, 6)}-${plateNo.substring(6)}
        }
        break;

      case 'عمومي':
        if (idNo.length == 8) {
          currentPlate = GeneralPlate(
            width: width,
            num1: idNo.substring(0, 2),
            letter: idNo.substring(2, 3),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(2, 3)}-${plateNo.substring(3, 6)}-${plateNo.substring(6)}
        }
        break;

      case 'ارتش':
        if (idNo.length == 8) {
          currentPlate = ArmyPlate(
            width: width,
            num1: idNo.substring(0, 2),
            letter: idNo.substring(2, 3),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(2, 3)}-${plateNo.substring(3, 6)}-${plateNo.substring(6)}
        }
        break;

      case 'سرويس يا خدمت':
        if (idNo.length == 9) {
          currentPlate = PoliticalPlate(
            width: width,
            num1: idNo.substring(0, 2),
            num2: idNo.substring(4, 7),
            num3: idNo.substring(7),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-S-${plateNo.substring(4, 7)}-${plateNo.substring(7)}
        }
        break;

      case 'سياسي يا ديپلمات جديد':
        if (idNo.length == 9) {
          currentPlate = DiplomatPlate(
            width: width,
            num1: idNo.substring(0, 2),
            num2: idNo.substring(4, 7),
            num3: idNo.substring(7),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-S-${plateNo.substring(4, 7)}-${plateNo.substring(7)}
        }
        break;

      case 'معلولين':
        if (idNo.length == 9) {
          currentPlate = VetransPlate(
            width: width,
            num1: idNo.substring(0, 2),
            num2: idNo.substring(4, 7),
            num3: idNo.substring(7),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-di-${plateNo.substring(4, 7)}-${plateNo.substring(7)}
        }
        break;

      case 'دولتي':
        if (idNo.length == 8) {
          currentPlate = GovernmentPlate(
            width: width,
            num1: idNo.substring(0, 2),
            letter: idNo.substring(2, 3),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(2, 3)}-${plateNo.substring(3, 6)}-${plateNo.substring(6)}
        }
        break;

      case 'پليس':
        if (idNo.length == 8) {
          currentPlate = PolicePlate(
            width: width,
            num1: idNo.substring(0, 2),
            letter: idNo.substring(2, 3),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(2, 3)}-${plateNo.substring(3, 6)}-${plateNo.substring(6)}
        }
        break;

      case 'سپاه':
        if (idNo.length == 8) {
          currentPlate = SepahPlate(
            width: width,
            num1: idNo.substring(0, 2),
            letter: idNo.substring(2, 3),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(2, 3)}-${plateNo.substring(3, 6)}-${plateNo.substring(6)}
        }
        break;

      case 'ستاد کل نيروهاي مسلح':
        if (idNo.length == 8) {
          currentPlate = MilitaryPlate(
            width: width,
            num1: idNo.substring(0, 2),
            letter: idNo.substring(2, 3),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(2, 3)}-${plateNo.substring(3, 6)}-${plateNo.substring(6)}
        }
        break;

      case 'وزارت دفاع':
        if (idNo.length == 8) {
          currentPlate = DefencePlate(
            width: width,
            num1: idNo.substring(0, 2),
            letter: idNo.substring(2, 3),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(2, 3)}-${plateNo.substring(3, 6)}-${plateNo.substring(6)}
        }
        break;

      case 'ترانزيت':
        if (idNo.length == 8) {
          currentPlate = TransitPlate(
            width: width,
            num1: idNo.substring(0, 2),
            letter: idNo.substring(2, 3),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6),
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(2, 3)}-${plateNo.substring(3, 6)}-${plateNo.substring(6)}
        }
        break;

      case 'گذر موقت جديد':
        if (idNo.length == 13) {
          currentPlate = TemporaryPlate(
            width: width,
            num1: idNo.substring(0, 2),
            num2: idNo.substring(3, 6),
            num3: idNo.substring(6, 8),
            num4: idNo.substring(8),
            enable: enable,
          );    //${plateNo.substring(0, 2)}-${plateNo.substring(3, 6)}-${plateNo.substring(6, 8)}-${plateNo.substring(8)}
        }

        break;

      case 'تشريفات':
        if (idNo.length == 7) {
          currentPlate = ProtocolPlate(
            width: width,
            num: idNo.substring(3),
            key: key,
            enable: enable,
          );    //pro${plateNo.substring(3)}
        }
        break;

      case 'موتور سيکلت':
        if (idNo.length == 10) {
          currentPlate = MotorPlate(
            width: width,
            num1: idNo.substring(0, 3),
            num2: idNo.substring(5),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 3)}-mo-${plateNo.substring(5)}
        }
        break;

      case 'موتور سيکلت دولتي':
        if (idNo.length == 8) {
          currentPlate = MotorGovernmentPlate(
            width: width,
            num1: idNo.substring(0, 2),
            num2: idNo.substring(4),
            key: key,
            enable: enable,
          );    //${plateNo.substring(0, 2)}-md-${plateNo.substring(4)}
        }
        break;
    }
  } else if (plateType != null) {
    String idType = plateType.trim();
    switch (idType) {
      case 'شخصي':
        currentPlate = PersonalPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'عمومي':
        currentPlate = GeneralPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'ارتش':
        currentPlate = ArmyPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'سرويس يا خدمت':
        currentPlate = PoliticalPlate(
          width: width,
          enable: enable,
          letter: 'S',
          key: key,
        );
        break;

      case 'سياسي يا ديپلمات جديد':
        currentPlate = DiplomatPlate(
          width: width,
          enable: enable,
          letter: 'D',
          key: key,
        );
        break;

      case 'معلولين':
        currentPlate = VetransPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'دولتي':
        currentPlate = GovernmentPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'پليس':
        currentPlate = PolicePlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'سپاه':
        currentPlate = SepahPlate(
          width: width,
          enable: enable,
          letter: 'ث',
          key: key,
        );
        break;

      case 'ستاد کل نيروهاي مسلح':
        currentPlate = MilitaryPlate(
          width: width,
          enable: enable,
          key: key,
          letter: 'ف',
        );
        break;

      case 'وزارت دفاع':
        currentPlate = DefencePlate(
          width: width,
          enable: enable,
          key: key,
          letter: 'ز',
        );
        break;

      case 'ترانزيت':
        currentPlate = TransitPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'گذر موقت جديد':
        currentPlate = TemporaryPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'تشريفات':
        currentPlate = ProtocolPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'موتور سيکلت':
        currentPlate = MotorPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;

      case 'موتور سيکلت دولتي':
        currentPlate = MotorGovernmentPlate(
          width: width,
          enable: enable,
          key: key,
        );
        break;
    }
  } else {
    currentPlate = (vrtype == 1)
        ? PersonalPlate(
      width: width,
      enable: true,
      key: key,
    )
        : MotorPlate(
      width: width,
      enable: true,
      key: key,
    );
  }
  return currentPlate;
}

GlobalKey<State<StatefulWidget>> getPlateKey(String plateType, PlatesKeys platesKeys) {
  String idType = plateType.trim();
  switch (idType) {
    case 'شخصي':
      return platesKeys.personalPlateKey;

    case 'عمومي':
      return platesKeys.generalPlateKey;

    case 'ارتش':
      return platesKeys.armyPlateKey;

    case 'سرويس يا خدمت':
      return platesKeys.politicalPlateKey;

    case 'سياسي يا ديپلمات جديد':
      return platesKeys.diplomatKzPlateKey;

    case 'معلولين':
      return platesKeys.vetransPlateKey;

    case 'دولتي':
      return platesKeys.governmentPlateKey;

    case 'پليس':
      return platesKeys.policePlateKey;

    case 'سپاه':
      return platesKeys.sepahKzPlateKey;

    case 'ستاد کل نيروهاي مسلح':
      return platesKeys.militaryPlateKey;

    case 'وزارت دفاع':
      return platesKeys.defenceKzPlateKey;

    case 'ترانزيت':
      return platesKeys.transitPlateKey;

    case 'گذر موقت جديد':
      return platesKeys.temporaryPlateKey;

    case 'تشريفات':
      return platesKeys.protocolPlateKey;

    case 'موتور سيکلت':
      return platesKeys.motorPlateKey;

    case 'موتور سيکلت دولتي':
      return platesKeys.motorGovernmentPlateKey;

    default:
      return platesKeys.personalPlateKey;
  }
}

bool validatePlateNo(String plateNO, String plateType) {
  bool execution = true;
  if (plateType == "گذر موقت جديد") {
    if (plateNO.length < 13) {
      execution = false;
    }
  } else if (plateType == "تشريفات") {
    if (plateNO.length < 7) {
      execution = false;
    }
  } else if (plateType == "موتور سيکلت") {
    if (plateNO.length < 10) {
      execution = false;
    }
  } else if (plateType == "موتور سيکلت دولتي") {
    if (plateNO.length < 8) {
      execution = false;
    }
  } else if (plateType == "سرويس يا خدمت" || plateType == "معلولين") {
    if (plateNO.length < 9) {
      execution = false;
    }
  } else if (plateType == 'شخصي') {
    if (plateNO.length < 8 || !plateModels[plateType]!.listLetters!.contains(plateNO.substring(2, 3))) {
      execution = false;
    }
  } else if (plateType == 'ترانزيت') {
    if (plateNO.length < 8 || !plateModels[plateType]!.listLetters!.contains(plateNO.substring(2, 3))) {
      execution = false;
    }
  } else {
    if (plateNO.length < 8) {
      execution = false;
    }
  }
  return execution;
}

String getPlateNo(String plateType, PlatesKeys platesKeys) {
  String finalPlateNO = '';
  switch (plateType) {
    case 'شخصي':
    // key = key as GlobalKey<PersonalPlateState>;
      GlobalKey<PersonalPlateState> key = platesKeys.personalPlateKey;
      finalPlateNO =
      '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'عمومي':
    // key = key as GlobalKey<GeneralPlateState>;
      GlobalKey<GeneralPlateState> key = platesKeys.generalPlateKey;
      finalPlateNO =
      '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'ارتش':
    // key = key as GlobalKey<ArmyPlateState>;
      GlobalKey<ArmyPlateState> key = platesKeys.armyPlateKey;
      finalPlateNO =
      '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'سرويس يا خدمت':
    // key = key as GlobalKey<PoliticalPlateState>;
      GlobalKey<PoliticalPlateState> key = platesKeys.politicalPlateKey;
      finalPlateNO = '${key.currentState!.num1Controller.text}NS${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'سياسي يا ديپلمات جديد':
    // key = key as GlobalKey<PoliticalPlateState>;
      GlobalKey<DiplomatPlateState> key = platesKeys.diplomatKzPlateKey;
      finalPlateNO = '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'معلولين':
    // key = key as GlobalKey<VetransPlateState>;
      GlobalKey<VetransPlateState> key = platesKeys.vetransPlateKey;
      finalPlateNO = '${key.currentState!.num1Controller.text}di${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'دولتي':
    // key = key as GlobalKey<GovernmentPlateState>;
      GlobalKey<GovernmentPlateState> key = platesKeys.governmentPlateKey;
      finalPlateNO = '${key.currentState!.num1Controller.text}ا${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'پليس':
    // key = key as GlobalKey<PolicePlateState>;
      GlobalKey<PolicePlateState> key = platesKeys.policePlateKey;
      finalPlateNO =
      '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'سپاه':
    // key = key as GlobalKey<PolicePlateState>;
      GlobalKey<SepahPlateState> key = platesKeys.sepahKzPlateKey;
      finalPlateNO = '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'ستاد کل نيروهاي مسلح':
    // key = key as GlobalKey<MilitaryPlateState>;
      GlobalKey<MilitaryPlateState> key = platesKeys.militaryPlateKey;
      finalPlateNO =
      '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'وزارت دفاع':
    // key = key as GlobalKey<MilitaryPlateState>;
      GlobalKey<DefencePlateState> key = platesKeys.defenceKzPlateKey;
      finalPlateNO =
      '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'ترانزيت':
      GlobalKey<TransitPlateState> key = platesKeys.transitPlateKey;
      finalPlateNO =
      '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}';
      break;

    case 'گذر موقت جديد':
      GlobalKey<TemporaryPlateState> key = platesKeys.temporaryPlateKey;
      finalPlateNO =
      '${key.currentState!.num1Controller.text}${key.currentState!.letter}${key.currentState!.num2Controller.text}${key.currentState!.num3Controller.text}${key.currentState!.num4Controller.text}';
      break;

    case 'تشريفات':
    // key = key as GlobalKey<ProtocolPlateState>;
      GlobalKey<ProtocolPlateState> key = platesKeys.protocolPlateKey;
      finalPlateNO = 'pro${key.currentState!.numController.text}';
      break;

    case 'موتور سيکلت':
    // key = key as GlobalKey<MotorPlateState>;
      GlobalKey<MotorPlateState> key = platesKeys.motorPlateKey;
      finalPlateNO = '${key.currentState!.num1Controller.text}mo${key.currentState!.num2Controller.text}';
      break;

    case 'موتور سيکلت دولتي':
    // key = key as GlobalKey<MotorGovernmentPlateState>;
      GlobalKey<MotorGovernmentPlateState> key = platesKeys.motorGovernmentPlateKey;
      finalPlateNO = '${key.currentState!.num1Controller.text}md${key.currentState!.num2Controller.text}';
      break;
  }

  if (!validatePlateNo(finalPlateNO, plateType)) {
    finalPlateNO = '';
  }

  return finalPlateNO;
}

void clearPlateNo(String plateType, PlatesKeys platesKeys) {
  String finalPlateNO = '';
  switch (plateType) {
    case 'شخصي':
    // key = key as GlobalKey<PersonalPlateState>;
      GlobalKey<PersonalPlateState> key = platesKeys.personalPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'عمومي':
    // key = key as GlobalKey<GeneralPlateState>;
      GlobalKey<GeneralPlateState> key = platesKeys.generalPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'ارتش':
    // key = key as GlobalKey<ArmyPlateState>;
      GlobalKey<ArmyPlateState> key = platesKeys.armyPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'سرويس يا خدمت':
    // key = key as GlobalKey<PoliticalPlateState>;
      GlobalKey<PoliticalPlateState> key = platesKeys.politicalPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'سياسي يا ديپلمات جديد':
    // key = key as GlobalKey<PoliticalPlateState>;
      GlobalKey<DiplomatPlateState> key = platesKeys.diplomatKzPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'معلولين':
    // key = key as GlobalKey<VetransPlateState>;
      GlobalKey<VetransPlateState> key = platesKeys.vetransPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'دولتي':
    // key = key as GlobalKey<GovernmentPlateState>;
      GlobalKey<GovernmentPlateState> key = platesKeys.governmentPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'پليس':
    // key = key as GlobalKey<PolicePlateState>;
      GlobalKey<PolicePlateState> key = platesKeys.policePlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'سپاه':
    // key = key as GlobalKey<PolicePlateState>;
      GlobalKey<SepahPlateState> key = platesKeys.sepahKzPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'ستاد کل نيروهاي مسلح':
    // key = key as GlobalKey<MilitaryPlateState>;
      GlobalKey<MilitaryPlateState> key = platesKeys.militaryPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'وزارت دفاع':
    // key = key as GlobalKey<MilitaryPlateState>;
      GlobalKey<DefencePlateState> key = platesKeys.defenceKzPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'ترانزيت':
      GlobalKey<TransitPlateState> key = platesKeys.transitPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      break;

    case 'گذر موقت جديد':
      GlobalKey<TemporaryPlateState> key = platesKeys.temporaryPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      key.currentState?.num3Controller.clear();
      key.currentState?.num4Controller.clear();
      break;

    case 'تشريفات':
    // key = key as GlobalKey<ProtocolPlateState>;
      GlobalKey<ProtocolPlateState> key = platesKeys.protocolPlateKey;
      key.currentState?.numController.clear();
      break;

    case 'موتور سيکلت':
    // key = key as GlobalKey<MotorPlateState>;
      GlobalKey<MotorPlateState> key = platesKeys.motorPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      break;

    case 'موتور سيکلت دولتي':
    // key = key as GlobalKey<MotorGovernmentPlateState>;
      GlobalKey<MotorGovernmentPlateState> key = platesKeys.motorGovernmentPlateKey;
      key.currentState?.num1Controller.clear();
      key.currentState?.num2Controller.clear();
      break;
  }

  if (!validatePlateNo(finalPlateNO, plateType)) {
    finalPlateNO = '';
  }
}

Future<Widget> makePlateWithDelay({Key? key,required BuildContext context ,String? idno, String? plateType}) async {
  Widget plate = makePlate(width: context.width * 0.7, enable: true, key: key);
  await Future.delayed(
    const Duration(milliseconds: 50),
        () {
      plate = makePlate(
        width: context.width * 0.7,
        key: key,
        idno: idno,
        plateType: plateType,
        enable: true,
      );
    },
  );
  return plate;
}

String changePlateStructureForPlaces(String plateType, String plateNo) {
  String finalPlateNO = '';
  if(plateNo.isNotEmpty) {
    switch (plateType) {
    case 'شخصي':
      finalPlateNO = '${plateNo.substring(3, 6)}-${plateNo.substring(6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
      break;

    case 'عمومي':
      finalPlateNO = '${plateNo.substring(3, 6)}-${plateNo.substring(6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
      break;

    case 'ارتش':
      finalPlateNO = '${plateNo.substring(3, 6)}-${plateNo.substring(6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
      break;

    case 'سرويس يا خدمت':
      finalPlateNO = '${plateNo.substring(0, 2)}-S-${plateNo.substring(4, 7)}-${plateNo.substring(7)}';
      break;

    case 'سياسي يا ديپلمات جديد':
      finalPlateNO = '${plateNo.substring(0, 2)}-D-${plateNo.substring(4, 7)}-${plateNo.substring(7)}';
      break;

    case 'معلولين':
      finalPlateNO = '${plateNo.substring(0, 2)}-di-${plateNo.substring(4, 7)}-${plateNo.substring(7)}';
      break;

    case 'دولتي':
      finalPlateNO = '${plateNo.substring(3, 6)}-${plateNo.substring(6)}-الف-${plateNo.substring(0, 2)}';
      break;

    case 'پليس':
      finalPlateNO = '${plateNo.substring(3, 6)}-${plateNo.substring(6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
      break;

    case 'سپاه':
      finalPlateNO = '${plateNo.substring(3, 6)}-${plateNo.substring(6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
      break;

    case 'ستاد کل نيروهاي مسلح':
      finalPlateNO = '${plateNo.substring(3, 6)}-${plateNo.substring(6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
      break;

    case 'وزارت دفاع':
      finalPlateNO = '${plateNo.substring(3, 6)}-${plateNo.substring(6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
      break;

    case 'ترانزيت':
      finalPlateNO = '${plateNo.substring(3, 6)}-${plateNo.substring(6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
      break;

    case 'گذر موقت جديد':
      finalPlateNO = '${plateNo.substring(0, 2)}-${plateNo.substring(3, 6)}-${plateNo.substring(6, 8)}-${plateNo.substring(8)}';
      break;

    case 'تشريفات':
      finalPlateNO = 'pro${plateNo.substring(3)}';
      break;

    case 'موتور سيکلت':
      finalPlateNO = '${plateNo.substring(0, 3)}-mo-${plateNo.substring(5)}';
      break;

    case 'موتور سيکلت دولتي':
      finalPlateNO = '${plateNo.substring(0, 3)}-md-${plateNo.substring(4)}';
      break;
  }
  }else{
    finalPlateNO = '';
  }
  if(plateNo.isNotEmpty) {
    return finalPlateNO.replaceAll(RegExp(r'\b-+'), "-");
  }else{
    return '';
  }
}

String changePlateStructureForPrinting(String plateType, String plateNo) {
  String finalPlateNO = '';
    switch (plateType) {
      case 'شخصي':
        finalPlateNO = '${plateNo.substring(6)}-${plateNo.substring(3, 6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
        break;

      case 'عمومي':
        finalPlateNO = '${plateNo.substring(6)}-${plateNo.substring(3, 6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
        break;

      case 'ارتش':
        finalPlateNO = '${plateNo.substring(6)}-${plateNo.substring(3, 6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
        break;

      case 'سرويس يا خدمت':
        finalPlateNO = '${plateNo.substring(0, 2)}-S-${plateNo.substring(4, 7)}-${plateNo.substring(7)}';
        break;

      case 'سياسي يا ديپلمات جديد':
        finalPlateNO = '${plateNo.substring(0, 2)}-D-${plateNo.substring(4, 7)}-${plateNo.substring(7)}';
        break;

      case 'معلولين':
        finalPlateNO = '${plateNo.substring(0, 2)}-di-${plateNo.substring(4, 7)}-${plateNo.substring(7)}';
        break;

      case 'دولتي':
        finalPlateNO = '${plateNo.substring(6)}-${plateNo.substring(3, 6)}-الف-${plateNo.substring(0, 2)}';
        break;

      case 'پليس':
        finalPlateNO = '${plateNo.substring(6)}-${plateNo.substring(3, 6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
        break;

      case 'سپاه':
        finalPlateNO = '${plateNo.substring(6)}-${plateNo.substring(3, 6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
        break;

      case 'ستاد کل نيروهاي مسلح':
        finalPlateNO = '${plateNo.substring(6)}-${plateNo.substring(3, 6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
        break;

      case 'وزارت دفاع':
        finalPlateNO = '${plateNo.substring(6)}-${plateNo.substring(3, 6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
        break;

      case 'ترانزيت':
        finalPlateNO = '${plateNo.substring(6)}-${plateNo.substring(3, 6)}-${plateNo.substring(2, 3)}-${plateNo.substring(0, 2)}';
        break;

      case 'گذر موقت جديد':
        finalPlateNO = '${plateNo.substring(0, 2)}-${plateNo.substring(3, 6)}-${plateNo.substring(6, 8)}-${plateNo.substring(8)}';
        break;

      case 'تشريفات':
        finalPlateNO = 'pro${plateNo.substring(3)}';
        break;

      case 'موتور سيکلت':
        finalPlateNO = '${plateNo.substring(0, 3)}-mo-${plateNo.substring(5)}';
        break;

      case 'موتور سيکلت دولتي':
        finalPlateNO = '${plateNo.substring(0, 3)}-md-${plateNo.substring(4)}';
        break;
    }
    return finalPlateNO.replaceAll(RegExp(r'\b-+'), "-");
}