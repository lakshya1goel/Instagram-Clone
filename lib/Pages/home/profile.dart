import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              )
            ),
            child: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              title: Text("43.paras.57",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
              ),
              actions: [
                IconButton(
                    onPressed: (){

                    },
                    icon: Image.asset('assets/Icons/upload.png',
                      width: 25.0,
                      fit: BoxFit.scaleDown,
                    ),
                    ),
                IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.menu,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Card(
        color: Colors.black,
        elevation: 0.0,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 15.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage('https://instagram.fagr1-3.fna.fbcdn.net/v/t51.2885-19/340046144_1573819893114923_1993567904210653388_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fagr1-3.fna.fbcdn.net&_nc_cat=111&_nc_ohc=OimvTRSrIeUAX_H8GIg&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfBzB8cbLWkBcrgg6UcZON6FVX_LGJL_kw3TvtbsRB3Q-g&oe=64BD7F89&_nc_sid=ee9879'),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text("PARAS UPADHAYAY",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("11",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text("Posts",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                    ],
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    children: [
                        Text("4,710",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),),
                      Text("Followers",
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                      ],
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    children: [
                      Text("150",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),),
                      Text("Following",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0,),
            Row(
              children: [
                SizedBox(width: 10.0,),
                SizedBox(
                  width: 162.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey),
                    ),
                    onPressed: (){

                      },
                      child: Text("Edit profile",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                  ),
                ),
                SizedBox(width: 8.0,),
                SizedBox(
                  width: 162.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey),
                    ),
                    onPressed: (){

                    },
                    child: Text("Share profile",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
