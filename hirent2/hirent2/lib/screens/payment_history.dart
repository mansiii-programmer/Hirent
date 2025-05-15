import 'package:flutter/material.dart';

class PaymentHistoryPage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(date: '01 May 2025', description: 'Task completion: Gardening', amount: 750),
    Transaction(date: '25 Apr 2025', description: 'Task completion: Cleaning', amount: 500),
    Transaction(date: '15 Apr 2025', description: 'Withdrawal to bank account', amount: -400),
    Transaction(date: '10 Apr 2025', description: 'Task completion: Babysitting', amount: 1200),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'View all your past payments and earnings',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(5),
                2: FlexColumnWidth(2),
              },
              border: TableBorder(horizontalInside: BorderSide(color: Colors.grey.shade300)),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                ...transactions.map((tx) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(tx.date),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(tx.description, style: TextStyle(color: Colors.teal)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${tx.amount >= 0 ? '+' : '-'} ₹${tx.amount.abs()}',
                            style: TextStyle(
                              color: tx.amount >= 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String date;
  final String description;
  final int amount;

  Transaction({required this.date, required this.description, required this.amount});
}
