import 'dart:convert';
import 'dart:io';
import 'api_call.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// ******************************************************
// Beginning of Volume conversion
// ******************************************************

// ignore: camel_case_types
class C1ToC2_vol extends StatefulWidget {
  final String cC1;
  final String cC2;
  const C1ToC2_vol({Key? key, required this.cC1, required this.cC2})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _C1ToC2State createState() => _C1ToC2State();
}

class _C1ToC2State extends State<C1ToC2_vol> {
  String fetchedContent = '';
  String rates = '';

  TextEditingController priceController = TextEditingController();

  Future<String> fetchUrlBodyAsString(String url) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    return response.transform(utf8.decoder).join();
  }

  void fetchContent() async {
    setState(() {
      fetchedContent = '';
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    double pricePerC1 = double.tryParse(priceController.text) ?? 0;
    String stringC1PerC2 = '';
    String rates = Provider.of<API_Call>(context).todaysRate;
    double ratesDouble = double.parse(rates);
    double pricePerC1PerC2 = pricePerC1 * 3.785;
    double c2PriceOfGas = pricePerC1PerC2 / ratesDouble;
    stringC1PerC2 = c2PriceOfGas.toStringAsFixed(2);
    String priceWithDollarSign = '\$$stringC1PerC2';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(
              left: 1,
              right: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.cC1 == 'USD'
                      ? 'USD per Gallon:'
                      : '${widget.cC1} per Liter:',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25),
                      isDense: true,
                    ),
                    maxLength: 5,
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
                Image.asset('assets/gaspump.jpg', width: 50, height: 50),
                const SizedBox(height: 5),
                Column(
                  // Nested Column for stacked text
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Calculate',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      widget.cC2 == 'USD'
                          ? 'USD Gallons'
                          : '${widget.cC2} Liters',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.cC2 == 'USD'
                      ? 'USD per Gallon: '
                      : '${widget.cC2} per Liter:',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
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
