class CryptoCurrency {
  String? id;
  String? name;
  String? symbol;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? high24;
  double? low24;
  double? priceChange24;
  double? priceChangePercent24;
  double? circulatingSupply;
  double? ath;
  double? atl;
  bool isFavorite = false;

  CryptoCurrency(
      {required this.id,
      required this.name,
      required this.symbol,
      required this.image,
      required this.currentPrice,
      required this.marketCap,
      required this.marketCapRank,
      required this.high24,
      required this.low24,
      required this.priceChange24,
      required this.priceChangePercent24,
      required this.circulatingSupply,
      required this.ath,
      required this.atl});

  factory CryptoCurrency.fromJSON(Map<String, dynamic> map) {
    return CryptoCurrency(
        id: map["id"],
        name: map["name"],
        symbol: map["symbol"],
        image: map["image"],
        currentPrice: double.parse(map["current_price"].toString()),
        marketCap: double.parse(map["market_cap"].toString()),
        marketCapRank: map["market_cap_rank"],
        high24: double.parse(map["high_24h"].toString()),
        low24: double.parse(map["low_24h"].toString()),
        priceChange24: double.parse(map["price_change_24h"].toString()),
        priceChangePercent24:
            double.parse(map["price_change_percentage_24h"].toString()),
        circulatingSupply: double.parse(map["circulating_supply"].toString()),
        ath: double.parse(map["ath"].toString()),
        atl: double.parse(map["atl"].toString()));
  }
}
