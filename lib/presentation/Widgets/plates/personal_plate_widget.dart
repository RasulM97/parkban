import 'package:flutter/material.dart';

class PersonalPlate extends StatefulWidget {
  PersonalPlate({
    required this.width,
    this.num1,
    this.num2,
    this.letter,
    this.letters,
    this.num3,
    this.autofocus = false,
    this.enable = false,
    Key? key,
  }) : super(key: key);

  double width;
  String? num1;
  String? num2;
  String? letter;
  List<String>? letters;
  String? num3;
  bool autofocus;
  bool enable;

  static const String id = 'شخصي';

  @override
  State<PersonalPlate> createState() => PersonalPlateState();
}

class PersonalPlateState extends State<PersonalPlate> {
  late TextEditingController num1Controller;
  late TextEditingController num2Controller;
  late TextEditingController num3Controller;

  late FocusNode num1FocusNode;
  late FocusNode num2FocusNode;
  late FocusNode num3FocusNode;

  String letter = 'ي';
  List<String> letters = [];

  @override
  void initState() {
    super.initState();

    letter = widget.letter ?? 'ي';
    letters = widget.letters ??
        [
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
        ];

    num1Controller = TextEditingController();
    if (widget.num1 != null && widget.num1!.trim().length == 2) {
      num1Controller.text = widget.num1!.trim();
    }

    num2Controller = TextEditingController();
    if (widget.num2 != null && widget.num2!.trim().length == 3) {
      num2Controller.text = widget.num2!.trim();
    }

    num3Controller = TextEditingController();
    if (widget.num3 != null && widget.num3!.trim().length == 2) {
      num3Controller.text = widget.num3!.trim();
    }

    num1FocusNode = FocusNode();
    num2FocusNode = FocusNode();
    num3FocusNode = FocusNode();
  }

  @override
  void dispose() {
    num1Controller.dispose();
    num2Controller.dispose();
    num3Controller.dispose();

    num1FocusNode.dispose();
    num2FocusNode.dispose();
    num3FocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    // CurrentPlateProvider currentPlateProvider = Provider.of<CurrentPlateProvider>(context, listen: false);

    num1Controller.addListener(() {
      if (num1Controller.text.trim().length == 2) {
        num2FocusNode.requestFocus();
      }
    });

    num2Controller.addListener(() {
      if (num2Controller.text.trim().length == 3) {
        num3FocusNode.requestFocus();
      }
    });

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: widget.width * 0.80,
        height: widget.width * 0.18,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E3399),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        '🇮🇷',
                        style: TextStyle(color: Colors.white, fontSize: widget.width * 0.038, fontWeight: FontWeight.bold),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        'I.R.\nIRAN',
                        style: TextStyle(
                              fontSize: widget.width * 0.028,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: num1Controller,
                focusNode: num1FocusNode,
                autofocus: widget.autofocus,
                enabled: widget.enable,
                keyboardType: TextInputType.number,
                maxLines: 1,
                maxLength: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Btitr',color: Colors.black, fontSize: 38, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(1),
                  filled: true,
                  fillColor: Colors.transparent,
                  counterText: '',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: PopupMenuButton(
                padding: EdgeInsets.zero,
                enabled: widget.enable,
                iconSize: widget.width * 0.26 * 0.64,
                icon: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: Text(
                    letter,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Btitr' ,color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                initialValue: letter,
                onSelected: (value) {
                  setState(() {
                    letter = value.toString();
                  });
                },
                itemBuilder: (context) {
                  return (letters.isNotEmpty)
                      ? letters
                          .map(
                            (String char) => PopupMenuItem(
                              value: char,
                              child: Center(
                                child: Text(
                                  char,
                                  textScaleFactor: 1.2,
                                  style: TextStyle(fontFamily: 'BTitr', color: Colors.black, fontSize: 32/*isTablet ? 18 : 14*/, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                          .toList()
                      : <PopupMenuItem>[];
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                controller: num2Controller,
                focusNode: num2FocusNode,
                enabled: widget.enable,
                keyboardType: TextInputType.number,
                maxLines: 1,
                textAlign: TextAlign.center,
                maxLength: 3,
                style: TextStyle(fontFamily: 'Btitr',color: Colors.black, fontSize: 38, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(1),
                  filled: true,
                  fillColor: Colors.transparent,
                  counterText: '',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(1),
                decoration: const BoxDecoration(border: Border(left: BorderSide(width: 2))),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    // alignment: Alignment.topCenter,
                    children: [
                      // Text(
                      //   'ایران',
                      //   style: TextStyle(color: Colors.black, fontSize: widget.width * 0.04, fontWeight: FontWeight.bold, fontFamily: 'AGhasem'),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: isTablet ? 2 : 1),
                        child: Image.asset('assets/images/Iran1.png', width: double.infinity,fit: BoxFit.fitWidth,),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: const Offset(0, -15),
                          child: TextField(
                            controller: num3Controller,
                            focusNode: num3FocusNode,
                            enabled: widget.enable,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            maxLength: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Btitr',color: Colors.black, fontSize: 38, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              counterText: '',
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                              disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
