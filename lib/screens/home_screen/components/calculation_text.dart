import 'package:calculator_app/provider/calculation_prodiver.dart';
import 'package:calculator_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculationText extends ConsumerWidget {
  const CalculationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculationNotifier = ref.watch(calculationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //Alt öğesini kendi içinde sığdırmaya göre ölçekleyen ve konumlandıran bir pencere öğesi oluşturur .
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            calculationNotifier.prevData,
            style: TextStyle(
              fontSize: 32,
              color: kSecondaryColor.withOpacity(0.7),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
         FittedBox(
            fit: BoxFit.fitWidth,
            child:  Text(
              calculationNotifier.data,
              
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            )
            ),
      ],
    );
  }
}
