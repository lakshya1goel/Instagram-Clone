import 'package:flutter/material.dart';
import 'package:insta_clone/Utils/routes.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username="";
  String password="";
  int selectedIndex=0;
  String language = "English (US)";
  List<String> lang=[
    'English (US)', 'Afrikaans', 'Bahasa Indonesia', 'Bahasa Melayu', 'Dansk', 'Deutsch', 'English (UK)', 'Filipino', 'Hrvatski'
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextButton(
                    onPressed: (){
                      _bottomSheet(context);
                    },
                    child: Text(
                        language,
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  )
                ),
                SizedBox(height: 60),
                _centerWidget(),
                SizedBox(height: 60),
                _bottomWidget()
              ],
            ) ,
          ),
        ),
      ),
    );
  }

  void _bottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext icon) {
        return LanguageSelectionWidget(
          lang: lang,
          selectedIndex: lang.indexOf(language),
          onChanged: (int? index) {
            setState(() {
              language = lang[index!];
              Navigator.pop(context);
            });
          },
        );
      },
    );
  }


  Widget _centerWidget(){
    return Column(
      children: [
        Center(
          child: Image.asset("assets/images/authentication/insta_icon.jpg",
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }


  Widget _bottomWidget() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Username, email address or mobile number",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              onChanged: (value) {
                username = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            SizedBox(
              width: 500.0,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ))
                ),
                onPressed: () {

                },
                child: Text("Log In"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GestureDetector(
                  onTap: () {

                  },
                  child: Text("Forgotten Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 150.0,
            ),
            SizedBox(
              width: 500.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(width: 2.0, color: Colors.blue),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                  elevation: MaterialStateProperty.all<double>(0.0),
                ),
                onPressed: () {

                },
                child: Text("Create new account",
                  style: TextStyle(
                    color: Colors.blue,
                  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class LanguageSelectionWidget extends StatelessWidget {
  final List<String> lang;
  final int selectedIndex;
  final Function(int?)? onChanged;

  LanguageSelectionWidget({
    required this.lang,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 500.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Select your language",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: lang.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(lang[index]),
                        trailing: Radio(
                          value: index,
                          groupValue: selectedIndex,
                          onChanged: onChanged,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

