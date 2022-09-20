import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../controller/welcom_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import 'about.dart';
class SplashScreen extends StatelessWidget {
  late  ProgressDialog pr;
  final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'عربي','locale': Locale('ar','AR')},
  ];
  final welcomeController = Get.put(WelcomeController());
  TextEditingController _nameController =TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SplashScreen({Key? key}) : super(key: key);
  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: Text('Choose Your Language'.tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                        print(locale[index]['name']);
                        updateLanguage(locale[index]['locale']);
                      },),
                    );
                  }, separatorBuilder: (context,index){
                return Divider(
                  color: Colors.blue,
                );
              }, itemCount: locale.length
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: ListView(children: <Widget>[buildTopBanner(context), buildForm(context)]));
  }
  Widget buildTopBanner(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.amber,
      child: Stack(
        // alignment: Alignment.bottomLeft,
        children: <Widget>[
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(onTap:(){         buildLanguageDialog(context);
            ;},
              child: Row(
                children: [
                  Text('language'.tr),
                  Icon( Icons.language),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(onTap:(){ Get.to(() => About());},
              child: Row(
                children: [
                  Text('about application'.tr),
                  Icon( Icons.info),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 50,bottom: 50,right: 50,
            child: Text('Welcom To  Track Footsteps Application'.tr,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900)),
          )
        ],
      ),
    );
  } // end of TopBanner

  Widget buildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        // autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          children: <Widget>[
            //email
            CustomTextField(
              label: 'User_name'.tr,
              controller: _nameController,
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please register your name'.tr;
                }
              },
            ),
            //password
            PrimaryButton(
              label: 'Login'.tr,
              onPress: () {
        print(_nameController.text);

   if (_formKey.currentState!.validate()) {
     pr = ProgressDialog(context);
     pr.show();
     welcomeController.register(user_name: _nameController.text.trim());
     pr.hide();
   }
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  } // end of Form

}
