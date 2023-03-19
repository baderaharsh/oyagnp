import 'package:flutter/material.dart';
import 'package:omgnp/Widgets/UI/TableHeading.dart';
import 'package:omgnp/Widgets/UI/TableText.dart';

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

    double grandTotal = 0;
    int batav = 0;
    final Map<String, dynamic> newPatti =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    List<Map<String, dynamic>> particulars = newPatti['particulars'];
    double totalWeight = 0;

    particulars.forEach((particular) {
      particular.putIfAbsent('subtotal', () => (particular['weight'] * particular['rate']).round());
      totalWeight += particular['weight'];
      grandTotal += particular['subtotal'].toDouble();
    });
    
    // particulars.forEach((particular) => particular.putIfAbsent('subtotal', () => (particular['weight'] * particular['rate']).round()));
    // particulars.forEach((particular) => totalWeight += particular['weight'],);

    final mandi = (totalWeight * 30).round();
    
    grandTotal -= mandi;

    if(isBatav) {
      batav = (totalWeight * 50).round();
      grandTotal -= batav;
    }

    grandTotal -= newPatti['brokerage'];
    grandTotal -= newPatti['kata'];

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
              Table(
                columnWidths: const {
                  0 : FractionColumnWidth(0.35),
                  1 : FractionColumnWidth(0.65)
                },
                border: TableBorder.all(borderRadius: BorderRadius.circular(10)),
                children: [
                  const TableRow(
                    children: [
                      TableCell(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Particulars", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      )),
                      TableCell(child: Text(""))
                    ]
                  ),
                  TableRow(
                    children: [
                      const TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text("Cotton Kapas", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      TableCell(child: Table(
                        border: TableBorder.symmetric(
                          inside: const BorderSide(
                           width: 1 
                          )
                        ),
                        children: [const TableRow(
                          children: [
                            TableCell(child: TableHeading("Weight (Qtl)")),
                            TableCell(child: TableHeading("Rate")),
                            TableCell(child: TableHeading("Subtotal"))
                          ]
                        ),...particulars.map<TableRow>((particular) => TableRow(
                          children: <TableCell>[
                            TableCell(child: TableText(particular['weight'].toString())),
                            TableCell(child: TableText(particular['rate'].toString())),
                            TableCell(child: TableText((particular['subtotal']).toString())),
                          ]
                        )).toList()],
                      ))
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Container(),),
                      TableCell(child: Table(
                        border: TableBorder.symmetric(
                          inside: const BorderSide(
                           width: 1 
                          )
                        ),
                        children: [
                          TableRow(
                            children: [
                              TableCell(child: Container()),
                              const TableCell(child: TableHeading("Brokerage")),
                              TableCell(child: TableText('- ${newPatti['brokerage']}'))
                            ]
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Container()),
                              const TableCell(child: TableHeading("Kata")),
                              TableCell(child: TableText('- ${newPatti['kata']}'))
                            ]
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Container()),
                              const TableCell(child: TableHeading("Mandi")),
                              TableCell(child: TableText('- $mandi'))
                            ]
                          ),
                          if(isBatav)
                          TableRow(
                            children: [
                              TableCell(child: Container()),
                              const TableCell(child: TableHeading("Batav")),
                              TableCell(child: TableText('- $batav'))
                            ]
                          )
                        ],
                      ))
                    ]
                  ),
                  TableRow(
                    children: [
                      const TableCell(child: TableHeading("Grnad Total")),
                      TableCell(child: TableText('$grandTotal'))
                    ]
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
