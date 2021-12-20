// import 'package:cinema_project/ui/screens/auth/register.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   TextEditingController _emailController;
//   TextEditingController _passwordController;
//
//   @override
//   void initState() {
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String hintTextEmail = tr("hintEmail");
//     String hintTextPassword = tr("hintPassword");
//     return SafeArea(
//       child: Scaffold(
//           body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.8,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(1.0),
//                   child: Text(
//                     'Welcome to Movietime!',
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
//                   ).tr(),
//                 ),
//                 SizedBox(height: 15),
//                 Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.blueGrey.withOpacity(0.2),
//                             blurRadius: 10,
//                             spreadRadius: -7)
//                       ],
//                       borderRadius: BorderRadius.circular(10)),
//                   child: TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.text,
//                     textInputAction: TextInputAction.next,
//                     onFieldSubmitted: (v) {
//                       FocusScope.of(context).nextFocus();
//                     },
//                     decoration: InputDecoration(
//                         hintText: tr(hintTextEmail),
//                         border: InputBorder.none,
//                         alignLabelWithHint: true,
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.blueGrey.withOpacity(0.2),
//                             blurRadius: 10,
//                             spreadRadius: -7)
//                       ],
//                       borderRadius: BorderRadius.circular(10)),
//                   child: TextFormField(
//                     controller: _passwordController,
//                     keyboardType: TextInputType.visiblePassword,
//                     obscureText: true,
//                     textInputAction: TextInputAction.next,
//                     onFieldSubmitted: (v) {
//                       FocusScope.of(context).nextFocus();
//                     },
//                     decoration: InputDecoration(
//                         hintText: tr(hintTextPassword),
//                         border: InputBorder.none,
//                         alignLabelWithHint: true,
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: FlatButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Forgot Password?',
//                       style: TextStyle(
//                           color: Theme.of(context).accentColor,
//                           fontWeight: FontWeight.bold),
//                     ).tr(),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                     width: double.infinity,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: CupertinoButton(
//                           color: Theme.of(context).accentColor,
//                           padding: EdgeInsets.all(18),
//                           onPressed: () {},
//                           child: Text("Login",
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w800))
//                               .tr()),
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   child: Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text("Don't have an account?",
//                             style: TextStyle(
//                               color: Theme.of(context).hintColor,
//                             )).tr(),
//                         SizedBox(width: 3),
//                         Container(
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.to(Register());
//                             },
//                             child: Text("Sign Up",
//                                     style: TextStyle(
//                                         color: Theme.of(context).accentColor,
//                                         fontWeight: FontWeight.bold))
//                                 .tr(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }
