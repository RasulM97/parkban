import 'package:flutter/material.dart';

class MotorPlate extends StatefulWidget {
  MotorPlate({required this.width, this.num1, this.num2, this.enable = false, Key? key}) : super(key: key);

  double width;
  String? num1;
  String? num2;
  bool enable;

  static const String id = 'موتور سيکلت';

  @override
  State<MotorPlate> createState() => MotorPlateState();
}

class MotorPlateState extends State<MotorPlate> {
  late TextEditingController num1Controller;
  late TextEditingController num2Controller;

  late FocusNode num1FocusNode;
  late FocusNode num2FocusNode;

  @override
  void initState() {
    super.initState();

    num1Controller = TextEditingController();
    if (widget.num1 != null && widget.num1!.trim().length == 3) {
      num1Controller.text = widget.num1!.trim();
    }

    num2Controller = TextEditingController();
    if (widget.num2 != null && widget.num2!.trim().length == 5) {
      num2Controller.text = widget.num2!.trim();
    }

    num1FocusNode = FocusNode();
    num2FocusNode = FocusNode();

    num1Controller.addListener(() {
      if (num1Controller.text.length == 3) {
        num2FocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    num1Controller.dispose();
    num2Controller.dispose();

    num1FocusNode.dispose();
    num2FocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: widget.width * 0.45,
        height: widget.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E3399),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '🇮🇷',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white, fontSize: widget.width * 0.038, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'I.R.\nIRAN',
                              style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: widget.width * 0.028,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: num1Controller,
                      focusNode: num1FocusNode,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLength: 3,
                      textAlign: TextAlign.center,
                      cursorColor: Colors.black,
                      style: TextStyle(fontFamily: 'BTitr',
                            color: Colors.black,
                            fontSize: widget.width * 0.1,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(2),
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
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: TextField(
                  controller: num2Controller,
                  focusNode: num2FocusNode,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  maxLength: 5,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.black,
                  style: TextStyle(fontFamily: 'BTitr',
                        color: Colors.black,
                        fontSize: widget.width * 0.1,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(2),
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
    );
  }
}
