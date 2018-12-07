import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wan_flutter/common/CommonValue.dart';
import 'package:wan_flutter/common/PreferenceUtils.dart';
import 'package:wan_flutter/common/Router.dart';
import 'package:wan_flutter/common/SnackBarUtils.dart';
import 'package:wan_flutter/data/UserManager.dart';
import 'package:wan_flutter/data/bean/LgBean.dart';
import 'package:wan_flutter/model/DioUtils.dart';

const loginUrl = 'user/login'; //post
const registerUrl = 'user/register'; //post
const logoutUrl = 'user/logout/json'; //get

const loginTitle = 'Login';
const registerTitle = 'Register';

class LgRgPage extends StatefulWidget {
  LgRgPage({Key key, this.lgOrRg = true}) : super(key: key);

  bool lgOrRg;

  @override
  State<StatefulWidget> createState() => LgRgPageState();
}

class LgRgPageState extends State<LgRgPage> {
  //default page is login

  PersonData person = new PersonData();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.lgOrRg ? loginTitle : registerTitle),
        actions: <Widget>[
          new FlatButton(
              onPressed: _handleCheckPage,
              child: new Text(
                widget.lgOrRg ? registerTitle : loginTitle,
                style: TextStyle(fontSize: ts14, color: Colors.white),
              ))
        ],
      ),
      body: new Container(
        padding: EdgeInsets.only(left: d20, right: d20, bottom: d50),
        child: new Center(
          child: _buildLoginWidget(),
        ),
      ),
    );
  }

  Widget _buildLoginWidget() {
    return new Form(
      key: _formKey,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 24.0),
          new TextFormField(
            textCapitalization: TextCapitalization.words,
            validator: _validatorName,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              prefixIcon: Icon(Icons.person),
              hintText: 'Input your name',
              labelText: 'Name *',
            ),
            onSaved: (String value) {
              person.name = value;
            },
          ),
          const SizedBox(height: 24.0),
          new PasswordField(
            fieldKey: _passwordFieldKey,
            helperText: '',
            hintText: 'Input your password',
            labelText: 'Password *',
            validator: _validatorPassword,
            onSaved: (String value) {
              person.password = value;
            },
            onFieldSubmitted: (String value) {
              person.password = value;
            },
          ),
          const SizedBox(height: 24.0),
          new RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: const Text('SUBMIT'),
            onPressed: _handleSubmitted,
          ),
        ],
      ),
    );
  }

  void _handleCheckPage() {
    setState(() {
      widget.lgOrRg = !widget.lgOrRg;
    });
  }

  _handleSubmitted() async {
    final FormState formState = _formKey.currentState;
    if (!formState.validate()) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text("Please fix the errors in red before submitting")));
      return;
    }
    formState.save();
    Map<String, dynamic> json = await DioUtils.getInstance().post(
        widget.lgOrRg ? loginUrl : registerUrl,
        data: widget.lgOrRg
            ? {'username': person.name, 'password': person.password}
            : {
                'username': person.name,
                'password': person.password,
                'repassword': person.password
              },
        options: new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
        ));
    LgBean lgBean = LgBean.fromJson(json);
    if (lgBean.errorCode == 0) {
      //登录成功 保存信息用于更新token
      UserManager().username = lgBean.data.username;
      UserManager().userPass = lgBean.data.password;
      PreferenceUtils.putStr(USER_NAME, lgBean.data.username);
      PreferenceUtils.putStr(USER_PASSWORD, lgBean.data.password);
      PreferenceUtils.putStr(LAST_SAVE_TIME, DateTime.now().toIso8601String());
    } else {
      SnackBarUtils.show(context, lgBean.errorMsg);
    }

    _close();
  }

  String _validatorName(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username.';
    }
    return null;
  }

  String _validatorPassword(String value) {
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty) {
      return 'Please enter a password.';
    }
    return null;
  }

  _close() {
    Router.finish(context);
  }
}

class PersonData {
  String name = '';
  String email = '';
  String password = '';
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        prefixIcon: Icon(Icons.input),
        hintText: widget.hintText,
        labelText: widget.labelText,
//        helperText: widget.helperText,
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child:
              new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
