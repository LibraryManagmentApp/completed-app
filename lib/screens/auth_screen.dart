import 'package:flutter/material.dart';
import '../models/constant.dart';
import 'package:flutter/services.dart';
import '../provider/auth.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';

class AuthScreen extends StatelessWidget {
  static const routname='/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          /*Container(
            width: double.infinity,
            height:295,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(6000)),
              color: firstColor.withOpacity(0.3),
            ),
            ///color: Colors.indigo.withOpacity(0.5),
            ///transform:Matrix4.translationValues(0,-500,0),
          ),*/
          /*Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  secondaryColor.withOpacity(0.1),
                  secondaryColor.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),*/
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Image.asset("assets/images/R.png",height:100,width:150,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:const [
                      Text("IQRA  ",
                        style: TextStyle(fontSize:40,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico",
                          color:firstColor,

                        ),),
                      Text("Library",
                        style: TextStyle(fontSize:40,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico",
                          color:secondaryColor,
                        ),)
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child:  AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget{
  @override
  _AuthcardState createState()=> _AuthcardState();
}

enum AuthMode{
  Login,SignUp
}

class _AuthcardState extends State <AuthCard> with SingleTickerProviderStateMixin{

  final GlobalKey<FormState> _formkey = GlobalKey();
  AuthMode _authmode= AuthMode.Login;
  Map<String,String> _authData={
    'email':'',
    'password':'',
  };
  var _isLoading =false;
  final _passwordController= TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slidAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState(){
    super.initState();

    _controller= AnimationController(vsync: this,duration: Duration(milliseconds: 300),);
    _slidAnimation= Tween <Offset>(
      begin:Offset(0,-0.15),
      end: Offset(0,0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _opacityAnimation=Tween <double>(
      begin:0.0,
      end:1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  Future<void> _submit() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formkey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authmode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).logIn(
            _authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = "This email adress is already in use";
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = "This is not a valid email adress";
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = "This password is too weak";
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = "Could not find a user with that email";
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = "Invalid password";
      }
      _showErrorDialog(errorMessage);
    }
    catch (error) {
      const errorMessage =
          'Could not authenticate you. please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An Error Occurred!!',style:TextStyle(color: secondaryColor),),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Okay!!',style:TextStyle(color:firstColor),),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ));
  }

  void _switchAuthMode() {
    if (_authmode == AuthMode.Login) {
      setState(() {
        _authmode = AuthMode.SignUp;
      });
      _controller.forward();
    } else {
      setState(() {
        _authmode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }
  bool passvisi = true;
  bool passvisibilitye = true;

  @override
  Widget build(BuildContext context) {
    final deviceSize=MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authmode == AuthMode.SignUp ? 320 : 260,
        constraints:
        BoxConstraints(minHeight: _authmode == AuthMode.SignUp ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(
                      Icons.alternate_email,
                      color:secondaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')) {
                      return 'Invalid email..';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authData['email'] = val;
                  },
                ),
                TextFormField(
                  obscureText: passvisi,
                  decoration:  InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        passvisi ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passvisi = !passvisi;
                      });
                    },
                  ),
                ),
                  //obscureText: true,
                  controller: _passwordController,
                  validator: (val) {
                    if (val.isEmpty || val.length < 5) {
                      return 'Password is too Short!!..';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authData['password'] = val;
                  },
                ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authmode == AuthMode.SignUp ? 60 : 0,
                    maxHeight: _authmode == AuthMode.SignUp ? 120 : 0,
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slidAnimation,
                      child: TextFormField(
                        enabled: _authmode == AuthMode.SignUp,
                        obscureText: passvisibilitye,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(passvisibilitye
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                passvisibilitye = !passvisibilitye;
                              });
                            },
                          ),
                        ),

                        validator: _authmode == AuthMode.SignUp
                            ? (val) {
                          if (val != _passwordController.text) {
                            return 'Password Do Not Match!..';
                          }
                          return null;
                        }
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_isLoading) const CircularProgressIndicator(),
                RaisedButton(
                  child: Text(_authmode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
                    // style: TextStyle(color:secondaryColor ),
                  ),
                  onPressed: _submit,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  color:firstColor,
                  textColor: Theme.of(context).primaryTextTheme.headline6.color,
                ),
                const SizedBox(height: 10),
                TextButton(
                  child: Text(
                    '${_authmode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                    style: const TextStyle(
                      fontSize: 13,
                      color: secondaryColor,
                    ),
                  ),
                  onPressed: _switchAuthMode,

                  ///padding: EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                  ///textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

