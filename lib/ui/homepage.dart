import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wikipedia_app/bloc/bloc.dart';
import 'package:wikipedia_app/model/model.dart';
import 'package:wikipedia_app/styles/text_styles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearchEnabled = false;
  WikipediaBloc _wikipediaBloc;

  @override
  void initState() {
    _wikipediaBloc = WikipediaBloc();
    _wikipediaBloc.getSearchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 25),
          child: CustomSearchView()),
      body: Container(
          padding: EdgeInsets.only(top: 5,bottom: 5),
          decoration: BoxDecoration(
            color: Colors.black12.withOpacity(0.05),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Center(
              child: StreamBuilder<SearchResponse>(
                  stream: _wikipediaBloc.subject.stream,
                  builder: (context, AsyncSnapshot<SearchResponse> snapshot) {
                    if (snapshot.data != null) {
                      return listWidget(snapshot.data);
                    } else
                      return Center(child: CircularProgressIndicator());
                  }))),
    );
  }


  Widget CustomSearchView() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              exit(0);
            });
          },
        ),
        centerTitle: true,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.only(
            left: 15,
            right: 20,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey, width: 0.5)),
          child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                      onChanged: (value) => {
                        _wikipediaBloc.getSearchData()
                      },
                      controller: _wikipediaBloc.textEditingController,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.blueAccent,
                      cursorWidth: 1,
                      showCursor: true,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Wikipedia",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic))),
                ),
                GestureDetector(
                  onTap: (){
                    _wikipediaBloc.textEditingController.text = "";
                    _wikipediaBloc.getSearchData();
                  },
                  child: Icon(Icons.cancel,size: 20,color: Colors.grey,),
                )
              ]
          ),
        ),
      ),
    );
  }

  Widget listWidget(SearchResponse data) {
    if(data.query == null){
      if(_wikipediaBloc.textEditingController.text.isNotEmpty) {
        return Center(
          child: TextWidget("No search results found..",15),);
      } else{
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextWidget("Wikipedia Search",18),
            ],
          ),
        );
      }
    }else {
      return ListView.builder(
          itemCount: data.query.pages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _launchWikipedia(data.query.pages[index].title);
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 15, right: 15, top:5,bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(-0, 1),
                            blurRadius: 0,
                            spreadRadius: 0)
                      ]),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: (data.query.pages[index].thumbnail !=
                                  null)
                                  ? NetworkImage(
                                  data.query.pages[index].thumbnail.source)
                                  : NetworkImage(
                                  "https://www.zoomnews.in/uploads_2019/newses/wiki_1990060983_sm.jpg")),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.query.pages[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: data.query.pages[index].terms != null ? true : false,
                                child: Text(
                                  data.query.pages[index].terms !=
                                      null
                                      ? data.query.pages[index].terms
                                      .description[0]
                                      : "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          });
    }
  }

  _launchWikipedia(String titile) async {
    var  url = 'https://en.wikipedia.org/wiki/$titile';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
