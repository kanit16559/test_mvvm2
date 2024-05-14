import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_mvvm2/core/utils/injections.dart';
import 'package:test_mvvm2/view_models/pokemondetail_viewmodel/pokemondetail_viewmodel.dart';

import '../../../models/pokemonlist_model/pokemon_model.dart';
import '../../../repository/pokemondetail_repository.dart';
import '../../widgets/pokemondetail_widget/detail_widget.dart';
import 'dart:math' as math ;

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key, required this.pokemonModel});

  final PokemonModel pokemonModel;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {

  final PokemonDetailViewModel viewModel = PokemonDetailViewModel(
    pokemonDetailRepository: locator<PokemonDetailRepository>()
  );
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int convertId = int.parse(widget.pokemonModel.id ?? "0");
      viewModel.getDataDetail(convertId);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff74CB48),
              image: DecorationImage(
                  image: ExactAssetImage('assets/images/bg_pokeball.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topRight
              )
            ),
            child: SafeArea(
              bottom: true,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: ()=> Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: Colors.white)
                        ),
                        SizedBox(width: 8.w),
                        Text(widget.pokemonModel.name, style: TextStyle(fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.w700),),
                        const Spacer(),
                        Text(widget.pokemonModel.id.toString(), style: TextStyle(fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.w700),)
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h,),
                  Hero(
                    tag: "imageUrl_${widget.pokemonModel.id}",
                    flightShuttleBuilder: (
                      BuildContext flightContext,
                      Animation<double> animation,
                      HeroFlightDirection flightDirection,
                      BuildContext fromHeroContext,
                      BuildContext toHeroContext,
                    ){
                      final Widget widget = toHeroContext.widget;

                      return ScaleTransition(
                        scale: animation.drive(
                          Tween<double>(begin: 0.0, end: 1.0).chain(
                            CurveTween(
                              curve: Interval(
                                0.0, 1.0,
                                curve: PeakQuadraticCurve()
                              ),
                            ),
                          ),
                        ),
                        child: flightDirection == HeroFlightDirection.push
                            ? RotationTransition(
                          turns: animation,
                          child: widget,
                        )
                            : FadeTransition(
                          opacity: animation.drive(
                            Tween<double>(begin: 0.0, end: 1.0).chain(
                              CurveTween(
                                curve: Interval(0.0, 1.0,
                                    curve: PeakQuadraticCurve()),
                              ),
                            ),
                          ),
                          child: widget
                        ),
                      );

                      // return RotationTransition(
                      //   turns: animation,
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     child: Image.network(widget.pokemonModel.imageUrl, fit: BoxFit.cover, width: 200.w, height: 200.w),
                      //   ),
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.network(widget.pokemonModel.imageUrl, fit: BoxFit.cover, width: 200.w, height: 200.w),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                        margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.white
                        ),
                        child: const DetailWidget(),
                      )
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class PeakQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return -10 * math.pow(t, 2) + 10 * t + 1;
  }
}
