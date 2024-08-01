import 'dart:io';

import 'package:flutter/material.dart';

class Lead extends StatelessWidget {
  final String name;
  final String description;
  final String slot;
  final String landmark;
  final int distance;
  final String photo;

  const Lead({
    Key? key,
    required this.name,
    required this.description,
    required this.slot,
    required this.landmark,
    required this.distance,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0XFF693907), width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                photo,
                width: 400,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              " $name",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              '  Scrap Description: $description',
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '  Slot: $slot',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              '  Landmark: $landmark',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              '  $distance km away',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text(
                    'Reject',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF693907),
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
