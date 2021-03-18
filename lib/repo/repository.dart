import 'package:dio/dio.dart';
import 'package:wikipedia_app/api/rest_api.dart';
import 'package:wikipedia_app/model/model.dart';



class WikipediaRepository {
  Future<SearchResponse> getSearchData(String searchKey,int pagelimit) async {

    var url = 'action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=$searchKey&gpslimit=$pagelimit';

    try {
      Response response = await RestApiServices.getDio().get(url);

      if(response.data != null) {
        print("Response is ${response.data}");
        return searchResponseFromJson(response.data);

      }else {
        print("Response Data is null");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

}