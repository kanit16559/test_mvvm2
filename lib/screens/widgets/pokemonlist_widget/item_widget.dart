import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/router/app_router_enum.dart';
import '../../../models/pokemonlist_model/pokemon_model.dart';
import '../../../view_models/pokemonlist_viewmodel/pokemonlist_viewmodel.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.item});

  final PokemonModel item;

  @override
  Widget build(BuildContext context) {
    final viewModelWatch = context.watch<PokemonListViewModel>();
    final viewModelRead = context.read<PokemonListViewModel>();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouteEnum.pokemonDetailPage.name,
          arguments: item,
        );
      },
      child: Stack(
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
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: highlightOccurrences(
                    item.name,
                    viewModelRead.textEditingController.text
                  ),
                  style: TextStyle(
                    color: const Color(0xFF1C1C1C),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  )
                ),
              ),
            ),
          ),
          Hero(
            tag: "imageUrl_${item.id}",
            child: Align(
              alignment: Alignment.center,
              child: Image.network(
                item.imageUrl,
                height: 72.h,
                width: 72.w,
              ),
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
      ),
    );
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [ TextSpan(text: source) ];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(
        TextSpan(
          text: source.substring(match.start, match.end),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            backgroundColor: Colors.yellow
          ),
        )
      );

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

}
