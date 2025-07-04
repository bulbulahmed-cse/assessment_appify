import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/utils/app_colors.dart';
import 'package:appifylab_assessment/widgets/default_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../gen/assets.gen.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginBloc()..add(InitEvent()),
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, LoginState state) {
    final bloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: Container(
        color: AppColor.primary,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child:
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey
                      )
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Assets.banner.svg()
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  border: Border.all(color: Colors.grey),
                  color: Colors.black.withOpacity(0.1)
                ),
                child: Form(
                  key: bloc.formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Sign In',
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                            fontSize: 38,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(height: 16,),
                        DefaultTextfield(
                          controller: bloc.email,
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(height: 16,),
                        DefaultTextfield(
                          controller: bloc.password,
                          label: 'Password',
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: appTheme(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 16,),
                        ElevatedButton(
                          onPressed: ()=> bloc.add(DoLogin()),
                          child: Center(
                            child: Text(
                              "Log In",
                              style: appTheme(context).textTheme.headlineLarge,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12)
                          ),
                        ),
                        SizedBox(height: 32,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

