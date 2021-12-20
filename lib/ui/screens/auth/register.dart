// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'login.dart';
//
// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   TextEditingController _nameController;
//   TextEditingController _emailController;
//   TextEditingController _passwordController;
//   String selectedType = 'User';
//
//   @override
//   void initState() {
//     _nameController = TextEditingController();
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String hintTextName = tr("hintName");
//     String hintTextEmail = tr("hintEmail");
//     String hintTextPassword = tr("hintPassword");
//     return SafeArea(
//       child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           appBar: AppBar(
//             title:
//                 Text('Register', style: TextStyle(fontWeight: FontWeight.w700))
//                     .tr(),
//             centerTitle: true,
//             elevation: 10,
//             shadowColor: Colors.black12,
//             iconTheme: IconThemeData(color: Colors.black),
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: Text(
//                         'Full Name',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 18),
//                       ).tr(),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.blueGrey.withOpacity(0.2),
//                                 blurRadius: 10,
//                                 spreadRadius: -7)
//                           ],
//                           borderRadius: BorderRadius.circular(10)),
//                       child: TextFormField(
//                         controller: _nameController,
//                         keyboardType: TextInputType.text,
//                         textInputAction: TextInputAction.next,
//                         onFieldSubmitted: (v) {
//                           FocusScope.of(context).nextFocus();
//                         },
//                         decoration: InputDecoration(
//                             hintText: tr(hintTextName),
//                             border: InputBorder.none,
//                             alignLabelWithHint: true,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 12)),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: Text(
//                         'Email Address',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 18),
//                       ).tr(),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.blueGrey.withOpacity(0.2),
//                                 blurRadius: 10,
//                                 spreadRadius: -7)
//                           ],
//                           borderRadius: BorderRadius.circular(10)),
//                       child: TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.text,
//                         textInputAction: TextInputAction.next,
//                         onFieldSubmitted: (v) {
//                           FocusScope.of(context).nextFocus();
//                         },
//                         decoration: InputDecoration(
//                             hintText: tr(hintTextEmail),
//                             border: InputBorder.none,
//                             alignLabelWithHint: true,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 12)),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: Text(
//                         'Password',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 18),
//                       ).tr(),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.blueGrey.withOpacity(0.2),
//                                 blurRadius: 10,
//                                 spreadRadius: -7)
//                           ],
//                           borderRadius: BorderRadius.circular(10)),
//                       child: TextFormField(
//                         controller: _passwordController,
//                         keyboardType: TextInputType.visiblePassword,
//                         textInputAction: TextInputAction.next,
//                         onFieldSubmitted: (v) {
//                           FocusScope.of(context).nextFocus();
//                         },
//                         decoration: InputDecoration(
//                             hintText: tr(hintTextPassword),
//                             border: InputBorder.none,
//                             alignLabelWithHint: true,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 12)),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.all(1.0),
//                       child: Text(
//                         'Account Type',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 18),
//                       ).tr(),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       child: Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text("Do you have an account?",
//                                 style: TextStyle(
//                                   color: Theme.of(context).hintColor,
//                                 )).tr(),
//                             SizedBox(width: 3),
//                             Container(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Get.to(Login());
//                                 },
//                                 child: Text("Sign In",
//                                         style: TextStyle(
//                                             color:
//                                                 Theme.of(context).accentColor,
//                                             fontWeight: FontWeight.bold))
//                                     .tr(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
