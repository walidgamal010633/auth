part of '../register_screen.dart';

class Register_view extends StatefulWidget {
  final RegisterState state;
  const Register_view({super.key, required this.state});

  @override
  State<Register_view> createState() => _Register_viewState();
}

class _Register_viewState extends State<Register_view> {
  late String name, email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              onSaved: (value) {
                name = value!;
              },
              prefixicon: Icons.person,
              labelText: "Name",
            ),
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
            SizedBox(height: 40),

            widget.state is RegisterLoading
                ? CircularProgressIndicator()
                : Container(),
            AppButton(
              text: "Register",
              onTap: () {
                setState(() {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<RegisterCubit>().register(
                      email,
                      password,
                      name,
                    );
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
