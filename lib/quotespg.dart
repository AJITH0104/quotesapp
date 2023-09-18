import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class Quotespg extends StatefulWidget {
  final String name;
  const Quotespg(this.name);

  @override
  State<Quotespg> createState() => _QuotespgState();
}

class _QuotespgState extends State<Quotespg> {
  
  List quotes=[];
  List authorw=[];
  bool datather=false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  
  getdata() async{
    String url="https://quotes.toscrape.com/tag/${widget.name}/";
    http.Response response= await http.get(Uri.parse(url));
    dom.Document docs=parser.parse(response.body);
    final quotesclass=docs.getElementsByClassName("quote");
    quotes=quotesclass.map((e) => e.getElementsByClassName("text")[0].innerHtml).toList();
    print(quotes);
    authorw=quotesclass.map((e) => e.getElementsByClassName("author")[0].innerHtml).toList();
    print(authorw);
  setState(() {
    datather=true;
  });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6C9E1),
      body: datather==false?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 40.0),
              child: Center(
                child: Container(
                  child: Text("${widget.name} Quotes",style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.w600,fontSize: 35.0,
                  ),),
                ),
              ),
            ),
           ListView.builder(
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
                itemCount: quotes.length,
               itemBuilder: (context,index){
                  return Container(
                    padding: EdgeInsets.all(10.0),
                     child: Card(
                        elevation: 10.0,
                        color: Color(0xFFA084DC),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 20.0,left: 20.0,bottom: 20.0,right: 20.0),
                              child: Text(quotes[index],style: GoogleFonts.barlow(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black
                              ),),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom: 10.0),
                              child: Text(authorw[index],style: GoogleFonts.barlow(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black
                              ) ,),
                            ),
                          ],
                        ),
                      ),

                  );
           }),
          ],
        ),
      ),
    );
  }
}

