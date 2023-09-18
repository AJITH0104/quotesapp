import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quotespg.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;


class Homepg extends StatefulWidget {
  const Homepg({super.key});

  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {
  List<String> cate=["love","inspirational","life","humor"];

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
    String url="https://quotes.toscrape.com/";
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
    return  Scaffold(
      backgroundColor: Color(0xFFE6C9E1),//E6C9E1
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 40.0),
              child: Text('Quotes app',style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w600,fontSize: 35.0,
              ),),
            ),
            
            
            Padding(
              padding:  EdgeInsets.all(10.0),
              child: GridView.count(crossAxisCount: 2,
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: cate.map((category){
                  return InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Quotespg(category))),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFB2A4FF),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Text(category.toUpperCase(),style: GoogleFonts.playfairDisplay(
                          color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.w700,
                        ),),
                      ),
                    ),
                  );
                }).toList(),
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
