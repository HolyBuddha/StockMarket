
import 'dart:convert';

CompanyInfo companyModelFromJson(String str) => CompanyInfo.fromJson(json.decode(str));

class CompanyInfo {

    String? symbol;
    String? assetType;
    String? name;
    String? description;
    String? cik;
    String? exchange;
    String? currency;
    String? country;
    String? sector;
    String? industry;
    String? address;
    String? fiscalYearEnd;
    double? marketCapitalization;
    String? ebitda;
    

    CompanyInfo({
        this.symbol,
        this.assetType,
        this.name,
        this.description,
        this.cik,
        this.exchange,
        this.currency,
        this.country,
        this.sector,
        this.industry,
        this.address,
        this.fiscalYearEnd,
        this.marketCapitalization,
        this.ebitda,
    });

    factory CompanyInfo.fromJson(Map<String, dynamic> json) => CompanyInfo(
        symbol: json["Symbol"],
        assetType: json["AssetType"],
        name: json["Name"],
        description: json["Description"],
        cik: json["CIK"],
        exchange: json["Exchange"],
        currency: json["Currency"],
        country: json["Country"],
        sector: json["Sector"],
        industry: json["Industry"],
        address: json["Address"],
        fiscalYearEnd: json["FiscalYearEnd"],
        marketCapitalization: double.parse(json["MarketCapitalization"] ?? "0"),
        ebitda: json["EBITDA"],
    );
}
