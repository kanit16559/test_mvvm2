import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadingHeaderWidget extends StatelessWidget {
  const LoadingHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext context, RefreshStatus? mode) {
        return const Column(
          children: [
            Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
            Center(
              child: Text(
                "Loading",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFBDBDBD),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
