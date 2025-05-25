import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/service/firebase_auth_service.dart';
import 'package:test/features/auth/data/mapper/user_mapper.dart';
import 'package:test/features/auth/data/repository/auth_repo_imp.dart';
import 'package:test/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:test/features/home/presentation/view/hoen_screen.dart';
import 'package:test/main.dart';
import 'package:test/ui_components/app_button.dart';
import 'package:test/ui_components/custom_text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              LoginCubit(AuthRepoImp(FirebaseAuthService(), UserMapper())),
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade200,
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue.shade200,
        ),
        body: const Layout(),
      ),
    );
  }
}

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          log("Success");
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Success")));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(user: state.userEntity),
            ),
          );
        }
        if (state is LoginFailure) {
          log(state.message);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return LoginViewBody(state: state);
      },
    );
  }
}

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key, required this.state});
  final LoginState state;
  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late String email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            onSaved: (value) {
              email = value!;
            },
            labelText: "Email",
            prefixicon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomTextFormField(
            onSaved: (value) {
              password = value!;
            },
            labelText: "Password",
            prefixicon: Icons.lock,
            suffixicon: Icons.visibility,
          ),
          widget.state is LoginLoading
              ? const CircularProgressIndicator()
              : Container(),
          SizedBox(height: 40),
          AppButton(
            backgroundColor: Colors.black87,
            text: "Login",
            onTap: () {
              setState(() {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.read<LoginCubit>().login(email, password);
                } else {
                  _autovalidateMode = AutovalidateMode.always;
                }
              });
              log(email);
            },
          ),
        ],
      ),
    );
  }
}
