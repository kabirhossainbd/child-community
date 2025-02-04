import 'dart:async';
import 'package:child_community/service/themes/color_scheme.dart';
import 'package:child_community/ui/component/custom_button.dart';
import 'package:child_community/ui/component/custom_text_field.dart';
import 'package:child_community/ui/view/dashboard/dashboard_screen.dart';
import 'package:child_community/util/dimensions.dart';
import 'package:child_community/util/images.dart';
import 'package:child_community/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:page_transition/page_transition.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final FocusNode _emailNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _conPasswordFocus = FocusNode();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _conPasswordController;
  DateTime dateTime = DateTime.now();
  final tooltipController = JustTheController();

  bool _isActiveBtn = false;

  late StreamSubscription<bool> keyboardSubscription;

  bool _isUserEmailError = false;
  bool _isPasswordError = false;
  bool _isConPasswordError = false;
  bool _isPasswordLengthError = false;
  bool _isConPasswordLengthError = false;
  bool _isPasswordNotMatchError = false;

  bool _isPassFocus = false;

  bool _isError = false;
  final String _isErrorText = '';

  @override
  void initState() {
    // Get.find<AuthController>().setStrongPass(false, false);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _conPasswordController = TextEditingController();

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {});
    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus) {
        setState(() {
          _isPassFocus = true;
          _passwordController.clear();
        });
      }else{
        setState(() {
          _isPassFocus = false;
        });
      }
    },
    );

    super.initState();
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: (){
                        setState(() {
                          _emailNameFocus.unfocus();
                          _emailNameFocus.canRequestFocus = false;
                          _passwordFocus.unfocus();
                          _passwordFocus.canRequestFocus = false;
                          _conPasswordFocus.unfocus();
                          _conPasswordFocus.canRequestFocus = false;
                          _isPassFocus = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          children: [
                            Expanded(
                              child: NotificationListener<OverscrollIndicatorNotification>(
                                onNotification: (overScroll) {
                                  overScroll.disallowIndicator();
                                  return true;
                                },
                                child: ListView(
                                  children: [
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          onTap: () => Get.back(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 8,8,8),
                                            child: SvgPicture.asset(AllImages.home, height: 16, width: 16,),
                                          ),
                                        ),

                                        Text('Step 1 of 1', style: interRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.crossColor),),
                                      ],
                                    ),
                                    // InkWell(onTap: ()=> Get.to(TestEmailVerifyScreen()),child: Image.asset(AllImages.appIcon, height: Dimensions.fontSize40, width: Dimensions.fontSize40,)),
                                    const SizedBox(height: 16,),
                                    Align(alignment: Alignment.center, child: Text("Sign up for Social Feed",style: interBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).colorScheme.gray_20),)),

                                    const SizedBox(height: 32),

                                    /// for email
                                    Align(alignment: Alignment.centerLeft,
                                        child:Text("Email",style: interMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.crossColor),)
                                    ),
                                    const SizedBox(height: 6,),
                                    CustomTextField(
                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(8),
                                      hintText: 'Email',
                                      isShowBorder: true,
                                      isError: (_isUserEmailError || _isError),
                                      inputType: TextInputType.emailAddress,
                                      focusNode: _emailNameFocus,
                                      nextFocus: _passwordFocus,
                                      inputAction: TextInputAction.next,
                                      controller: _emailController,
                                      onChanged: (text){
                                        setState(() {
                                          text = _emailController.text;
                                          _isUserEmailError = false;
                                          _isPassFocus = false;
                                          _isError = false;
                                        });
                                      },

                                    ),
                                    const SizedBox(height: Dimensions.paddingSizeMediumSmall),
                                    if(_isUserEmailError)...[
                                      Row(
                                        children: [
                                          // SvgPicture.asset(AllImages.errorAlert, height: 16, width: 16,),
                                          // const SizedBox(width: 4),
                                          Align(alignment: Alignment.centerLeft,
                                              child:Text('Enter Valid Email',style: interRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.redColor),)
                                          ),
                                        ],
                                      ),
                                    ],
                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                                    /// for password
                                    Align(alignment: Alignment.centerLeft,
                                        child:Text("Password",style: interMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.crossColor),)
                                    ),
                                    const SizedBox(height: 6,),
                                    CustomTextField(
                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(8),
                                      hintText: 'Password',
                                      isShowBorder: true,
                                      isShowSuffixIcon: true,
                                      inputAction: TextInputAction.next,
                                      focusNode: _passwordFocus,
                                      nextFocus: _conPasswordFocus,
                                      controller: _passwordController,
                                      isIcon: true,
                                      suffixActiveIconUrl: AllImages.eye,
                                      suffixInactiveIconUrl: AllImages.eyeOff,
                                      onChanged: (text){
                                        setState(() {
                                          text = _passwordController.text;
                                          _isPasswordError = false;
                                          _isPasswordLengthError = false;
                                          _isPasswordNotMatchError = false;
                                          _isPassFocus = true;
                                        });
                                      },
                                    ),

                                    const SizedBox(height: 5),
                                    if(_isPasswordError)...[
                                      Row(
                                        children: [
                                          // SvgPicture.asset(AllImages.errorAlert, height: 16, width: 16,),
                                          // const SizedBox(width: 4),
                                          Align(alignment: Alignment.centerLeft,
                                              child:Text('Enter Valid Email',style: interRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.redColor),)
                                          ),
                                        ],
                                      ),
                                    ]else if(_isPasswordLengthError)...[
                                      Row(
                                        children: [
                                          // SvgPicture.asset(AllImages.errorAlert, height: 16, width: 16,),
                                          // const SizedBox(width: 4),
                                          Align(alignment: Alignment.centerLeft,
                                              child:Text('Password Should Be',style: interRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.redColor),)
                                          ),
                                        ],
                                      ),
                                    ],


                                    if(_isPassFocus)...[

                                    ],

                                    const SizedBox(height: 5),


                                    /// for password
                                    Align(alignment: Alignment.centerLeft,
                                        child:Text("Confirm Password",style: interMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.gray_20),)
                                    ),
                                    const SizedBox(height: 6,),
                                    CustomTextField(
                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(8),
                                      hintText: 'Confirm password',
                                      isShowBorder: true,
                                      isShowSuffixIcon: true,
                                      inputAction: TextInputAction.done,
                                      focusNode: _conPasswordFocus,
                                      controller: _conPasswordController,
                                      isIcon: true,
                                      suffixActiveIconUrl: AllImages.eye,
                                      suffixInactiveIconUrl: AllImages.eyeOff,
                                      onChanged: (text){
                                        setState(() {
                                          text = _conPasswordController.text;
                                          _isConPasswordError = false;
                                          _isConPasswordLengthError = false;
                                          _isPasswordNotMatchError = false;
                                          _isPassFocus = false;
                                        });
                                      },
                                    ),

                                    const SizedBox(height: 16),
                                    if(_isConPasswordError)...[
                                      Row(
                                        children: [
                                          // SvgPicture.asset(AllImages.errorAlert, height: 16, width: 16,),
                                          // const SizedBox(width: 4),
                                          Align(alignment: Alignment.centerLeft,
                                              child:Text('Enter Valid Email',style: interRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.redColor),)
                                          ),
                                        ],
                                      ),
                                    ]else if(_isConPasswordLengthError)...[
                                      Row(
                                        children: [
                                          // SvgPicture.asset(AllImages.errorAlert, height: 16, width: 16,),
                                          // const SizedBox(width: 4),
                                          Align(alignment: Alignment.centerLeft,
                                              child:Text('Password Should Be',style: interRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.redColor),)
                                          ),
                                        ],
                                      ),
                                    ]else if(_isPasswordNotMatchError)...[
                                      Row(
                                        children: [
                                          // SvgPicture.asset(AllImages.errorAlert, height: 16, width: 16,),
                                          // const SizedBox(width: 4),
                                          Align(alignment: Alignment.centerLeft,
                                              child:Text('Password confirmation does not match',style: interRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.redColor),)
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ]else if(_isError)...[
                                      Row(
                                        children: [
                                          // SvgPicture.asset(AllImages.errorAlert, height: 16, width: 16,),
                                          // const SizedBox(width: 4),
                                          Align(alignment: Alignment.centerLeft,
                                              child:Text(_isErrorText,style: interRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).colorScheme.redColor),)
                                          ),
                                        ],
                                      ),
                                    ],

                                  ],
                                ),
                              ),
                            ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'By continuing, you agree to our',
                                        style: interRegular.copyWith(color: Theme.of(context).colorScheme.crossColor, fontSize: Dimensions.fontSizeExtraSmall)),
                                    TextSpan(
                                      text: 'Terms & Condition',
                                      style: interRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeExtraSmall,),
                                    ),

                                    TextSpan(
                                      text:' and ',
                                      style: interRegular.copyWith(color: Theme.of(context).colorScheme.crossColor, fontSize: Dimensions.fontSizeExtraSmall),
                                    ),
                                    TextSpan(
                                      /* recognizer: TapGestureRecognizer()
                                            ..onTap = () => Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: const PrivacyPolicy())),
                                         */
                                        text: 'Privacy Policy',
                                        style: interRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeExtraSmall,)
                                    ),
                                    TextSpan(
                                      text: ',',
                                      style: interRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeExtraSmall,),
                                    ),
                                    TextSpan(
                                        text: 'Broadcast Agreement',
                                        style: interRegular.copyWith(color: Theme.of(context).colorScheme.gray_20, fontSize: Dimensions.fontSizeExtraSmall,)
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 16),
                              CustomButton(
                                  onTap: ()=>
                                      Navigator.push(context, PageTransition(child: const DashboardScreen(), type: PageTransitionType.bottomToTop)),
                                  buttonText: 'Continue',
                                  isColor: _isActiveBtn
                              ),
                              const SizedBox(height: 8),

                              /// for login
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                onTap: () => Get.back(),
                                child: Text(
                                  'Already Have Account',
                                  style: interRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).primaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              const SizedBox(height: 24),

                          ],
                        ),
                      ),
                    ),
            ),
          );
  }



  bool validatePass(String pass) {
    if (pass.isEmpty) {
      return true;
    }
    final emailRegex = RegExp(r"^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{6,}$");
    if (!emailRegex.hasMatch(pass)) {
      return true;
    }
    return false;
  }

}
