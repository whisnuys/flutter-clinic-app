import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinic_app/core/core.dart';

import '../../../core/components/components.dart';
import '../../home/pages/dashboard_page.dart';
import '../bloc/login/login_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            // LEFT CONTENT
            Expanded(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SpaceHeight(80.0),
                      const Center(
                        child: Text(
                          'Masuk Staff',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SpaceHeight(30.0),
                      CustomTextField(
                        controller: emailController,
                        label: 'Nomor Ponsel atau Email',
                      ),
                      const SpaceHeight(20.0),
                      CustomTextField(
                        controller: passwordController,
                        label: 'Kata Sandi',
                      ),
                      const SpaceHeight(40.0),
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          state.maybeWhen(
                              success: (data) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DashboardPage(),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login Berhasil'),
                                    backgroundColor: AppColors.green,
                                  ),
                                );
                              },
                              error: (message) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    backgroundColor: AppColors.red,
                                  ),
                                );
                              },
                              orElse: () {});
                        },
                        builder: (context, state) {
                          state.maybeWhen(
                            orElse: () {
                              return Button.filled(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardPage(),
                                    ),
                                  );
                                },
                                label: 'MASUK',
                              );
                            },
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          return Button.filled(
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                    LoginEvent.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                            },
                            label: 'MASUK',
                          );
                        },
                      ),
                      const SpaceHeight(20.0),
                      const SpaceHeight(100.0),
                      const Text(
                        '© 2024 | WATUMAS CLINIC',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // RIGHT CONTENT
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: context.deviceWidth,
                  height: context.deviceHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Assets.images.splashScreen.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 67.0, right: 15.0, left: 120.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Embark on efficiency with a single click, discover the seamless world of clinic management!',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        const SpaceHeight(50.0),
                        Flexible(child: Assets.images.dokterku.image()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
