import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/models/add_staff_page.dart';
import 'package:flutter_login/models/list_staff_page.dart';
import '../components/colors.dart';
import '../homepage.dart';
import '../widgets/tabbutton_widget.dart';
import 'package:page_transition/page_transition.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // bool showSpinner = false;
  late String password;
  late String email;

  // final _firestore = Firestore.
  final _auth = FirebaseAuth.instance;
  bool _obscureText = true;
  bool _validate = false;
  final _text1 = TextEditingController();
  final _text2 = TextEditingController();


  @override
  void dispose() {
    _text1.dispose();
    _text2.dispose();
    // _text3.dispose();
    super.dispose();
  }

  void _toggle(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.white30,
            ],
          )
      ),
      constraints: const BoxConstraints.expand(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Login with email"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: ListView(

            children: <Widget>[
              SizedBox(
                height: 70.0,
              ),
              Hero(
                tag: 'logo',
                child: Container(
                  height: 100.0,
                  child: Image.asset('asset/images/flutter-logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                child: emailInput(),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                child: passInput(),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Hero(
                  tag: "button2",
                  child: TabButton(
                    btnColor: PalletteColors.primaryRed,
                    btnTxtColor: Colors.white,
                    btnText: "Log In",
                    btnFunction: () async {
                      _text1.text.isEmpty ? _validate = false : _validate = true;
                      _text2.text.isEmpty ? _validate = false : _validate = true;
                      setState((){
                        // showSpinner = true;
                      });

                      try{
                        final loggedInUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(loggedInUser != null){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => const HomePage()));
                          setState(() {
                            // showSpinner = false;
                          });

                        }
                      }catch(e){
                        print(e);
                      }

                    },
                  ),
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ?",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, PageTransition(
                          type: PageTransitionType.fade, child: AddStaffPage()));
                    },
                    child: Text(
                      " Sign Up",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: PalletteColors.primaryRed,
                      ),
                    ),
                  ),

                ],
              ),




            ],
          ),
        ),
      ),
    );
  }
  Widget emailInput() {
    return Theme(
      child: TextField(
        onChanged: (value){
          email = value;
        },
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 16.0,
        ),

        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          hintText: 'Masukkan alamat email',
          labelText: "Email ID",
          errorText: _validate ? 'Please enter your email' : null,
          prefixIcon: Icon(Icons.mail_outline),
          labelStyle: TextStyle(fontSize: 16,color: Colors.redAccent),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),

          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),

          errorStyle: TextStyle(fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                color: Colors.red,
              )
          ),
        )
        ,


        textInputAction: TextInputAction.next,
      ),
      data: Theme.of(context)
          .copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: PalletteColors.primaryRed),),
    );
  }

  Widget passInput() {

    return Theme(
      data: Theme.of(context)
          .copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: PalletteColors.primaryRed),),
      child: TextField(
        onChanged: (value){
          password = value;
        },
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          hintText: 'Masukkan password',
          prefixIcon: Icon(Icons.vpn_key,),
          labelText: "Password",
          errorText: _validate ? 'Password Can\'t Be Empty' : null,
          labelStyle: TextStyle(fontSize: 16, color: Colors.redAccent),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                color: Colors.red,
              )
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),

          errorStyle: TextStyle(fontSize: 14),
          suffixIcon: IconButton(
            icon: Icon(

              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: PalletteColors.primaryGrey,
            ),
            onPressed: _toggle,
          ),
        ),
        textInputAction: TextInputAction.done,
        obscureText: _obscureText,
      ),
    );
  }


}

