import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  const Custombutton(
      {super.key,
      required this.categoryname,
      required this.itemname,
      required this.itemimage,
      required this.selcolor});
  final String categoryname;
  final String itemname;
  final AssetImage itemimage;
  final Color selcolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 112,
            width: 110,
            decoration: BoxDecoration(
              color: selcolor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: const Icon(
                        Icons.done,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(20, -15),
                      child: Image(
                        image: itemimage,
                        width: 65,
                        height: 65,
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Text(
                    categoryname,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: SizedBox(
            width: 110,
            child: Text(
              itemname,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
