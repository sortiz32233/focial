import 'package:flutter/material.dart';
import 'package:focial/screens/signup/signup_viewmodel.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/strings.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';
import 'package:focial/widgets/stackinflow.dart';
import 'package:focial/widgets/text_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: AppTheme.backgroundColor,
      body: ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        onModelReady: (m) => m.init(context),
        builder: (context, model, child) => _getBody(model, context),
      ),
      bottomNavigationBar: StackInFlow(),
    );
  }

  AppBar _appBar() => AppBar(
        title: const Text(
          'Signup',
          style: AppTheme.appBarTextStyle,
        ),
      );

  Widget _getBody(SignUpViewModel controller, BuildContext context) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Text(
                "Welcome to Focial\nRegister and get started, we never share our user's  data",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 8.0),
            _getForm(controller, context),
            _getButtons(controller, context),
            const SizedBox(height: 8.0),
            _getSocialMediaButtons(controller),
          ],
        ),
      );

  Widget _getForm(SignUpViewModel controller, BuildContext context) => Card(
        elevation: 8.0,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TFWithIcon(
                  label: 'Full name',
                  hint: 'John Doe',
                  icon: FontAwesomeIcons.user,
                  validateLength: 3,
                  save: controller.saveName,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TFWithIcon(
                  label: 'Email',
                  hint: 'john@doe.com',
                  icon: Icons.mail_outline,
                  iconSize: 24.0,
                  validator: controller.validateEmail,
                  save: controller.saveEmail,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TFWithIcon(
                  label: 'Password',
                  hint: '***************',
                  icon: FontAwesomeIcons.unlockAlt,
                  validator: controller.validatePassword,
                  isObscure: !controller.passwordShown,
                  save: controller.savePassword,
                  suffixIcon: IconButton(
                    icon: Icon(controller.passwordShown ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => controller.togglePasswordVisibility(),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget _getButtons(SignUpViewModel controller, BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: AppPlatformButtonWithArrow(
              onPressed: () => controller.validateAndRegister(context),
              text: 'SIGNUP',
            ),
          ),
          const SizedBox(height: 16.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'By creating an account, you agree to our',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Terms of service  ',
                      style: AppTheme.flatButtonTheme,
                    ),
                  ),
                  Text(
                    'and',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      '  Privacy policy',
                      style: AppTheme.flatButtonTheme,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      );

  Widget _getSocialMediaButtons(SignUpViewModel controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SocialMediaButton(
          onPressed: () {},
          asset: Assets.googleLogo,
          text: Strings.signupWithGoogle,
        ),
        const SizedBox(height: 8.0),
        SocialMediaButton(
          onPressed: () {},
          asset: Assets.facebookLogo,
          text: Strings.signUpWithFacebook,
        ),
      ],
    );
  }
}
