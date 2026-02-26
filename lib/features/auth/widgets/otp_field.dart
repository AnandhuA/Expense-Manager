import 'package:expense_manager/core/utils/validators.dart';
import 'package:flutter/material.dart';

class OtpInputField extends StatefulWidget {
  final Function(String otp) onCompleted;
  final String? otp;

  const OtpInputField({
    super.key,
    required this.onCompleted,
    required this.otp,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        focusNodes[index + 1].requestFocus();
      }
    } else {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }

    final otp = controllers.map((e) => e.text).join();

    if (otp.length == 6) {
      widget.onCompleted(otp);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.otp != null && widget.otp!.length == 6) {
      for (int i = 0; i < 6; i++) {
        controllers[i].text = widget.otp![i];
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onCompleted(widget.otp!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.all(5),
            child: TextFormField(
              validator: AppValidator.otpRequired,
              controller: controllers[index],
              focusNode: focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              decoration: InputDecoration(counterText: ""),
              onChanged: (value) => _onChanged(index, value),
            ),
          ),
        );
      }),
    );
  }
}
