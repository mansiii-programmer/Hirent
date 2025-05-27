import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalletPage extends StatefulWidget {
  final String userId; // pass userId when navigating to this screen

  const WalletPage({super.key, required this.userId});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int walletBalance = 0;
  final String baseUrl = 'http://127.0.0.1:8000'; // change to your backend url

  @override
  void initState() {
    super.initState();
    fetchWalletBalance();
  }

  Future<void> fetchWalletBalance() async {
    final url = Uri.parse('$baseUrl/users/users/68225f34d92bb78dd1e2726e/wallet');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          walletBalance = data['wallet'];
        });
      } else {
        print('failed to fetch wallet: ${response.body}');
      }
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> updateWalletOnServer(int newAmount) async {
    final url = Uri.parse('$baseUrl/users/${widget.userId}/wallet');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'wallet': newAmount}),
      );
      if (response.statusCode == 200) {
        print('wallet updated');
      } else {
        print('failed to update wallet: ${response.body}');
      }
    } catch (e) {
      print('error: $e');
    }
  }

  void addMoney(int amount) {
    final newAmount = walletBalance + amount;
    setState(() {
      walletBalance = newAmount;
    });

    updateWalletOnServer(newAmount); // update backend

    showDialog(
      context: context,
      builder: (context) => Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40, right: 20),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            elevation: 8,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Money added successfully',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('₹$amount has been added to your wallet.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Future.delayed(Duration(seconds: 3), () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        leading: BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.teal.shade700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_balance_wallet_outlined, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  '₹$walletBalance',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text('Available Balance', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => addMoney(6000),
            icon: Icon(Icons.add),
            label: Text('Add Money to Wallet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 24),
          Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          actionTile('Manage Payment Methods'),
          const SizedBox(height: 6),
          actionTile('Transaction History'),
        ],
      ),
    );
  }

  Widget actionTile(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(Icons.credit_card),
        title: Text(label),
        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () {
          // implement your navigation
        },
      ),
    );
  }
}
