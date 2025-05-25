import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  List<Transaction> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000//users/users/{userId}/payment-methods'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        transactions = data.map((json) => Transaction.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      // handle error
      setState(() {
        isLoading = false;
      });
      print('Failed to load transactions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : transactions.isEmpty
                ? Center(child: Text('No transactions available.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction History',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                        border: TableBorder(
                            horizontalInside:
                                BorderSide(color: Colors.grey.shade300)),
                        children: [
                          TableRow(
                            decoration:
                                BoxDecoration(color: Colors.grey.shade100),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Description',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Amount',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
                                    child: Text(tx.description,
                                        style: TextStyle(color: Colors.teal)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${tx.amount >= 0 ? '+' : '-'} ₹${tx.amount.abs()}',
                                      style: TextStyle(
                                        color: tx.amount >= 0
                                            ? Colors.green
                                            : Colors.red,
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

  Transaction(
      {required this.date, required this.description, required this.amount});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: json['date'],
      description: json['description'],
      amount: json['amount'],
    );
  }
}
