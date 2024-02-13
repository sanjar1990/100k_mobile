import 'package:flutter/material.dart';

import 'app_info.dart';

class Comfortable extends StatelessWidget {
  const Comfortable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Text(
          '100k.uz qulayliklari',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black
              ),
        ),
         const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppInfo(
              icon: Icons.fire_truck,
              title: 'Tezkor yetkazib berish xizmati',
              description:
                  'Buyurtmangiz O\'zbekistonning barcha viloyatlariga 3 kun ichida yetqazib beriladi.',
            ),
            AppInfo(
              icon: Icons.money,
              title: 'To\'lov istalgan usulda',
              description:
                  'Buyurtmani oldindan click, payme yoki buyurtmani qo\'lingizga olganingizdan keyin amalga oshiring.',
            ),
            AppInfo(
              icon: Icons.call,
              title: 'CALL-CENTER',
              description:
                  'Dam olish kunlarisiz qo\'llab quvvatlash bo\'limi mavjud. +998 55 500 55-11',
            ),
            AppInfo(
              icon: Icons.card_giftcard,
              title: 'Mijozlarni rag\'batlantirish tizimi',
              description:
                  'Doimiy mijozlar uchun sovg\'alar va bonuslar taqdim etiladi.',
            ),
          ],
        )
      ],
    );
  }
}
