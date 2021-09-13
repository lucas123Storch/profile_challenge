import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:profile_challenge/blocs/authentication/authentication_bloc.dart';
import 'package:profile_challenge/blocs/authentication/authentication_event.dart';
import 'package:profile_challenge/blocs/authentication/authentication_state.dart';
import 'package:profile_challenge/blocs/user/user_bloc.dart';
import 'package:profile_challenge/components/rounded_button.component.dart';
import 'package:profile_challenge/components/rounded_input_field.component.dart';
import 'package:profile_challenge/components/rounded_password_field.component.dart';
import 'package:profile_challenge/models/user.dart';
import 'package:profile_challenge/models/user_to_create_or_update.dart';
import 'package:profile_challenge/views/login.view.dart';
import 'package:profile_challenge/views/profile.view.dart';

enum ImageSourceType { gallery, camera }

class RegisterView extends StatefulWidget {
  final User user;
  const RegisterView({Key? key, required this.user}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telController = TextEditingController();
  final _civilStatusController = TextEditingController();
  final _genderController = TextEditingController();

  late User userCoplete;

  var maskTel = new MaskTextInputFormatter(mask: '(##) #####-####');
  var maskCPF = new MaskTextInputFormatter(mask: '###.###.###-##');
  var maskNull = new MaskTextInputFormatter();
  late File fileData;
  String base64Image = '';
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _userBloc = BlocProvider.of<UserBloc>(context);
    final ImagePicker _picker = ImagePicker();
    void _showError(String error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }

    void _showSuccess(String error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Colors.green,
      ));
    }

    if (widget.user.email != null) {
      _emailController.text =
          widget.user.email != null ? widget.user.email! : "";
      _nameController.text = widget.user.name != null ? widget.user.name! : "";
      _cpfController.text = widget.user.cpf != null ? widget.user.cpf! : "";
      _telController.text = widget.user.phone != null ? widget.user.phone! : "";
      _civilStatusController.text =
          widget.user.marital_status != null ? widget.user.marital_status! : "";
      _genderController.text =
          widget.user.gender != null ? widget.user.gender! : "";
      edit = true;
    }

    _getFromGallery() async {
      final XFile? image =
          await _picker.pickImage(source: ImageSource.gallery).then((value) {
        List<int> imageBytes = fileData.readAsBytesSync();
        print(imageBytes);
        base64Image = base64Encode(imageBytes);
      });
      print(image);
    }

    _onEditButtonPressed() {
      if (_emailController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _cpfController.text.isNotEmpty &&
          _telController.text.isNotEmpty &&
          _civilStatusController.text.isNotEmpty &&
          _genderController.text.isNotEmpty) {
        var user = new UserToCreateOrUpdate(
            id: widget.user.id!,
            name: _nameController.text,
            cpf: _cpfController.text,
            email: _emailController.text,
            gender: _genderController.text,
            maritalStatus: _civilStatusController.text,
            phone: _telController.text,
            avatar: base64Image,
            password: _passwordController.text,
            passwordConfirmation: _passwordController.text,
            device_name: 'mobile_app');
        _userBloc.add(
          UpdateUserEvent(user: user, token: ''),
        );

        // edit = false;
      } else {
        var message = _emailController.text.isEmpty
            ? 'Informe seu email'
            : _nameController.text.isEmpty
                ? 'Informe seu nome'
                : _cpfController.text.isEmpty
                    ? 'Informe seu CPF'
                    : _genderController.text.isEmpty
                        ? 'Informe seu gênero'
                        : _civilStatusController.text.isEmpty
                            ? 'Informe seu Estado Civil'
                            : _telController.text.isEmpty
                                ? 'Informe seu telefone'
                                : edit == false
                                    ? _passwordController.text.isEmpty
                                        ? 'Informe uma senha'
                                        : 'Os campos precisam estar todos preenchidos'
                                    : "";
        _showError(message);
      }
    }

    _onRegisterButtonPressed() {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _cpfController.text.isNotEmpty &&
          _telController.text.isNotEmpty &&
          _civilStatusController.text.isNotEmpty &&
          _genderController.text.isNotEmpty) {
        var user = new UserToCreateOrUpdate(
            name: _nameController.text,
            cpf: _cpfController.text,
            email: _emailController.text,
            gender: _genderController.text,
            maritalStatus: _civilStatusController.text,
            phone: _telController.text,
            avatar: base64Image,
            password: _passwordController.text,
            passwordConfirmation: _passwordController.text,
            device_name: 'mobile_app',
            id: null);
        _authBloc.add(
          RegisterEvent(user: user),
        );
      } else {
        var message = _emailController.text.isEmpty
            ? 'Informe seu email'
            : _nameController.text.isEmpty
                ? 'Informe seu nome'
                : _cpfController.text.isEmpty
                    ? 'Informe seu CPF'
                    : _genderController.text.isEmpty
                        ? 'Informe seu gênero'
                        : _civilStatusController.text.isEmpty
                            ? 'Informe seu Estado Civil'
                            : _telController.text.isEmpty
                                ? 'Informe seu telefone'
                                : edit == false
                                    ? _passwordController.text.isEmpty
                                        ? 'Informe uma senha'
                                        : 'Os campos precisam estar todos preenchidos'
                                    : "";
        _authBloc.add(
          AuthenticationFailed(message: message),
        );
        _showError(message);
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.09),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  "Selecionar Imagem",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _getFromGallery();
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                controller: _nameController,
                mask: maskNull,
                hintText: "Nome",
                onChanged: (value) {
                  _nameController.text = value;
                  _nameController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _nameController.text.length),
                  );
                },
              ),
              RoundedInputField(
                mask: maskCPF,
                controller: _cpfController,
                hintText: "CPF",
                onChanged: (value) {
                  _cpfController.text = value;
                  _cpfController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _cpfController.text.length),
                  );
                },
              ),
              RoundedInputField(
                mask: maskNull,
                controller: _emailController,
                hintText: "Email",
                onChanged: (value) {
                  _emailController.text = value;
                  _emailController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _emailController.text.length),
                  );
                },
              ),
              RoundedInputField(
                mask: maskTel,
                hintText: "Telefone",
                controller: _telController,
                onChanged: (value) {
                  _telController.text = value;
                  _telController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _telController.text.length),
                  );
                },
              ),
              RoundedInputField(
                mask: maskNull,
                controller: _civilStatusController,
                hintText: "Estado Civil",
                onChanged: (value) {
                  _civilStatusController.text = value;
                  _civilStatusController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _civilStatusController.text.length),
                  );
                },
              ),
              RoundedInputField(
                controller: _genderController,
                mask: maskNull,
                hintText: "Sexo",
                onChanged: (value) {
                  _genderController.text = value;
                  _genderController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _genderController.text.length),
                  );
                },
              ),
              edit == false
                  ? RoundedPasswordField(
                      onChanged: (value) {
                        _passwordController.text = value;
                        _passwordController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: _passwordController.text.length),
                        );
                      },
                    )
                  : Container(),
              SizedBox(height: size.height * 0.03),
              edit == false
                  ? BlocConsumer(
                      listener: (previous, current) {
                        if (current is AuthenticationAuthenticated) {
                          current.user.avatar = base64Image;
                          current.user.cpf = _cpfController.text;
                          current.user.email = _emailController.text;
                          current.user.gender = _genderController.text;
                          current.user.marital_status = _civilStatusController.text;
                          current.user.name = _nameController.text;
                          current.user.phone = _telController.text;

                          print(current.user);
                        } else if (current is AuthenticationFailure) {
                          _showError(current.message);
                        }
                      },
                      bloc: _authBloc,
                      builder: (context, state) {
                        if (state is AuthenticationLoading) {
                          return CircularProgressIndicator();
                        } else if (state is! AuthenticationFailure) {
                          return GestureDetector(
                            onTap: () => _onRegisterButtonPressed(),
                            child: RoundedButton(
                              text: "Cadastrar",
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () => _onRegisterButtonPressed(),
                            child: RoundedButton(
                              text: "Cadastrar",
                            ),
                          );
                        }
                      })
                  : BlocConsumer(
                      listener: (previous, current) {
                        if (current is UserUpdated) {
                          _showSuccess("Editado com sucesso");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProfileView(user: current.user);
                              },
                            ),
                          );
                        }
                      },
                      bloc: _userBloc,
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () => _onEditButtonPressed(),
                          child: RoundedButton(
                            text: "Salvar",
                          ),
                        );
                      }),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top2.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom2.png",
              width: size.width * 0.4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
