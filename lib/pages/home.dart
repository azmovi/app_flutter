import 'package:app_flutter/models/category_model.dart';
import 'package:app_flutter/models/diet_model.dart';
import 'package:app_flutter/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          SizedBox(
            height: 40,
          ),
          _categoriesSection(),
          SizedBox(
            height: 40,
          ),
          _dietSection(),
          SizedBox(
            height: 40,
          ),
          _popularSection(),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Column _popularSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Popular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.separated(
              itemCount: popularDiets.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                height: 25,
              ),
              padding: EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: popularDiets[index].boxIsSelected
                          ? [
                              BoxShadow(
                                  color: const Color(0xff1D1617)
                                      .withValues(alpha: 0.07),
                                  offset: const Offset(0, 10),
                                  blurRadius: 40,
                                  spreadRadius: 0)
                            ]
                          : []),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          popularDiets[index].iconPath,
                          width: 65,
                          height: 65,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popularDiets[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}',
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                            'assets/icons/button.svg',
                            colorFilter:
                                ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                            width: 30,
                            height: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        );
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Recommendation \nfor Diet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                    color: diets[index].boxColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        diets[index].iconPath,
                        width: 75,
                        height: 75,
                      ),
                    ),
                    Text(
                      diets[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 130,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            diets[index].viewIsSelected
                                ? const Color(0xff9DCEFF)
                                : Colors.transparent,
                            diets[index].viewIsSelected
                                ? const Color(0xff92A3FD)
                                : Colors.transparent
                          ]),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        'View',
                        style: TextStyle(
                            color: diets[index].viewIsSelected
                                ? Colors.white
                                : const Color(0xffC58BF2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 25,
            ),
            itemCount: diets.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20, right: 20),
          ),
        )
      ],
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Category',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20, right: 20),
            itemCount: categories.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 25,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                    color: categories[index].boxColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(categories[index].iconPath),
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xff1d1617).withValues(alpha: 0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        )
      ]),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(15),
            hintText: 'Search Pancake',
            hintStyle: TextStyle(
              color: Colors.grey.withValues(alpha: 0.5),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/icons/search.svg',
                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
            ),
            suffixIcon: SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset('assets/icons/filter.svg',
                          colorFilter:
                              ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Breakfast',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icons/arrow-left.svg',
          height: 30,
          width: 30,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 20,
              width: 20,
            ),
          ),
        )
      ],
    );
  }
}
