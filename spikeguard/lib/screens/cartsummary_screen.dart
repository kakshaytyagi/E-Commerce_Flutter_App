import 'package:flutter/material.dart';
import 'package:spikeguard/screens/address_screen.dart';
import 'package:spikeguard/screens/cart_screen.dart';
import 'package:spikeguard/shared/globals.dart';

class CartSummaryScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartSummaryScreen({Key? key, required this.cartItems})
      : super(key: key);

  @override
  _CartSummaryScreenState createState() => _CartSummaryScreenState();
}

class _CartSummaryScreenState extends State<CartSummaryScreen> {
  Address? selectedAddress;
  String selectedPaymentOption = 'Cash on Delivery';
  String selectedPaymentApp = ''; // Hold the selected payment app

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Summary'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCartDetails(),
                  const SizedBox(height: 16),
                  _buildTotalAmount(),
                  const SizedBox(height: 16),
                  _buildAddAddressTile(context),
                  const SizedBox(height: 16),
                  _buildDeliveryModeTile(context),
                ],
              ),
            ),
            _buildProceedButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCartDetails() {
    return Card(
      elevation: 4.0,
      child: DataTable(
        columnSpacing: 10.0,
        dataRowHeight: 80.0,
        columns: const [
          DataColumn(label: Text('Product')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Price')),
          DataColumn(label: Text('Amount')),
        ],
        rows: List<DataRow>.generate(
          widget.cartItems.length,
          (index) {
            CartItem item = widget.cartItems[index];
            double amount = double.parse(item.productPrice) * item.quantity;

            return DataRow.byIndex(
              index: index,
              cells: [
                DataCell(Text(item.productName)),
                DataCell(Text(item.quantity.toString())),
                DataCell(Text(item.productPrice)),
                DataCell(Text(amount.toStringAsFixed(2))),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTotalAmount() {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Total Amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${calculateTotalAmount()}',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildAddAddressTile(BuildContext context) {
    bool isNewAddressAdded = selectedAddress != null;

    return Card(
      elevation: 4.0,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isNewAddressAdded ? 'Delivery Address' : 'Add a New Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    isNewAddressAdded ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
            if (isNewAddressAdded)
              Text(
                selectedAddress!.getFormattedAddress(),
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
        onTap: () async {
          Address? newAddress = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAddressScreen(),
            ),
          );

          if (newAddress != null) {
            setState(() {
              selectedAddress = newAddress;
            });
          }
        },
      ),
    );
  }

  Widget _buildDeliveryModeTile(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Option',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Radio(
                  value: 'Cash on Delivery',
                  groupValue: selectedPaymentOption,
                  onChanged: (value) {
                    _updatePaymentOption(value!);
                    selectedPaymentApp = ''; // Clear the selected payment app
                  },
                ),
                const Text('Cash on Delivery / Pay on Delivery'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 'Other UPI Apps',
                  groupValue: selectedPaymentOption,
                  onChanged: (value) {
                    _updatePaymentOption(value!);
                    _showOtherUPIAppsDialog(context);
                  },
                ),
                const Text('Other UPI Apps'),
              ],
            ),
            if (selectedPaymentOption == 'Other UPI Apps' &&
                selectedPaymentApp.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Selected Payment App: $selectedPaymentApp',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }


  void _updatePaymentOption(String option) {
    setState(() {
      selectedPaymentOption = option;
    });
  }

  void _showOtherUPIAppsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Other UPI App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildUPIAppButton(
                    'Google Pay',
                    'payment/googlepay.png',
                    () {
                      _setSelectedPaymentApp('Google Pay');
                    },
                  ),
                  _buildUPIAppButton(
                    'PhonePe',
                    'payment/phonepe.jpg',
                    () {
                      _setSelectedPaymentApp('PhonePe');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildUPIAppButton(
                    'BHIM',
                    'payment/BHIM.png',
                    () {
                      _setSelectedPaymentApp('BHIM');
                    },
                  ),
                  _buildUPIAppButton(
                    'Paytm',
                    'payment/paytm.png',
                    () {
                      _setSelectedPaymentApp('Paytm');
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUPIAppButton(
      String appName, String appImage, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            'assets/$appImage',
            width: 64,
            height: 64,
          ),
          const SizedBox(height: 8),
          Text(
            appName,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

   void _setSelectedPaymentApp(String appName) {
    setState(() {
      selectedPaymentApp = appName;
      Navigator.pop(context); // Close the bottom sheet
    });
  }

  String calculateTotalAmount() {
    double total = 0;
    for (var item in widget.cartItems) {
      total += double.parse(item.productPrice) * item.quantity;
    }
    return total.toStringAsFixed(2);
  }

  Widget _buildProceedButton() {
    bool isAddressSelected = selectedAddress != null;
    bool isPaymentOptionSelected =
        selectedPaymentOption.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: isAddressSelected && isPaymentOptionSelected
            ? () {
              if (selectedPaymentOption == 'Cash on Delivery') {
                  _proceedWithCashOnDelivery();
                } else {
                  _proceedWithOtherPayment();
                }
            }
            : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          elevation: 4.0,
        ),
        child: const Text(
          'Proceed to Buy',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}



void _proceedWithCashOnDelivery() {
  // Implement logic for Cash on Delivery
  // For example, show a confirmation dialog or navigate to a success screen
}

void _proceedWithOtherPayment() {
  // Implement logic for other payment options
  // For example, handle the selected payment app and proceed accordingly
  // if (selectedPaymentOption == 'Other UPI Apps' &&
  //     selectedPaymentApp.isNotEmpty) {
  //   // Implement logic for other UPI apps
  //   // You can show a confirmation dialog or navigate to a payment screen
  // }
}