import 'package:flutter/material.dart';

class TextTile extends FormField<String> {
  TextTile({
    @required Icon icon,
    @required String label,
    @required String hint,
    @required FormFieldSetter<String> onSaved,
    @required FormFieldValidator<String> validator,
    @required String initialValue,
    TextInputType inputType = TextInputType.text,
    double trailingWidth = 120,
    bool autoValidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autoValidate,
          builder: (FormFieldState<String> state) {
            return ListTile(
              leading: icon,
              title: Text(label),
              trailing: Container(
                width: trailingWidth,
                child: Container(
                  width: trailingWidth,
                  child: TextFormField(
                    keyboardType: inputType,
                    initialValue: initialValue,
                    onChanged: (s) => state.didChange(s),
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: hint,
                    ),
                  ),
                ),
              ),
              subtitle: state.hasError ? _ErrorText(state.errorText) : null,
            );
          },
        );
}

class _ErrorText extends StatelessWidget {
  const _ErrorText(this.errorText, {Key key}) : super(key: key);
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      style: Theme.of(context).textTheme.caption.copyWith(color: Colors.red),
    );
  }
}
