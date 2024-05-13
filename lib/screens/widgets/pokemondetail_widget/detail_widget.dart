
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:test_mvvm2/models/pokemondetail_model/pokemondetail_model.dart';

import '../../../view_models/pokemondetail_viewmodel/pokemondetail_viewmodel.dart';
import '../../../view_models/pokemondetail_viewmodel/state/pokemondetail_state.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final state = context.watch<PokemonDetailViewModel>().state;
    Widget widgetBuilder = Container();
    switch(state.status){
      case AppPokemonDetailStatus.initial:
      case AppPokemonDetailStatus.loading:
        widgetBuilder = const Center(child: CircularProgressIndicator());
      case AppPokemonDetailStatus.success:
        final PokemonDetailModel pokemonDetailModel = state.value!;
        widgetBuilder = _buildBodyDetailWidget(context ,pokemonDetailModel);
      case AppPokemonDetailStatus.failure:
      default: widgetBuilder = const Center(child: Text('Error'));
    }
    return widgetBuilder;
  }


  Widget _buildBodyDetailWidget(BuildContext context, PokemonDetailModel detail){
    int getMaximumStats = context.watch<PokemonDetailViewModel>().sumMaximumStats(detail.stats);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildLabelTypeWidget(detail.types),
        ),
        SizedBox(height: 16.h,),
        Text('About', style: TextStyle(color: const Color(0xff74CB48), fontSize: 14.sp, fontWeight: FontWeight.w700),),
        SizedBox(height: 16.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey, width: 0.2))
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/ic_weight.png', height: 16.w, width: 16.w),
                      SizedBox(width: 8.w),
                      Text('${detail.weight} kg', style: TextStyle(color: const Color(0xff1D1D1D), fontSize: 10.sp, fontWeight: FontWeight.w400),)
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Text('Weight', style: TextStyle(color: const Color(0xff666666), fontSize: 8.sp, fontWeight: FontWeight.w400),)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.grey, width: 0.2))
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/ic_straighten.png', height: 16.w, width: 16.w),
                      SizedBox(width: 8.w),
                      Text('${detail.height} m', style: TextStyle(color: const Color(0xff1D1D1D), fontSize: 10.sp, fontWeight: FontWeight.w400),)
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Text('Height', style: TextStyle(color: const Color(0xff666666), fontSize: 8.sp, fontWeight: FontWeight.w400),)
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 16.h,),
        Text('Base Stats', style: TextStyle(color: const Color(0xff74CB48), fontSize: 14.sp, fontWeight: FontWeight.w700),),
        SizedBox(height: 16.h,),
        Expanded(
          child: ListView.builder(
            itemCount: detail.stats.length,
            itemBuilder: (context, index){
              return _buildStatsWidget(index, detail.stats[index], getMaximumStats);
            }
          )
        )
      ],
    );
  }

  List<Widget> _buildLabelTypeWidget(List<Type> types){
    List<Widget> listWidget = [];
    for (Type element in types) {
      listWidget.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: const Color(0xff74CB48),
          ),
          child: Text(element.type.name, style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w700),),
        )
      );
    }
    return listWidget;
  }

  Widget _buildStatsWidget(int index, Stats status, int maximumStats){
    return Row(
      children: [
        Expanded(flex: 2, child: Text('${status.stat.name} : ${status.baseStat} ')),
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 700 + (index * 100)),
              curve: Curves.easeInOut,
              tween: Tween<double>(
                begin: 0,
                end: status.baseStat.toDouble(),
              ),
              builder: (context, value, _) {
                return StepProgressIndicator(
                  size: 10,
                  totalSteps: maximumStats,
                  // currentStep: _valueProgressBar(status.baseStat),
                  currentStep: value.toInt(),
                  padding: 0,
                  selectedColor: Colors.green,
                  unselectedColor: Colors.grey,
                );
              }
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text('Max : ${maximumStats} ')
      ],
    );
  }

}
