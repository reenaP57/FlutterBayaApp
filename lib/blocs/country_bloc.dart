import 'dart:async';
import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/repository/country_repository.dart';
import 'package:demo_app/models/country_model.dart';

class CountryBloc {
  CountryRepository countryRepository;
  StreamController countryCotroller;

  StreamSink<APIResponse<CountryListModel>> get countryListSink =>
      countryCotroller.sink;

  Stream<APIResponse<CountryListModel>> get countryListStream =>
      countryCotroller.stream;

  CountryBloc() {
    countryRepository = CountryRepository();
    countryCotroller = StreamController<APIResponse<CountryListModel>>();
    fetchCountryList();
  }

  fetchCountryList() async {
    countryListSink.add(APIResponse.loading('Fetching message'));
    try {
      CountryListModel country = await countryRepository.getCountryList();
      countryListSink.add(APIResponse.done(country));
    } catch (error) {
      countryListSink.add(APIResponse.error(error.toString()));
    }
  }

  disponse() {
    countryCotroller.close();
  }
}
