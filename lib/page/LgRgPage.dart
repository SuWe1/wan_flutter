import 'package:flutter/material.dart';
import 'package:wan_flutter/common/ColorValue.dart';
import 'package:shared_preferences/shared_preferences.dart';

const loginUrl = 'user/login'; //post
const registerUrl = 'user/register'; //post
const logoutUrl = 'user/logout/json'; //get

const loginTitle = 'Login';
const registerTitle = 'Register';

class LgRgPage extends StatefulWidget {

  LgRgPage({Key key, this.lgOrRg = false}) : super(key: key);

  bool lgOrRg;

  @override
  State<StatefulWidget> createState() => LgRgPageState();
}

class LgRgPageState extends State<LgRgPage> {
  //default page is login

  PersonData person = new PersonData();

  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
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
        padding: EdgeInsets.only(left: d20, right: d20, bottom: d80),
        child: new Center(
          child: _buildLoginWidget(),
        ),
      ),
    );
  }

  Widget _buildLoginWidget() {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 24.0),
        new TextFormField(
          textCapitalization: TextCapitalization.words,
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
    );
  }

  void _handleCheckPage() {
    setState(() {
      widget.lgOrRg = !widget.lgOrRg;
    });
  }

  _handleSubmitted() async {}
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
