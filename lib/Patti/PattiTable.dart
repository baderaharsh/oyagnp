import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omgnp/Widgets/UI/TableHeading.dart';
import 'package:omgnp/Widgets/UI/TableText.dart';

class PattiTable extends StatelessWidget {
  final List<Map<String, dynamic>> particulars;
  final int brokerage;
  final int kata;
  final int mandi;
  final bool isBatav;
  final int batav;
  final int grandTotal;

  const PattiTable(this.particulars, this.brokerage, this.kata, this.mandi,
      this.isBatav, this.batav, this.grandTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FractionColumnWidth(0.35),
        1: FractionColumnWidth(0.65)
      },
      border: TableBorder.all(borderRadius: BorderRadius.circular(10)),
      children: [
        const TableRow(children: [
          TableCell(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Particulars",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          )),
          TableCell(child: Text(""))
        ]),
        TableRow(
          children: [
            const TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text("Cotton Kapas",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            TableCell(
                child: Table(
              border: TableBorder.symmetric(inside: const BorderSide(width: 1)),
              children: [
                const TableRow(children: [
                  TableCell(child: TableHeading("Weight (Qtl)")),
                  TableCell(child: TableHeading("Rate")),
                  TableCell(child: TableHeading("Subtotal"))
                ]),
                ...particulars
                    .map<TableRow>((particular) =>
                        TableRow(children: <TableCell>[
                          TableCell(
                              child:
                                  TableText(particular['weight'].toString())),
                          TableCell(
                              child: TableText(particular['rate'].toString())),
                          TableCell(
                              child: TableText(
                                  (particular['subtotal']).toString())),
                        ]))
                    .toList()
              ],
            ))
          ],
        ),
        TableRow(children: [
          TableCell(
            child: Container(),
          ),
          TableCell(
              child: Table(
            border: TableBorder.symmetric(inside: const BorderSide(width: 1)),
            children: [
              TableRow(children: [
                TableCell(child: Container()),
                const TableCell(child: TableHeading("Brokerage")),
                TableCell(child: TableText('- $brokerage'))
              ]),
              TableRow(children: [
                TableCell(child: Container()),
                const TableCell(child: TableHeading("Kata")),
                TableCell(child: TableText('- $kata'))
              ]),
              TableRow(children: [
                TableCell(child: Container()),
                const TableCell(child: TableHeading("Mandi")),
                TableCell(child: TableText('- $mandi'))
              ]),
              if (isBatav)
                TableRow(children: [
                  TableCell(child: Container()),
                  const TableCell(child: TableHeading("Batav")),
                  TableCell(child: TableText('- $batav'))
                ])
            ],
          ))
        ]),
        TableRow(children: [
          const TableCell(child: TableHeading("Total", size: 18,)),
          TableCell(child: TableText(NumberFormat.currency(locale: 'en-IN', decimalDigits: 0).format(grandTotal), size: 18, textAlign: TextAlign.center,))
        ])
      ],
    );
  }
}
