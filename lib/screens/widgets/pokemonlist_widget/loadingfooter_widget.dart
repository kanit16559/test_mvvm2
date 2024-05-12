import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadingFooterWidget extends StatelessWidget {
  const LoadingFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        if (mode == LoadStatus.loading) {
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.red,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
