import 'package:flutter/material.dart';
import 'package:omgnp/Data/Format.dart';
import 'package:omgnp/Patti/PattiTable.dart';

class NewPatti extends StatefulWidget {
  const NewPatti({super.key});

  static const pageRoute = "/patti";

  @override
  State<NewPatti> createState() => _NewPattiState();
}

class _NewPattiState extends State<NewPatti> {
  
  bool isBatav = true;
  @override
  Widget build(BuildContext context) {

    int grandTotal = 0;
    int batav = 0;
    final Map<String, dynamic> newPatti =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    List<Map<String, dynamic>> particulars = newPatti['particulars'];
    double totalWeight = 0;

    particulars.forEach((particular) {
      particular.putIfAbsent('subtotal', () => (particular['weight'] * particular['rate']).round());
      totalWeight += particular['weight'];
      grandTotal += int.parse('${particular['subtotal']}');
    });

    final mandi = (totalWeight * 30).round();
    
    grandTotal -= mandi;

    if(isBatav) {
      batav = (totalWeight * 50).round();
      grandTotal -= batav;
    }

    grandTotal -= int.parse('${newPatti['brokerage']}');
    grandTotal -= int.parse('${newPatti['kata']}');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Date : ${Format.date(newPatti['date'])}")
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(newPatti['customer'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                        if(newPatti['address'] != null)
                        Text(', ${newPatti['address']}'),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("RST : "),
                        Text(newPatti['rst'].join(', '))
                      ],
                    ),
                    Text("Vehicle Number : ${newPatti['vehicle']}"),
                    if(newPatti['broker'] != null)
                    Text("Broker : ${newPatti['broker']}")
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(value: isBatav, onChanged: (value) => setState(() {
                    isBatav = value!;
                  })),
                  const Text("Batav?", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              PattiTable(particulars, newPatti['brokerage'], newPatti['kata'], mandi, isBatav, batav, grandTotal)
            ],
          ),
        ),
      ),
    );
  }
}
