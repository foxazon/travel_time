import 'dart:convert';
import 'dart:io';
import 'api_call.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// ******************************************************
// Beginning of Weight conversion
// ******************************************************

// ignore: camel_case_types
class C1ToC2_wt extends StatefulWidget {
  final String cC1;
  final String cC2;
  const C1ToC2_wt({Key? key, required this.cC1, required this.cC2})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _C1ToC2State createState() => _C1ToC2State();
}

class _C1ToC2State extends State<C1ToC2_wt> {
  String fetchedContent = '';

  TextEditingController priceController = TextEditingController();

  Future<String> fetchUrlBodyAsString(String url) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    return response.transform(utf8.decoder).join();
  }

  void fetchContent() async {
    setState(() {
      FocusScope.of(context).unfocus();
      fetchedContent = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double pricePerC1 = double.tryParse(priceController.text) ?? 0;
    String stringC2PerC1 = '';
    String rates = Provider.of<API_Call>(context).todaysRate;
    double ratesDouble = double.parse(rates);
    // ignore: non_constant_identifier_names
    double C2PricePerC1 = pricePerC1 / (ratesDouble);
    C2PricePerC1 = C2PricePerC1 * 0.4535922921968972;
    stringC2PerC1 = C2PricePerC1.toStringAsFixed(2);
    String priceWithDollarSign = '\$$stringC2PerC1';

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
                  widget.cC1 == 'USD'
                      ? 'USD per Pound:'
                      : '${widget.cC1} per Kilo:',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width:
                      110, // Set the width of the SizedBox as per your preference
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
                Image.asset('assets/scale.jpg', width: 50, height: 50),
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
                          ? 'USD Pounds: '
                          : '${widget.cC2} Kilos',
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
            padding: const EdgeInsets.symmetric(
                horizontal:
                    50), // Adjust this padding value as per your preference
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.cC2 == 'USD'
                      ? 'USD per LB: '
                      : '${widget.cC2} per Kilo:',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 5), // Adjust this width value as per your preference
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
