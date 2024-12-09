import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opennas/features/authentication/presentation/widgets/submit_button.dart';
import 'package:opennas/features/authentication/providers/authentication.dart';
import 'package:opennas/shared/widgets/styled_text_box.dart';
import 'package:opennas/theme/theme.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Open',
                          style:
                              Theme.of(context).custom.textTheme.titleLargeBold,
                        ),
                        Text('NAS',
                            style: Theme.of(context)
                                .custom
                                .textTheme
                                .titleLargeBold
                                .copyWith(
                                  color: Theme.of(context)
                                      .custom
                                      .colorTheme
                                      .primary,
                                )),
                      ],
                    ),
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).custom.textTheme.titleLarge,
                    ),
                    Text(
                      "Let's get you into Rubisco",
                      style: Theme.of(context).custom.textTheme.subtitle1,
                    ),
                    const SizedBox(height: 20),
                    StyledTextBox(
                      defaultText: 'Username',
                      controller: usernameController,
                    ),
                    const SizedBox(height: 10),
                    StyledTextBox(
                      defaultText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 20,
                      child: Row(
                        children: [
                          const Spacer(),
                          Text("Forgot Password?",
                              style:
                                  Theme.of(context).custom.textTheme.subtitle1)
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: SizedBox(
                          width: double.infinity,
                          child: SubmitButton(
                              text: "Login",
                              callback: () async {
                                ref.read(authenticationProvider.notifier).login(
                                    usernameController.text,
                                    passwordController.text);
                              }),
                        )),
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context).custom.textTheme.subtitle1,
                        ),
                        Text("Sign Up",
                            style: Theme.of(context)
                                .custom
                                .textTheme
                                .subtitle2
                                .copyWith(
                                  color: Theme.of(context)
                                      .custom
                                      .colorTheme
                                      .primary,
                                )),
                        const SizedBox(height: 128),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
