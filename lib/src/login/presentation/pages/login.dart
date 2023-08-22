import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_flutter_challenge/core/routes/route_names.dart';
import 'package:fudo_flutter_challenge/src/common/presentation/widgets/primary_button.dart';
import 'package:fudo_flutter_challenge/src/login/presentation/bloc/login_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _usernameController;

  late final TextEditingController _passwordController;

  late final GlobalKey<FormState> _usernameKey;

  late final GlobalKey<FormState> _passwordKey;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameKey = GlobalKey<FormState>();
    _passwordKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is Initialized && state.isAuthenticated) {
            Navigator.of(context).pushNamed(RouteNames.home);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola!\nIngresá a tu cuenta',
                  style: textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _usernameKey,
                  child: TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      prefixIcon: Icon(Icons.person),
                    ),
                    obscureText: false,
                    validator: (username) => _validateUsername(username),
                  ),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _passwordKey,
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                    obscureText: true,
                    validator: (pw) => _validatePassword(pw),
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Iniciar sesión',
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if ((_usernameKey.currentState?.validate() ?? false) &&
                        (_passwordKey.currentState?.validate() ?? false)) {
                      BlocProvider.of<LoginBloc>(context).add(
                        ValidateLogin(
                          user: _usernameController.text,
                          password: _passwordController.text,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? password) {
    if ((password ?? '').isNotEmpty) {
      return null;
    } else {
      return 'Ingresá tu contraseña';
    }
  }

  String? _validateUsername(String? username) {
    if ((username ?? '').isNotEmpty) {
      return null;
    } else {
      return 'Ingresá tu usuario';
    }
  }
}
