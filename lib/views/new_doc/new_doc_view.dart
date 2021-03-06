// @dart=2.9
import 'dart:io';

import 'package:frappe_app/model/common.dart';
import 'package:frappe_app/utils/frappe_alert.dart';
import 'package:frappe_app/utils/helpers.dart';
import 'package:frappe_app/views/base_view.dart';
import 'package:frappe_app/views/new_doc/new_doc_viewmodel.dart';
import 'package:frappe_app/widgets/header_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../model/doctype_response.dart';

import '../../utils/enums.dart';

import '../../widgets/custom_form.dart';
import '../../widgets/frappe_button.dart';

class NewDoc extends StatefulWidget {
  final DoctypeResponse meta;

  const NewDoc({
    @required this.meta,
  });

  @override
  _NewDocState createState() => _NewDocState();
}

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

class _NewDocState extends State<NewDoc> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ConnectivityStatus>(
      context,
    );

    return BaseView<NewDocViewModel>(
      builder: (context, model, child) => Builder(
        builder: (context) {
          return Scaffold(
            appBar: buildAppBar(
              title: "New ${widget.meta.docs[0].name}",
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 4,
                  ),
                  child: FrappeFlatButton(
                      buttonType: ButtonType.primary,
                      title: 'Save',
                      onPressed: () async {
                        if (_fbKey.currentState.saveAndValidate()) {
                          var formValue = _fbKey.currentState.value;

                          try {
                            await model.saveDoc(
                              formValue: formValue,
                              meta: widget.meta,
                              context: context,
                            );
                          } catch (e) {
                            var _e = e as ErrorResponse;

                            if (_e.statusCode ==
                                HttpStatus.serviceUnavailable) {
                              noInternetAlert(
                                context,
                              );
                            } else {
                              FrappeAlert.errorAlert(
                                title: _e.statusMessage,
                                context: context,
                              );
                            }
                          }
                        }
                      }),
                ),
              ],
            ),
            body: CustomForm(
              formKey: _fbKey,
              fields: widget.meta.docs[0].fields,
              viewType: ViewType.newForm,
            ),
          );
        },
      ),
    );
  }
}
