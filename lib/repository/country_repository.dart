import 'package:demo_app/networking/api_request_helper.dart';
import 'package:demo_app/models/country_model.dart';

class CountryRepository {
  static CountryRepository countryRepository;

  APIRequestHelper helper = APIRequestHelper();

  CountryRepository.instance();

  CountryListModel countryList;

  factory CountryRepository() {
    if (countryRepository == null) {
      countryRepository = CountryRepository.instance();
    }
    return countryRepository;
  }

  getCountryList() async {
    final response = await helper.get(APITag.countryList);
    countryList = CountryListModel.fromJson(response);
    print('=============${countryList.countryList.length}');
  }
// Future<CountryListModel> getCountryList() async {
//   final response = await helper.get(APITag.countryList);
//   countryList = CountryListModel.fromJson(response);
//   // return CountryListModel.fromJson(response);
// }
}
