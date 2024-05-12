import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/pokemon_model.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});

  final PokemonModel item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadows: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 3,
                offset: Offset(0, 1),
                spreadRadius: 1,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            // padding: EdgeInsets.only(top: 48),
            height: 44,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                borderRadius: BorderRadius.circular(7)
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          left: 0,
          right: 0,
          child: Text(
            item.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF1C1C1C),
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),),
        ),
        Align(
          alignment: Alignment.center,
          child: Image.network(
            item.imageUrl,
            height: 72.h,
            width: 72.w,
          ),
        ),
        Positioned(
            top: 4,
            right: 8,
            child: Text(
              item.id ?? "0",
              style: TextStyle(
                color: const Color(0xFF666666),
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
              ),
            )
        )
        // Positioned(
        //     top: 4,
        //     right: 8,
        //     child: Text(
        //       item,
        //       style: TextStyle(
        //         color: const Color(0xFF666666),
        //         fontSize: 8.sp,
        //         fontWeight: FontWeight.w400,
        //       ),
        //     )
        // )
      ],
    );
  }
}
