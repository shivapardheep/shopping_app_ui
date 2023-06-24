import 'package:flutter/material.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Opacity(
        opacity: 0.9,
        child: Container(
          height: height * 0.18,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
                image: AssetImage("assets/images/ad_image.jpg"),
                fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.black87.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset:
                    const Offset(0, 3), // changes the position of the shadow
              ),
            ],
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
