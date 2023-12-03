import 'package:parkban/presentation/Widgets/plates/defence_plate_widget.dart';
import 'package:parkban/presentation/Widgets/plates/diplomat_plate_widget.dart';
import 'package:parkban/presentation/Widgets/plates/sepah_plate_widget.dart';
import 'package:parkban/presentation/widgets/plates/personal_plate_widget.dart';
import 'package:parkban/presentation/widgets/plates/police_plate_widget.dart';
import 'package:parkban/presentation/widgets/plates/political_plate_widget.dart';
import 'package:parkban/presentation/widgets/plates/protocol_plate_widget.dart';
import 'package:parkban/presentation/widgets/plates/temporary_plate_widget.dart';
import 'package:parkban/presentation/widgets/plates/transit_plate_widget.dart';
import 'package:parkban/presentation/widgets/plates/vetrans_plate_widget.dart';
import 'package:flutter/material.dart';

import 'army_plate_widget.dart';
import 'general_plate_widget.dart';
import 'government_plate_widget.dart';
import 'military_plate_widget.dart';
import 'motor_government_plate_widget.dart';
import 'motor_plate_widget.dart';

class PlatesKeys {
  GlobalKey<PersonalPlateState> personalPlateKey = GlobalKey<PersonalPlateState>(debugLabel: '_personalPlateKey');
  GlobalKey<GeneralPlateState> generalPlateKey = GlobalKey<GeneralPlateState>(debugLabel: '_generalPlateKey');
  GlobalKey<ArmyPlateState> armyPlateKey = GlobalKey<ArmyPlateState>(debugLabel: '_armyPlateKey');
  GlobalKey<GovernmentPlateState> governmentPlateKey = GlobalKey<GovernmentPlateState>(debugLabel: '_governmentPlateKey');

  GlobalKey<MilitaryPlateState> militaryPlateKey = GlobalKey<MilitaryPlateState>(debugLabel: '_militaryPlateKey');
  GlobalKey<DefencePlateState> defenceKzPlateKey = GlobalKey<DefencePlateState>(debugLabel: '_defenceKzPlateKey');

  GlobalKey<MotorGovernmentPlateState> motorGovernmentPlateKey = GlobalKey<MotorGovernmentPlateState>(debugLabel: '_motorGovernmentPlateKey');
  GlobalKey<MotorPlateState> motorPlateKey = GlobalKey<MotorPlateState>(debugLabel: '_motorPlateKey');

  GlobalKey<PolicePlateState> policePlateKey = GlobalKey<PolicePlateState>(debugLabel: '_policePlateKey');
  GlobalKey<SepahPlateState> sepahKzPlateKey = GlobalKey<SepahPlateState>(debugLabel: '_sepahPlateKey');

  GlobalKey<PoliticalPlateState> politicalPlateKey = GlobalKey<PoliticalPlateState>(debugLabel: '_politicalPlateKey');
  GlobalKey<DiplomatPlateState> diplomatKzPlateKey = GlobalKey<DiplomatPlateState>(debugLabel: '_diplomatKzPlateKey');

  GlobalKey<ProtocolPlateState> protocolPlateKey = GlobalKey<ProtocolPlateState>(debugLabel: '_protocolPlateKey');
  GlobalKey<TransitPlateState> transitPlateKey = GlobalKey<TransitPlateState>(debugLabel: '_transitPlateKey');
  GlobalKey<VetransPlateState> vetransPlateKey = GlobalKey<VetransPlateState>(debugLabel: '_vetransPlateKey');
  GlobalKey<TemporaryPlateState> temporaryPlateKey = GlobalKey<TemporaryPlateState>(debugLabel: '_temporaryPlateKey');
}
