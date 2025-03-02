import 'dart:async';

import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techtimes/models/category_model.dart';
import 'package:techtimes/models/slider_model.dart';
import 'package:techtimes/services/data.dart';
import 'package:techtimes/services/slider_data.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];

  int activeIndex = 0;
  @override
  void initState() {
    categories = getCategories();
    getSlider();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tech"),
            Text(
              "Times",
              style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
            ),
          ],
        ) ,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: EdgeInsets.only(left: 10.0),
              height: 70,
              child: ListView.builder(
              shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:categories.length ,
                itemBuilder:(context,index){
              return CategoryTile(
                image: categories[index].image,
                categoryName: categories[index].categoryName,
              );
            } ),
            ),
          SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Breaking News!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18.0),),
                Text("View All",style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold,fontSize: 16.0),),
        
              ],
            ),
          ),
              SizedBox(height: 20.0,),
          CarouselSlider.builder(itemCount: sliders.length, itemBuilder: (context,index, realIndex){
        String? res = sliders[index].image;
        String? res1 = sliders[index].name;
          return buildImage(res!, index, res1!);
          }, options: CarouselOptions(
              height: 300,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index , reason){
                setState(() {
                  activeIndex = index;
                });
              }
          )),
              SizedBox(height: 30.0,),
             Center( child: buildingIndicator()),
        
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trending News!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18.0),),
                    Text("View All",style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold,fontSize: 16.0),),
        
                  ],
                ),
              ),
        
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal:10.0),
        
        
               child: Material(
                 elevation: 3.0,
                 borderRadius: BorderRadius.circular(10),
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                   child: Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                        Container(
                          child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                         child: Image.asset("images/startup.jpeg", height: 150,width: 150,fit: BoxFit.cover,
                          )
                          )
                        ),
        
                            SizedBox(width: 8.0,),
        
                            Column(
                              children: [
                                Container(
                                width: MediaQuery.of(context).size.width/1.9,
                                child: Text("TechTimes hiring new software engineer in 2024",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 17.0),),
                                ),
                                SizedBox(width: 7.0,),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.8,
                                  child: Text("more than 40,000 new hiring vacancy",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 15.0),),
                                ),
                              ],
                            ),
        
        
                          ],
                     ),
                 ),
        
               ),
        
             ),
        
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal:10.0),
        
        
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("images/startup.jpeg", height: 150,width: 150,fit: BoxFit.cover,
                                )
                            )
                        ),
        
                        SizedBox(width: 8.0,),
        
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/1.9,
                              child: Text("TechTimes hiring new software engineer in 2024",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 17.0),),
                            ),
                            SizedBox(width: 7.0,),
                            Container(
                              width: MediaQuery.of(context).size.width/1.8,
                              child: Text("more than 40,000 new hiring vacancy",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 15.0),),
                            ),
                          ],
                        ),
        
        
                      ],
                    ),
                  ),
        
                ),
        
              ),
          ],
          ),
        ),
      ),
    );
  }
  Widget buildImage(String image, int index, String name) => Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    child:Stack(
    children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(10),

    child: Image.asset(
    image,
    height: 250,
    fit: BoxFit.cover, width: MediaQuery.of(context).size.width,
  ),
  ),
  Container(
    height: 250,
    padding: EdgeInsets.only(left: 10.0),
    margin: EdgeInsets.only(top: 170.0),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(color: Colors.black26,borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)) ),
    child: Text(name, style: TextStyle(color: Colors.white,fontSize: 19.0,fontWeight: FontWeight.bold),),
  )


]));
Widget buildingIndicator() => AnimatedSmoothIndicator(activeIndex: activeIndex, count: sliders.length,
effect: SlideEffect(dotWidth: 15,dotHeight: 15,activeDotColor: Colors.blue),);
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
 CategoryTile({this.categoryName,this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right:16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
        child: Image.asset(
          image,
          width: 120,
          height: 75,fit: BoxFit.cover,
      ),
          ),
          Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(6),
              color: Colors.black26,
            ),

            child: Center(
                child: Text(
                  categoryName,
                  style: TextStyle(color: Colors.white60,fontSize:14,fontWeight: FontWeight.w300),)),
          )
      ],
    ),
    );
  }


}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Screenshot Example',
      home: ScreenshotExample(),
    );
  }
}

class ScreenshotExample extends StatefulWidget {
  @override
  _ScreenshotExampleState createState() => _ScreenshotExampleState();
}

class _ScreenshotExampleState extends State<ScreenshotExample> {
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _takeScreenshot() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/screenshot.png';

    screenshotController.capture().then((File? image) async {
      if (image != null) {
        final imagePath = await image.copy(path);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Screenshot saved to $path'),
          ),
        );
      }
    } as FutureOr Function(Uint8List? value)).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Screenshot Example'),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Center(
          child: Text('This is the content to capture!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takeScreenshot,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}