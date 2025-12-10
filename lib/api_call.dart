import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

// ignore: camel_case_types
class API_Call extends ChangeNotifier {
  String todaysRate = ' ';
  String rates = ''; // Store the fetched rates here
  String error = ''; // Store the error message here
  String cC1Value = '';
  String cC2Value = '';
  String apiResponse = ''; // Store the API response content here

  API_Call({
    required this.todaysRate,
    required this.cC1Value,
    required this.cC2Value,
  }) {
    fetchContent(); // Fetch rates when the app starts
  }

  Future<String> fetchUrlBodyAsString(String url) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    return response.transform(utf8.decoder).join();
  }

  void fetchContent() async {
    String url =
        'https://traveltimeconverter.com/sql_url.php?cC1_cC2_cntry_cds=$cC2Value$cC1Value';

    try {
      var content = await fetchUrlBodyAsString(url);
      apiResponse = content; // Update the API response content

      // If the fetchedContent is not empty and contains the expected data structure
      if (content.isNotEmpty) {
        var data = json.decode(content);
        if (data['Rates'] != null && data['Rates'].isNotEmpty) {
          var rateInfo = data['Rates'][0];
          rates = rateInfo['todays_conv_rate'].toString();
          todaysRate = rates; // Store the rates value
        }
      }

      // Reset the error message in case the fetch succeeds after a previous failure
      error = '';
      notifyListeners(); // Notify listeners (widgets) that the state has changed
    } catch (error) {
      // If an error occurs during the fetch, set the error message
      this.error =
          'Error fetching data. Please check your internet connection.';
      notifyListeners(); // Notify listeners (widgets) that the state has changed
    }
  }

  String get currentRate => rates;
}
