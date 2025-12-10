import 'dart:convert';
import 'dart:io';
import 'api_call.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ******************************************************
// Beginning of cC1 to cC2 Conversion
// ******************************************************

class Cc1ToCc2 extends StatefulWidget {
  final String cC1;
  final String cC2;
  const Cc1ToCc2({Key? key, required this.cC1, required this.cC2})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Cc1ToCc2 createState() => _Cc1ToCc2();
}

class _Cc1ToCc2 extends State<Cc1ToCc2> {
  String fetchedContent = '';

  TextEditingController priceController = TextEditingController();

  Future<String> fetchUrlBodyAsString(String url) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    return response.transform(utf8.decoder).join();
  }

  void fetchContent() async {
    FocusScope.of(context).unfocus();
    setState(() {
      FocusScope.of(context).unfocus();
      fetchedContent = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double pesos = double.tryParse(priceController.text) ?? 0;
    //String stringUsdAmount = '';
    String rates = Provider.of<API_Call>(context).todaysRate;
    double ratesDouble = double.parse(rates);
    double usdAmt = pesos / ratesDouble;

    final formatter = NumberFormat("#,###"); // Add this line here
    String priceWithDollarSign =
        '\$${formatter.format(usdAmt)}'; // Use the formatter to format the usdAmt

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(
                left: 1,
                right:
                    2), // Adjust the right padding value as per your preference
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter ${widget.cC1}:',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 25),
                SizedBox(
                  width:
                      170, // Set the width of the SizedBox as per your preference
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25),
                      isDense: true,
                    ),
                    maxLength: 9,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: fetchContent,
            child: Column(
              // Use Column for stacked text appearance
              children: [
                Image.asset('assets/dollar.png', width: 50, height: 50),
                const SizedBox(height: 5),
                Column(
                  // Nested Column for stacked text
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Calculate',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('${widget.cC1} to ${widget.cC2}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
                left: 50,
                right: 2), // Adjust this padding value as per your preference
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current ${widget.cC2}: ',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    priceWithDollarSign,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
