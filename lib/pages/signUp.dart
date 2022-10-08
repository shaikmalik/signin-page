import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';
import 'package:get/get.dart';


class SignUp extends StatefulWidget {
 
  const SignUp({Key?key}):super(key:key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar:AppBar(title:const Text("Sign Up"),centerTitle:true),
    body:SingleChildScrollView(
      padding:const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,
        children:[
          FlutterLogo(size:120),
                const SizedBox(height:8),
                const Text("Welcome to Flutter",style:TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
                const SizedBox(height:10),
                TextFormField(
                  style:const TextStyle(color:Colors.black),
                  obscureText: false,
                  controller:usernameController,
                  decoration:InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color:Colors.blue),
                      borderRadius: BorderRadius.circular(20),                      
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color:Colors.blue),
                      borderRadius: BorderRadius.circular(20)
                ),
                hintText: "Enter your Username: ",
                hintStyle: const TextStyle(color:Colors.blue),
                    label: const Text("Username")
                    ),        
                      
                    
                  ),
                
                const SizedBox(height:8),
                TextFormField(
                  style:const TextStyle(color:Colors.black),
                  obscureText: false,
                  controller:passwordController,
                  decoration:InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color:Colors.blue),
                      borderRadius: BorderRadius.circular(20),                      
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color:Colors.blue),
                      borderRadius: BorderRadius.circular(20)
                ),
                    
                    hintText: "Password : ",
                    hintStyle: const TextStyle(color:Colors.blue),
                    label: const Text("Password")
                  )
                ),
                const SizedBox(height:20),
                ElevatedButton.icon(
                  style:ElevatedButton.styleFrom(
                    minimumSize:const Size.fromHeight(50)
                  ),
                  icon:const Icon(Icons.lock_open),
                  label:const Text("SignUp"),
                  onPressed:signUp,
                ),
                const SizedBox(height:20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Have an Account? "),
                    ElevatedButton(
                        child:Text("Sign In"),
                        onPressed:() {
                         Get.toNamed('/');
                        }
                      )
                  ]
                )
                
            
        ]
      ),
    )
  );

Future signUp() async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: usernameController.text.trim(), password: passwordController.text.trim());
  

}
}
