import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/datas.dart';
import '../providers/dress_provider.dart';
import '../widgets/ad_widget.dart';
import '../widgets/header_widget.dart';
import 'add_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedFilter = 0;
  List filterData = ["Recommend", "Outer", "Shirt", "Saree"];
  // List imageList = [
  //   'assets/images/1.jpg',
  //   'assets/images/2.jpg',
  //   'assets/images/3.jpg',
  //   'assets/images/4.jpg',
  //   'assets/images/5.jpg',
  //   'assets/images/6.jpg',
  //   'assets/images/7.jpg',
  //   'assets/images/8.jpg',
  //   'assets/images/9.jpg',
  //   'assets/images/10.jpg',
  //   "assets/images/11.jpg",
  // ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // var provider = Provider.of<DressProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title: const Text("Home Screen")),
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeaderWidget(),
                  const SizedBox(height: 20),
                  // ad widget
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: AdWidget(),
                  ),
                  // filters
                  filterWidget(),

                  Consumer<DressProvider>(
                    builder: (context, provider, child) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 1 / 1.7,
                        ),
                        itemCount: sampleDresses.length,
                        itemBuilder: (context, index) {
                          // Build your grid item widget here
                          return Container(
                            height: 400,
                            width: MediaQuery.of(context).size.width * 0.40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              offset: const Offset(0,
                                                  3), // Offset to control the position of the shadow
                                            ),
                                          ],
                                          // color: Colors.green,
                                        ),
                                        child: SizedBox(
                                          width: width,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                8), // Same radius as in the container
                                            child: provider.getDressList[index]
                                                    .imageUrl
                                                    .contains("assets/images/")
                                                ? Image.asset(
                                                    provider.getDressList[index]
                                                        .imageUrl,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.file(
                                                    File(provider
                                                        .getDressList[index]
                                                        .imageUrl),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          height: 25,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: const Color(0xffF45858),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "-${sampleDresses[index].offer}%",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    color: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.3,
                                            child: Text(
                                              provider.getDressList[index].name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "\$ ${provider.getDressList[index].price}",
                                            style: const TextStyle(
                                              color: Color(0xffF45858),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Image.asset("assets/icons/heart.png",
                                          height: 20, width: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Other widgets below the GridView
                  // ...
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddProductScreen()));
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Padding filterWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            filterData.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Material(
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() {
                      selectedFilter = index;
                    });
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: selectedFilter == index
                          ? Colors.black
                          : Colors.transparent,
                      border: Border.all(
                          color: selectedFilter == index
                              ? Colors.black
                              : Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        filterData[index],
                        style: TextStyle(
                            color: selectedFilter == index
                                ? Colors.white
                                : Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
