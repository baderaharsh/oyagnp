import 'package:flutter/material.dart';
import 'package:omgnp/Data/Format.dart';

class PattiHeader extends StatelessWidget {
  final String customer;
  final DateTime date;
  final String address;
  final List<int> rst;
  final String vehicle;
  final String broker;
  const PattiHeader(this.customer, this.date, this.rst,
      this.vehicle,
      {super.key, this.address = "", this.broker = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("Date : ${Format.date(date)}")],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                customer,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              if (address != "")
              Text(', $address'),
            ],
          ),
          Row(
            children: [const Text("RST : "), Text(rst.join(', '))],
          ),
          Text("Vehicle Number : $vehicle"),
          if (broker != "")
          Text("Broker : $broker")
        ],
      ),
    );
  }
}
