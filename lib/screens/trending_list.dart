import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  // Title List Here
  var titleList = [
    "Looper",
    "Gamer",
    "GIJOE",
    "Daughter of the Wolf",
    "BloodShot",
    "Swiss Family Robinson",
    "Dong Yi"
  ];

  // Description List Here
  var descList = [
    "#TRENDING 1",
    "#TRENDING 2",
    "#TRENDING 3",
    "#TRENDING 4",
    "#TRENDING 5",
    "#TRENDING 6",
    "#TRENDING 7"
  ];

  var descList3 = [
    "on Saturdays at 7 pm",
    "on Sundays at 8 pm",
    "on Tuesday at 9 pm",
    "on Thursday at 8 pm",
    "on Weekend at 6 pm",
    "on Weekdays at 4 pm",
    "on Weekdays at 6 pm"
  ];
  var descList2 = [
    "From Channel HBO",
    "From Channel Netflix",
    "From Channel HBO",
    "From Channel ITN",
    "From Channel HBO",
    "From Channel &flix",
    "From Channel TV1"
  ];


  // Image Name List Here
  var imgList = [
    "assets/image1.jpg",
    "assets/image2.jpg",
    "assets/image3.jpg",
    "assets/image4.jpg",
    "assets/image5.jpg",
    "assets/image6.jpeg",
    "assets/image7.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get Device Width
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset("assets/grd.jpg", fit: BoxFit.cover),
        title: Text(
          "Trending Programmes",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.grey[900], letterSpacing: .5, fontSize: 16),
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), color: Colors.white),
          IconButton(icon: Icon(Icons.more_vert), color: Colors.white)
        ],
      ),
      // Main List View With Builder
      body: ListView.builder(
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // This Will Call When User Click On ListView Item
              showDialogFunc(context, imgList[index], titleList[index], descList[index], descList3[index]);
            },
            child: Container(
              width: 120,
              height: 120,
              // Card Which Holds Layout Of ListView Item
            child: Card(
              elevation: 5,
              color: Colors.white54,
              child: Container(
                child: Row(
                children: <Widget>[
                  Container(

                    width: 150,
                    height: 120,
                    child: Image.asset(imgList[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          titleList[index],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.indigo[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: width,
                          child: Text(
                            descList[index],
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: width,
                          child: Text(
                            descList2[index],
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),),
            ),
          );
        },
      ),
    );
  }
}

// This is a block of Model Dialog
showDialogFunc(context, img, title, desc, desc3) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage("assets/grd.jpg"), fit: BoxFit.cover),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    img,
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      desc,
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      desc3,
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}