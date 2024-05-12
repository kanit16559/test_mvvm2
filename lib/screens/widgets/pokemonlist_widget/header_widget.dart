import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Pokédex',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 8.h,),
          Row(
            children: [
              Expanded(
                child: TextField(
                  // controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIconColor: Colors.blue,
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
              // SizedBox(width: 16.w,),
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //     padding: const EdgeInsets.all(10),
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       // borderRadius: BorderRadius.circular(70),
              //       color: Colors.white,
              //     ),
              //     child: Image.asset('assets/images/text_format.png',
              //       height: 16.h,
              //       width: 16.w,
              //       color: Colors.blue,
              //     ),
              //   ),
              // )
            ],
          ),
          SizedBox(height: 20.h,),
        ],
      ),
    );
  }
}
