import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int walletBalance = 1500;

  void addMoney(int amount) {
    setState(() {
      walletBalance += amount;
    });
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
          // wallet balance card
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

          // add money button
          ElevatedButton.icon(
            onPressed: () => addMoney(6000), // simulate adding money
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

          // quick actions
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
          // navigate to respective screen
        },
      ),
    );
  }
}
