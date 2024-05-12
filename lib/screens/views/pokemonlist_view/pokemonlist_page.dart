
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_mvvm2/core/utils/injections.dart';

import '../../../models/pokemon_model.dart';
import '../../../repository/pokemonlist_repository.dart';
import '../../../view_models/pokemonlist/pokemonlist_viewmodel.dart';
import '../../../view_models/pokemonlist/state/pokemonlist_state.dart';
import '../../widgets/pokemonlist_widget/header_widget.dart';
import '../../widgets/pokemonlist_widget/item_widget.dart';
import '../../widgets/pokemonlist_widget/loadingfooter_widget.dart';
import '../../widgets/pokemonlist_widget/loadingheader_widget.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {

  PokemonListViewModel viewModel = PokemonListViewModel(
    pokemonListRepository: locator<PokemonListRepository>()
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchData(isNewFetch: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, snapshot) {
        return Builder(
          builder: (context) {
            return Scaffold(
              // appBar: AppBar(
              //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              //   title: Text("MarvelView"),
              // ),
              backgroundColor: Colors.red,
              body: SafeArea(
                child: Column(
                  children: [
                    const HeaderWidget(),
                    _buildBody(context),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget _buildBody(BuildContext context){
    final controller = context.watch<PokemonListViewModel>();
    final getPokemonState = controller.state;
    Widget widget = Container();

    switch(getPokemonState.status){
      case AppPokemonListStatus.initial:
      case AppPokemonListStatus.loading: {
        widget = const Center(child: CircularProgressIndicator());
      }
      case AppPokemonListStatus.failure: {
        widget = const Center(
          child: Text(
              "Failure !!!"
          ),
        );
      }
      case AppPokemonListStatus.success: {
        List<PokemonModel> getValueList = getPokemonState.value!;
        widget = SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.onRefresh(),
          onLoading: () => controller.onLoading(),
          header: const LoadingHeaderWidget(),
          footer: const LoadingFooterWidget(),
          child: GridView.builder(
            itemCount: getValueList.length,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ItemWidget(
                  item: getValueList[index]
              );
            },
          ),
        );
      }
      default: {
        widget = Container();
      }

    }

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white
        ),
        child: widget,
      ),
    );
  }
}
