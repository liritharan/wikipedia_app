import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wikipedia_app/repo/repository.dart';
import 'package:wikipedia_app/model/model.dart';


class WikipediaBloc {
  TextEditingController textEditingController = TextEditingController(text: "");
  final WikipediaRepository _wikipediaRepository = WikipediaRepository();
  final BehaviorSubject<SearchResponse> _subject = BehaviorSubject<SearchResponse>();
  int pageIndex = -1;

  getSearchData() async {
    pageIndex++;
    SearchResponse response = await _wikipediaRepository.getSearchData(textEditingController.text.toString(),20);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
    textEditingController.dispose();
  }

  BehaviorSubject<SearchResponse> get subject => _subject;
}
