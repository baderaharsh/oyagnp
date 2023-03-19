import 'package:flutter/material.dart';
import 'package:omgnp/Patti/PattiHeader.dart';
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
              Row(
                children: [
                  Checkbox(value: isBatav, onChanged: (value) => setState(() {
                    isBatav = value!;
                  })),
                  const Text("Batav?", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              PattiHeader(newPatti['customer'], newPatti['date'], newPatti['rst'], newPatti['vehicle'], address: newPatti['address'], broker: newPatti['broker'],),
              PattiTable(particulars, newPatti['brokerage'], newPatti['kata'], mandi, isBatav, batav, grandTotal)
            ],
          ),
        ),
      ),
    );
  }
}
