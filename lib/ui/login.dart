import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:supa_manager/supa_manager.dart';
import 'package:utilities/utilities.dart';

import '../providers.dart';

typedef VisibilityButtonPressed = void Function(bool);

@RoutePage(name: 'LoginRoute')
class Login extends ConsumerStatefulWidget {
  final ValueChanged<bool> onResult;

  const Login({required this.onResult, super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  late TextEditingController emailTextController;
  late TextEditingController repeatPasswordTextController;
  late TextEditingController passwordTextController;
  var rememberMe = true;
  var useLoginScreen = true;
  var hideFirstPassword = true;
  var hideSecondPassword = true;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController(text: '');
    repeatPasswordTextController = TextEditingController(text: '');
    passwordTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    emailTextController.dispose();
    repeatPasswordTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: createWhiteBorder(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: useLoginScreen ? createLoginScreen() : createCreateAccountScreen(),
          ),
          // ),
        ),
      ),
    );
  }

  Widget createLoginScreen() {
    return ListView(
      children: [
        createLoginLabel(),
        const SizedBox(height: 16),
        createEmailTextField(),
        createEmailField(),
        createPasswordTextField(),
        createPasswordField(
          passwordTextController,
          hideFirstPassword,
          toggleFirstPasswordVisibility,
        ),
        // createGoogleLoginButton(),
        createRememberMeRow(),
        const SizedBox(height: 16),
        createLoginButtonRow(),
        const SizedBox(height: 8),
        createAnAccountRow(),
        const SizedBox(height: 16),
      ],
    );
  }

  void toggleFirstPasswordVisibility(bool visible) {
    hideFirstPassword = visible;
  }

  void toggleSecondPasswordVisibility(bool visible) {
    hideSecondPassword = visible;
  }

  Widget createCreateAccountScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 32.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    useLoginScreen = true;
                  });
                },
                icon: const Icon(Icons.chevron_left),
              ),
              TextButton(
                style: ButtonStyle(foregroundColor: WidgetStateProperty.all<Color>(Colors.black)),
                onPressed: () {
                  setState(() {
                    useLoginScreen = true;
                  });
                },
                child: Text('Create an account', style: titleBlackText),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 12.0),
          child: Text('Email', style: largeBlackText),
        ),
        createEmailField(),
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 0.0, bottom: 12.0),
          child: Text('Password', style: largeBlackText),
        ),
        createPasswordField(
          passwordTextController,
          hideFirstPassword,
          toggleFirstPasswordVisibility,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 0.0, bottom: 12.0),
          child: Text('Repeat Password', style: largeBlackText),
        ),
        createPasswordField(
          repeatPasswordTextController,
          hideSecondPassword,
          toggleSecondPasswordVisibility,
        ),
        // Expanded(
        //   child: TextField(
        //     keyboardType: TextInputType.text,
        //     obscureText: true,
        //     enableSuggestions: false,
        //     autocorrect: false,
        //     decoration: createTextBorder('Min. 8 characters', null),
        //     autofocus: false,
        //     onSubmitted: (value) {},
        //     controller: repeatPasswordTextController,
        //   ),
        // ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: lightBlueColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                    elevation: 0,
                    shape: createWhiteRoundedBorder(),
                  ),
                  onPressed: () async {
                    await createUser();
                  },
                  child: const Text('Create Account'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Future<bool> createUser() async {
    final email = emailTextController.text;
    final password1 = passwordTextController.text;
    final password2 = repeatPasswordTextController.text;
    if (email.isEmpty) {
      showSnackBar(context, 'Email cannot be empty');
      return false;
    }
    if (password1.isEmpty || password2.isEmpty) {
      showSnackBar(context, 'Passwords cannot be empty');
      return false;
    }
    if (password1 != password2) {
      showSnackBar(context, 'Passwords are not equal');
      return false;
    }
    final authenticator = getSupaAuthManager(ref);
    final result = await authenticator.createUser(email, password1);
    switch (result) {
      case Success(data: final data):
        return data;
      case Failure(error: final error):
        if (error is SignedOutException) {
          ref.read(configurationProvider).loginStateNotifier.loggedIn(false);
        }
        logError(error.toString());
      case ErrorMessage(message: final message, code: _):
        logError(message!);
    }
    return false;
  }

  Widget createPasswordField(
    TextEditingController controller,
    bool showText,
    VisibilityButtonPressed buttonPressed,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.text,
            obscureText: showText,
            enableSuggestions: false,
            autofocus: false,
            onSubmitted: (value) {},
            controller: controller,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            decoration: createTextBorder(
              'Min. 8 characters',
              IconButton(
                onPressed: () {
                  setState(() {
                    buttonPressed(showText.toggle());
                  });
                },
                icon: Icon((showText ? Icons.visibility : Icons.visibility_off)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget createEmailField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: createTextBorder('bob@example.com', null),
            autofocus: false,
            textInputAction: TextInputAction.next,
            onSubmitted: (value) {},
            controller: emailTextController,
          ),
        ),
      ],
    );
  }

  Widget createGoogleLoginButton() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: lightBlueColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                  elevation: 0,
                  shape: createWhiteRoundedBorder(),
                ),
                onPressed: () async {
                  if (emailTextController.text.isNotEmpty &&
                      passwordTextController.text.isNotEmpty) {
                    if (await login(emailTextController.text, passwordTextController.text)) {
                      if (!mounted) return;
                      widget.onResult(true);
                    } else {
                      // widget.onResult(false);
                    }
                  }
                },
                child: const Text('Google SignIn'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget createEmailTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 12.0),
      child: Text('Email', style: largeBlackText),
    );
  }

  Widget createPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 0.0, bottom: 12.0),
      child: Text('Password', style: largeBlackText),
    );
  }

  Widget createRememberMeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          value: rememberMe,
          activeColor: Colors.blue,
          checkColor: Colors.white,
          onChanged: (value) {
            setState(() {
              if (value != null) {
                rememberMe = value;
              }
            });
          },
        ),
        Text('Remember me', style: smallBlackText),
        const SizedBox(width: 20),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            getSupaAuthManager(ref).resetPassword(
              emailTextController.text,
              'com.mastertechsoftware.notemaster://login-callback',
            );
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email Sent')));
          },
          child: Text('Forgot password?', style: smallBlueText),
        ),
      ],
    );
  }

  Widget createLoginButtonRow() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: lightBlueColor,
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                elevation: 0,
                shape: createWhiteRoundedBorder(),
              ),
              onPressed: () async {
                if (emailTextController.text.isNotEmpty && passwordTextController.text.isNotEmpty) {
                  final loggedIn = await login(
                    emailTextController.text,
                    passwordTextController.text,
                  );
                  if (loggedIn) {
                    widget.onResult(loggedIn);
                  }
                }
              },
              child: const Text('Login'),
            ),
          ),
        ),
      ],
    );
  }

  Widget createAnAccountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Not registered yet?', style: smallBlackText),
        TextButton(
          onPressed: () {
            setState(() {
              useLoginScreen = false;
            });
          },
          child: Text('Create an account', style: smallBlueText),
        ),
      ],
    );
  }

  Widget createLoginLabel() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 10.0, bottom: 32.0),
      child: Text('Login', style: titleBlackText),
    );
  }

  Future<bool> login(String email, String password) async {
    final response = await getSupaAuthManager(ref).login(email, password);
    switch (response) {
      case Success():
        return true;
      case Failure(error: final error):
        logError(error.toString());
      case ErrorMessage(message: final message, code: _):
        logError(message!);
        if (!mounted) return false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 3),
          ));
        });
    }

    return false;
  }
}
