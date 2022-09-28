import 'package:calculator_app/provider/calculation_prodiver.dart';
import 'package:calculator_app/utils/constants.dart';

// hide ve inset box shadow kullanım amacı : (inset) :Flutter inset kutusu şu anda gölgeler için iç metin özelliğini desteklemiyor.
//Bu gölge türü örneğin Neumorfizm'de kullanılır.
//Bu paket, başlangıç özelliğini desteklemek için BoxShadow ve BoxDecoration'ı genişletir.
//BoxShadow'un tüm özellikleri desteklenir.
//Bir geçiş sırasında bir BoxShadow'un özelliği değişirse, yeni bir geçiş yapmadan önce eski gölgeyi ortadan kaldırırız.
// bu şekilde yazarız import 'package:flutter/material.dart' gizle BoxDecoration, BoxShadow; import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
//Kullanılan algoritma Blink, Chromium render motoru ile aynıdır.
//Fikir, içinde başka bir yuvarlak dikdörtgenle oyulmuş bir dikdörtgen çizmek ve sonra bu oyuk dikdörtgeni bulanıklaştırmak.

import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum: Numaralandırma, farklı nesne türlerini temsil etmek için kullanılabilecek bir değerler listesi oluşturmanıza izin veren bir veri türüdür.
//Numaralandırmalar, çok sayıda olası değeri temsil etmeniz gerektiğinde ve her biri için ayrı bir değişken oluşturmak istemediğinizde kullanışlıdır.

enum Shape {
  square,
  circle,
  stadium,
}

/// consumer stateful widget : Tüketici durum bilgisi olan bir pencere öğesi, pencere öğesi tarafından nasıl davranılacağını belirlemek için kullanılan kendi durumunu koruyan bir pencere öğesidir.
///  Bu durum, kullanıcının mevcut konumu, saati veya mevcut öğe listesi hakkındaki bilgileri içerebilir
//

// Neumorfik Düğme Tasarımı yaılan sayfa bilgileri aşağıdaki gibidir.

class CalculatorButton extends ConsumerStatefulWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontweight;
  final double width;
  final Shape shape;

  const CalculatorButton({
    Key? key,
    required this.text,
    this.textColor = kSecondaryColor,
    this.fontSize = 40,
    this.fontweight = FontWeight.bold,
    this.width = 68,
    this.shape = Shape.square,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalculatorButtonState();
}

class _CalculatorButtonState extends ConsumerState<CalculatorButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.shape == Shape.circle
        ? null
        : BorderRadius.circular(widget.shape == Shape.square ? 20 : 36);
    final shape =
        widget.shape == Shape.circle ? BoxShape.circle : BoxShape.rectangle;

    //Listener : Flutter'daki bir dinleyici, bir widget'tan olayları alan bir nesnedir.
    // Genellikle bir pencere öğesinin durumunu takip etmek ve bu durumdaki değişikliklere yanıt vermek için kullanılır.

    return Listener(
      //onPointerDown: Bu widget'ın konumunda bir işaretçi ekranla temas ettiğinde (dokunma işaretçileri için) veya düğmesine basıldığında (fare işaretçileri için) çağrılır.
      onPointerDown: (_) => setState(() {
        isPressed = true;
      }),

      onPointerUp: (_) => setState(() {
        isPressed = false;

        final provider = ref.read(calculationProvider.notifier);
        if (widget.shape == Shape.square) {
          provider.addSign(widget.text);
        } else {
          provider.addNumber(widget.text);
        }
      }),

      //AnimatedContainer: Değerlerini belirli bir süre içinde kademeli olarak değiştiren Container'ın animasyonlu versiyonu .

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        height: 68,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          shape: shape,
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              //offset: Gölgenin döküm elemanından yer değiştirmesi.

              offset: const Offset(-2, -2),
              blurRadius: 5,
              color: const Color(0x80FFFFFF),
              inset: isPressed,
            ),
            BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 5,
              color: const Color(0x80838E9E),
              inset: isPressed,
            ),
            BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 5,
              color: isPressed ? Colors.transparent : const Color(0xCCFFFFFF),
              inset: true,
            ),
            BoxShadow(
              offset: const Offset(-2, -2),
              blurRadius: 5,
              color: isPressed ? Colors.transparent : const Color(0x66838E9E),
              inset: true,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: widget.fontweight,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
