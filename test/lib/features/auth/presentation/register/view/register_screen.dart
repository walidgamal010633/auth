
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/service/firebase_auth_service.dart';
import 'package:test/features/auth/data/mapper/user_mapper.dart';
import 'package:test/features/auth/data/repository/auth_repo_imp.dart';
import 'package:test/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:test/ui_components/app_button.dart';
import 'package:test/ui_components/custom_text_field.dart';





part 'widgets/register_view.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:
          (context) =>
              RegisterCubit(AuthRepoImp(FirebaseAuthService(), UserMapper())),
      
    
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
          title: const Text("Register"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey.shade200,
        ),
        body: Layout(),
      ),
    );
  }
}

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          DialogState(
            context,
            "Success",
            "Registered Successfully",
            const Icon(Icons.check),
          );
        }
        if (state is RegisterFailure) {
          DialogState(context, "Error", state.message, const Icon(Icons.error));
        }
      },
      builder: (context, state) {
        return Register_view(state: state);
      },
    );
  }

  void DialogState(
    BuildContext context,
    String title,
    String content,
    Widget icon,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: icon,
          title: Text(title),
          content: Text(content, style: const TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

