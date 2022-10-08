import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signin/google_sign.dart';
import 'package:signin/pages/forgotPage.dart';
import 'package:signin/pages/homePage.dart';
import 'package:signin/pages/signUp.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      
      ChangeNotifierProvider<GoogleSignInProvider>(
    create:(context) {
      return GoogleSignInProvider();
    }
    )],
    child:GetMaterialApp(
    
    getPages: [
      GetPage(name:'/home',page:()=>const HomePage()),
      GetPage(name:'/',page:()=>const LoginPage()),
      GetPage(name:'/signup',page:()=>const SignUp()),
      GetPage(name:'/forget',page:()=>const ForgotPage())
    ],
    home:const LoginPage(),
    theme: ThemeData(
          primaryColor: Colors.white,
          inputDecorationTheme:  InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            focusColor: Colors.white,
          )),)));
  await Firebase.initializeApp();
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key?key}):super(key:key);
  @override 
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) => Scaffold(
    body:Stack(
      children:[
        ///  background image with black filter.
        /// 
        /// 
         ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOver),
            child:Container(
          decoration: const BoxDecoration(
            image:DecorationImage(image:NetworkImage('https://images.unsplash.com/photo-1600275669439-14e40452d20b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDB8fG9mZmljZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),fit:BoxFit.cover)
          )
        )),
        Form(
          key:formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:const EdgeInsets.only(top:250,left:10,right:10),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                   const Center(child:Text("Login using Social Sign On",style:TextStyle(fontSize:20,color:Colors.white))),
                   const SizedBox(height:10),
                   GestureDetector(
                     child: Center(
                      child:CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child:CircleAvatar(
                          radius:22,
                          backgroundColor: Colors.black,
                          child:Image.network(
                              'http://pngimg.com/uploads/google/google_PNG19635.png',
                              fit:BoxFit.cover)
                          )
                        )
                      ),
                      onTap:(){
                        final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
                        provider.googleLogIn();
                        Get.toNamed('/home');
                      }
                   ), 
                   const SizedBox(height:12),
                const Text("Login using email",style:TextStyle(fontSize:20,color:Colors.white)),
                const SizedBox(height:12),
        
              /// textfield for email with validator 
        
                TextFormField(
                    style:const TextStyle(color: Colors.white),
                    obscureText: false,
                    controller:username,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    decoration:InputDecoration(
                      prefixIcon:const Icon(Icons.mail,color:Colors.white),
                      suffixIcon:IconButton(
                        icon:const Icon(Icons.clear,color:Colors.white),
        
                        onPressed:() {
                          username.clear();
                        }
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:const BorderSide(color:Colors.white),
                        borderRadius: BorderRadius.circular(20),                      
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:const BorderSide(color:Colors.white),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: "Email: ",
                      hintStyle:const TextStyle(color:Colors.white),
                      label: const Text("Username")
                    ),
                    validator:(email) => email != null && !EmailValidator.validate(email) ? 'Enter a valid Email' : null
                  ),
                  const SizedBox(height:12),
        
            /// textfield for password with validator      
                  TextFormField(
                    style:const TextStyle(color: Colors.white),
                    obscureText: false,
                    controller:password,
                    keyboardType: TextInputType.visiblePassword,
                    
                    decoration:InputDecoration(
                      suffixIcon:IconButton(
                        icon:const Icon(Icons.clear,color:Colors.white),
                        onPressed:() {
                          password.clear();
                        }
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:const BorderSide(color:Colors.white),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:const BorderSide(color:Colors.white),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: "Password : ",
                      hintStyle:const TextStyle(color:Colors.white),
                      label: const Text("Password")
                    ),
                    
                  ),
                  const SizedBox(height:12),
                  ElevatedButton.icon(
                    icon:const Icon(Icons.mail),
                    label:const Text("Login",style:TextStyle(color:Colors.white,fontSize:20)),
                    style:ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
                    onPressed:() {
                      signIn();
                      
                      final form = formKey.currentState!;
                      if(form.validate()) {
                            final email = username.text;
                            ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content:Text("You logged in with $email")));
                        }   
                      Get.toNamed('/home');                   
                    }
                  ),
                  const SizedBox(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Expanded(
                        child: ElevatedButton(
                                        style:ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      minimumSize: const Size.fromHeight(20),
                                      textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                                        onPressed:() {
                                          Get.toNamed('/signup');
                                        },
                                        child:const Text("Create Account here ",style:TextStyle(color:Colors.white,fontSize:12))
                                      ),
                      ),
                      const SizedBox(width:30),
                  Expanded(
                    child: ElevatedButton(                  
                      style:ElevatedButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: const Size.fromHeight(20),
                    textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
                      onPressed:() {
                        Get.toNamed('/forget');
                      },                  
                      child:const Text("Forget Password?",style:TextStyle(color:Colors.white,fontSize:12))
                    ),
                  ),
                          
        
                    ]
                  )
                ]
              )
            ),
          ),
        )

      ]
    )
  );
 Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email:username.text.trim(), password: password.text.trim());  
 }
}