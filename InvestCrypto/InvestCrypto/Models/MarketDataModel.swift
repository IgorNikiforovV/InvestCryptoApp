//
//  MarketDataModel.swift
//  InvestCrypto
//
//  Created by Игорь Никифоров on 13.02.2025.
//

import Foundation

// MARK: - JSON data:
/*
 import Foundation

 URL:
 let url = URL(string: "https://api.coingecko.com/api/v3/global")!
 var request = URLRequest(url: url)
 request.httpMethod = "GET"
 request.timeoutInterval = 10
 request.allHTTPHeaderFields = [
   "accept": "application/json",
   "x-cg-demo-api-key": "CG-RspF9kDAPWeqfA2hEMgQcDYF"
 ]

 let (data, _) = try await URLSession.shared.data(for: request)
 print(String(decoding: data, as: UTF8.self))

 JSON Response:

 {
   "data": {
     "active_cryptocurrencies": 17138,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1243,
     "total_market_cap": {
       "btc": 34431949.91651222,
       "eth": 1226604018.3648705,
       "ltc": 27021257927.71037,
       "bch": 9849856403.330011,
       "bnb": 4714247385.077261,
       "eos": 5115452699817.241,
       "xrp": 1349540494874.1785,
       "xlm": 10125410330357.365,
       "link": 175656636004.7871,
       "dot": 647414411691.6393,
       "yfi": 554615443.5657989,
       "usd": 3327543812063.105,
       "aed": 12222134972584.025,
       "ars": 3515201643607546.5,
       "aud": 5283663734791.086,
       "bdt": 403325073456928.56,
       "bhd": 1254161245398.0205,
       "bmd": 3327543812063.105,
       "brl": 19184621094068.625,
       "cad": 4745110751440.106,
       "chf": 3032107834709.0825,
       "clp": 3182795656238360,
       "cny": 24252803074221.938,
       "czk": 79884340968655.14,
       "dkk": 23786610858608.09,
       "eur": 3189018163166.918,
       "gbp": 2663698821556.5156,
       "gel": 9383673550017.955,
       "hkd": 25910043011750.414,
       "huf": 1279883871159644,
       "idr": 54447148793994250,
       "ils": 11955864916742.736,
       "inr": 288983121205074.7,
       "jpy": 513670442610322.3,
       "krw": 4818582273266961,
       "kwd": 1027815060213.8639,
       "lkr": 986277873197521.5,
       "mmk": 6981186917708392,
       "mxn": 68263469870104.25,
       "myr": 14830862770365.26,
       "ngn": 5004026935456736,
       "nok": 37324393431149.41,
       "nzd": 5878169367341.901,
       "php": 193616454266072.4,
       "pkr": 926828005399096.2,
       "pln": 13258954366353.332,
       "rub": 312784772561713.3,
       "sar": 12480222598191.451,
       "sek": 35994580477184.16,
       "sgd": 4487445723896.813,
       "thb": 112625032816056.23,
       "try": 120193544526769,
       "twd": 109060251767912.08,
       "uah": 138869177864256.81,
       "vef": 333186961901.8787,
       "vnd": 84681101053208050,
       "zar": 61447688500205.86,
       "xdr": 2541681117511.9736,
       "xag": 102812718382.34355,
       "xau": 1139317725.8122864,
       "bits": 34431949916512.223,
       "sats": 3443194991651222
     },
     "total_volume": {
       "btc": 1586416.9391689245,
       "eth": 56514527.84710054,
       "ltc": 1244976871.7168987,
       "bch": 453822077.5910985,
       "bnb": 217204135.26545158,
       "eos": 235689260532.2862,
       "xrp": 62178700490.5029,
       "xlm": 466517943452.62134,
       "link": 8093200167.609082,
       "dot": 29828958042.168793,
       "yfi": 25553340.328702316,
       "usd": 153313183891.2238,
       "aed": 563122390696.1428,
       "ars": 161959326890724.5,
       "aud": 243439412233.96695,
       "bdt": 18582790985554.35,
       "bhd": 57784198948.15392,
       "bmd": 153313183891.2238,
       "brl": 883911830406.4617,
       "cad": 218626133360.72397,
       "chf": 139701272859.4415,
       "clp": 146644060391955.56,
       "cny": 1117423140791.1846,
       "czk": 3680589452363.4253,
       "dkk": 1095943810414.8403,
       "eur": 146930756045.83215,
       "gbp": 122727203704.92465,
       "gel": 432343178573.2511,
       "hkd": 1193778778956.818,
       "huf": 58969342668654.43,
       "idr": 2508596792969336,
       "ils": 550854269721.1671,
       "inr": 13314602272750.846,
       "jpy": 23666841212400.29,
       "krw": 222011258718284.53,
       "kwd": 47355529553.50509,
       "lkr": 45441746069039.92,
       "mmk": 321651059803787.44,
       "mxn": 3145169680804.14,
       "myr": 683316860603.1844,
       "ngn": 230555432199300.03,
       "nok": 1719683321071.0776,
       "nzd": 270830652294.34067,
       "php": 8920680457955.195,
       "pkr": 42702654105457.97,
       "pln": 610892785725.2574,
       "rub": 14411239058756.875,
       "sar": 575013514551.9299,
       "sek": 1658413546887.158,
       "sgd": 206754480279.291,
       "thb": 5189083402684.793,
       "try": 5537794852698.116,
       "twd": 5024839755348.044,
       "uah": 6398255591870.208,
       "vef": 15351249103.028238,
       "vnd": 3901595276016032.5,
       "zar": 2831139512745.2163,
       "xdr": 117105362564.81737,
       "xag": 4736991033.015409,
       "xau": 52492901.03251611,
       "bits": 1586416939168.9246,
       "sats": 158641693916892.44
     },
     "market_cap_percentage": {
       "btc": 57.572881182993044,
       "eth": 9.824725082218505,
       "xrp": 4.280284225288452,
       "usdt": 4.260895601563948,
       "bnb": 3.0946676774695145,
       "sol": 2.8624182606231448,
       "usdc": 1.6830493136612592,
       "doge": 1.1608644784418323,
       "ada": 0.8368075932585477,
       "steth": 0.765055606964252
     },
     "market_cap_change_percentage_24h_usd": 0.7590962541321504,
     "updated_at": 1739424011
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }

    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formettedWithAbbreviations()
        }
        return ""
    }

    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formettedWithAbbreviations()
        }
        return ""
    }

    var btcDomincnce: String {
        if let item = marketCapPercentage.first(where: { $0.key == "usd"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}

