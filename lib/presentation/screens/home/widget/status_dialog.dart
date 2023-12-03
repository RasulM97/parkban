import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StatusDialog extends StatelessWidget {
  const StatusDialog({Key? key, required this.massage, this.onSubmit, this.onSubmitText, this.onRetry, this.onRetryText}) : super(key: key);
  final String massage;
  final String? onSubmitText;
  final String? onRetryText;
  final void Function()? onSubmit;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('توجه', style: TextStyle(fontFamily: 'iransans')),
      content: Text(massage, style: const TextStyle(fontFamily: 'iransans')),
      actions: [
        CupertinoActionSheetAction(onPressed: onSubmit ?? () => Get.back(), child: Text(onSubmitText ?? 'تایید', style: const TextStyle(fontFamily: 'iransans'))),
        if(onRetry != null)CupertinoActionSheetAction(
            onPressed: onRetry ?? (){}, child: Text(onRetryText ?? '', style: const TextStyle(fontFamily: 'iransans'))),
      ],
    );
  }
}
