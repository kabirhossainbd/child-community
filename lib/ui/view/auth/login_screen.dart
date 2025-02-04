import 'package:child_community/service/themes/color_scheme.dart';
import 'package:child_community/ui/component/custom_button.dart';
import 'package:child_community/ui/component/custom_text_field.dart';
import 'package:child_community/ui/component/custom_toast.dart';
import 'package:child_community/ui/view/auth/signup_screen.dart';
import 'package:child_community/ui/view/dashboard/dashboard_screen.dart';
import 'package:child_community/util/dimensions.dart';
import 'package:child_community/util/images.dart';
import 'package:child_community/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';

import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _isUserNameEmailError = false;
  bool _isPasswordError = false;
  bool _isPasswordLengthError = false;


  @override
  void initState() {

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: (){
            setState(() {
              _emailFocus.unfocus();
              _emailFocus.canRequestFocus = false;
              _passwordFocus.unfocus();
              _passwordFocus.canRequestFocus = false;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(left: 22.0, right: 22.0),
            decoration: const BoxDecoration(

            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("Log in for Social Feed",style: interRegular.copyWith(fontSize: 20,color: Theme.of(context).colorScheme.crossColor),),

                      const SizedBox(height: 75,),
                      Align(alignment: Alignment.centerLeft,
                          child:Text("Email / Username",style: interMedium.copyWith(fontSize: 12,color: Colors.grey.shade700),)
                      ),
                      const SizedBox(height: 6,),
                      CustomTextField(
                        //backgroundColor: ColorResources.COLOR_WHITE,
                        borderRadius:  BorderRadius.circular(8),
                        hintText: 'Email or username',
                        isShowBorder: true,
                        // isError: _isUserNameEmailError,
                        inputType: TextInputType.emailAddress,
                        focusNode: _emailFocus,
                        nextFocus: _passwordFocus,
                        inputAction: TextInputAction.next,
                        controller: _emailController,
                        //prefixIconUrl: AllImages.person,
                        //isShowPrefixIcon: true,
                        onChanged: (text){
                          setState(() {
                            text = _emailController.text;
                            _isUserNameEmailError = false;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      Align(alignment: Alignment.centerLeft, child: Text("Password",style: interMedium.copyWith(fontSize: 12,color: Colors.grey.shade700),)),
                      const SizedBox(height: 6,),
                      CustomTextField(
                        borderRadius:  BorderRadius.circular(8),
                        hintText: 'Password',
                        isShowBorder: true,
                        isShowSuffixIcon: true,
                        // isError: _isPasswordError,
                        inputAction: TextInputAction.done,
                        focusNode: _passwordFocus,
                        controller: _passwordController,
                        //isShowPrefixIcon: true,
                        //prefixIconUrl: AllImages.lock,
                        isIcon: true,
                        suffixActiveIconUrl: AllImages.eye,
                        suffixInactiveIconUrl: AllImages.eyeOff,
                        onChanged: (text){
                          setState(() {
                            text = _passwordController.text;
                            _isPasswordError = false;
                            _isPasswordLengthError = false;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          debugPrint("ON TAP");

                          Navigator.push(context, PageTransition(
                              child: const ForgotPasswordScreen(),
                              type: PageTransitionType.leftToRight));

                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Forgot Password',
                            style: interRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).primaryColor, ), textAlign: TextAlign.left,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        height: 30,
                        child: Column(
                          children: [
                            if(_isUserNameEmailError || _isPasswordError)...[
                              Row(
                                children: [
                                  Align(alignment: Alignment.centerLeft,
                                      child:Text("Wrong email address/username or password ",style: interRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.redColor),)
                                  ),
                                ],
                              ),
                            ]else if(_isPasswordLengthError)...[
                              Row(
                                children: [
                                  Align(alignment: Alignment.centerLeft,
                                      child:Text('Password Should Be',style: interRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.redColor),)
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),


                      const SizedBox(height: 16),

                      CustomButton(
                          onTap: ()=> Navigator.pushAndRemoveUntil(context, PageTransition(child: const DashboardScreen(), type: PageTransitionType.bottomToTop), (route) => false),
                          buttonText: 'Login',
                          isColor: (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty)),

                      const SizedBox(height: Dimensions.fontSizeOverLarge),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              width: Get.width,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0, right: 6),
                            child: Center(
                              child: Text(
                                " or ",
                                style: interRegular.copyWith(color: Colors.grey.shade900, fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: Get.width,
                              color:  Colors.grey.shade200,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: Dimensions.fontSizeOverLarge),

                      InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () async {
                            // onPressedGoogleLogin();
                            showCustomToast("Login Into Google");
                          },
                          child: Container(alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context).primaryColor.withOpacity(0.07)
                                //border: Border.all(color: ColorResources.COLOR_PRIMARY,width: 0.5)
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AllImages.home, height: 32, width: 32 ),
                                  const SizedBox(width: 8,),
                                  Text("Continue with Google",style: interRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.grey.shade900),)
                                ],
                              ))),
                    ],
                  ),
                ),

                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () => Navigator.push(context, PageTransition(child: const SignupScreen(), type: PageTransitionType.rightToLeft)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Don't have account",
                      style: interRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                // const SizedBox(height: 16,),
              ],
            ),

          ),
        ),

    );
  }

  void signInWithFaceBook() async {
    showCustomToast("Upcoming Features");
  }

  void signInWithAppleId() {
    showCustomToast("Upcoming Feature");
  }
}
