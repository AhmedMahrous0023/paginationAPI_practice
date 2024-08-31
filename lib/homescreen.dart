import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  fetchdata()async{
     try{
                var response =await get(Uri.parse('https://techcrunch.com/wp-json/wp/v2/posts?embed#per_page=2&page=3'));
                if (response.statusCode==200){
                  setState(() {
                    myData=myData+jsonDecode(response.body);
                  });
                }
                print(myData);
               }catch(e){
                print('failed****************');
               }
  }



  
 List<dynamic> myData=[] ;
 final scrollcontroller=ScrollController();
 _scrollListener(){
 if(scrollcontroller.position.pixels==scrollcontroller.position.maxScrollExtent){
  fetchdata();
 }else{
  print('noooooooooooooooooooo');
 }
 }

 @override
  void initState() {
    scrollcontroller.addListener(_scrollListener);
fetchdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Practice'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(child: MaterialButton(onPressed: ()async{
              //  try{
              //   var response =await get(Uri.parse('https://techcrunch.com/wp-json/wp/v2/posts?embed#per_page=2&page=3'));
              //   if (response.statusCode==200){
              //     setState(() {
              //       myData=jsonDecode(response.body);
              //     });
              //   }
              //   print(myData);
              //  }catch(e){
              //   print('failed****************');
              //  }
               
               
              // },child: Text('get Data'),color: Colors.blue,)),
            Expanded(
              child: ListView.builder(
                controller: scrollcontroller,
                itemCount: myData.length,
                itemBuilder: ((context, index) {
                  return  ListTile(
                    leading: CircleAvatar(child: Center(child: Text('${index+1}'))),
                    title: Text('${myData[index]['title']['rendered']}',maxLines: 1,),
                    subtitle: Text('${myData[index]['yoast_head_json']['description']}',maxLines: 2,),
                  );
                })),
            )
            ],
          ),
        ),
      ),
    );
  }
}