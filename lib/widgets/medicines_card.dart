import 'package:flutter/material.dart';

class MedicinesCard extends StatelessWidget {
  const MedicinesCard({
    Key? key,
    required this.medicineInfo,
  }) : super(key: key);

  final List<Map> medicineInfo;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Name : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      medicineInfo[i]['name'],
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Dose : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      medicineInfo[i]['dose'],
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Strength : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      medicineInfo[i]['strength'],
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: medicineInfo.length,
    );
  }
}
