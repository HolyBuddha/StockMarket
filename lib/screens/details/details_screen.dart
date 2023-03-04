// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tn_group_test/screens/home/home_repository/home_models.dart';

class DetailsScreen extends StatelessWidget {
  final CompanyInfo _companyInfo;

  const DetailsScreen({
    Key? key,
    required CompanyInfo companyInfo,
  }) : _companyInfo = companyInfo, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_companyInfo.name ?? 'No data'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Image.asset('assets/${_companyInfo.symbol}.png',
                width: 100, height: 100),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    _companyInfo.description ?? 'No data',
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text('Symbol: ${_companyInfo.symbol ?? 'No data'}'),
            Text('Country: ${_companyInfo.country ?? 'No data'}'),
            Text('Market Capitalization: ${(_companyInfo.marketCapitalization?.toStringAsFixed(0))  ?? 'No data'}'),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
