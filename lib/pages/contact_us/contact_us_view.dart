// ignore_for_file: must_be_immutable, annotate_overrides, use_key_in_widget_constructors

import 'package:demo1212/appStyle/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsPageController> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  double width = 0.0;
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsPageController>(builder: (controller) {
      width = MediaQuery.of(context).size.width;
      return Scaffold(
          appBar: AppBar(
            title: const Text("Contact Us"),
            backgroundColor: AppColors.colorBlueDark,
          ),
          body: GestureDetector(
            onTap: (){
              // FocusScopeNode currentFocus = FocusScope.of(context);
              // if (!currentFocus.hasPrimaryFocus) {
              //    currentFocus.unfocus();
              //   }
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Form(
              key: _key,
              child: SafeArea(
                child: Center(
                  child: SizedBox(
                    width: width,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: width / 100 * 12,
                          right: width / 100 * 12,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              child: TextFormField(
                                controller: controller.fullnameController,
                                autovalidateMode: controller.fullnameControllermode,
                                keyboardType: TextInputType.text,
                                onChanged: (v){
                                  controller.fullNameChangeMode();
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Enter Your Full Name',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFAAAAAA),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length<3) {
                                    return 'Please Enter Valid Name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: TextFormField(
                                controller: controller.phoneNumberController,
                                autovalidateMode: controller.phoneNumberControllermode,
                                keyboardType: TextInputType.number,
                                onChanged: (v){
                                  controller.phoneChangeMode();
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Enter Your Phone Number',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFAAAAAA),
                                  ),
                                ),
                                validator: (values)
                                {
                                  if(values!.isEmpty || !RegExp("^(1[0-0]|[1-9])").hasMatch(values) || values.length != 10)
                                  {
                                    return "Enter valid Contact Number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: TextFormField(
                                controller: controller.emailController,
                                autovalidateMode: controller.emailControllermode,
                                keyboardType: TextInputType.emailAddress ,
                                onChanged: (v){
                                  controller.emailChangeMode();
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Enter Your Email',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFAAAAAA),
                                  ),
                                ),
                                validator: ((value) {
                                  if(value!.isEmpty || !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value) )
                                  {
                                    return "Enter valid Email address";
                                  }
                                  return null;
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 130,
                              child: Material(
                                elevation: 10,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(25),
                                child: TextFormField(
                                  controller: controller.messageController,
                                  autovalidateMode: controller.messageControllermode,
                                  minLines: 1,
                                  maxLines: 10,
                                  onChanged: (v){
                                    controller.messageChangeMode();
                                  },
                                  textAlignVertical: TextAlignVertical.top,
                                  style: const TextStyle(fontSize: 16, height: 1.3),
                                  decoration: InputDecoration(
                                    labelText: 'Type your message',
                                    labelStyle: const TextStyle(
                                      fontSize: 16,
                                      height: 0.7,
                                      color: Colors.grey,
                                    ),
                                    fillColor: Colors.white,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  validator: (values)
                                  {
                                    if(values!.isEmpty)
                                    {
                                      return "Enter Message";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: width,
                              height: 46,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                                  shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
          
                                  final FocusScopeNode currentFocus = FocusScope.of(context);
          
                                  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          
                                    currentFocus.focusedChild!.unfocus();
          
                                  }
          
                                  if (_key.currentState!.validate()) {
                                    _key.currentState!.save();
                                    print("sadfsdfjs");
                                    controller.sendMail(controller.emailController.text, controller.phoneNumberController.text, controller.fullnameController.text, controller.messageController.text);
                                    controller.sendEmail(controller.emailController.text);
          
                                    // controller.fullnameController.text="";
                                    // controller.phoneNumberController.text="";
                                    // controller.emailController.text="";
                                    // controller.messageController.text="";
          
                                    // controller.changeMode();
          
                                  }
                                },
                                child: const Text(
                                  "Send",
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}