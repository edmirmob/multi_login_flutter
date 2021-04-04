import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/home/models.dart/job.dart';
import 'package:multi_login_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:multi_login_flutter/services/database.dart';
import 'package:provider/provider.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key key, @required this.database}) : super(key: key);

  final DataBase database;

  static Future<void> show(BuildContext context) async {
    final databaseProvider = context.read<DataBase>();
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => AddJobPage(database: databaseProvider,), fullscreenDialog: true),
    );
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;
  bool validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit()async {
    if (validateAndSaveForm()) {
      try {
        
      } catch (e) {
        PlatformAlertDialog(
        title: 'Operation failed',
        content: e.toString(),
        defaultActionText: 'OK',
      ).show(context);
      }
      final job = Job(name: _name, ratePerHour: _ratePerHour);
      await widget.database.createJob(job);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('New Job'),
        actions: [
          TextButton(
            onPressed: _submit,
            child: Text('Save',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      
      TextFormField(
        decoration: InputDecoration(labelText: 'Job name'),
        validator: (value)=>value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Rate per hour'),
        onSaved: (value)=>_ratePerHour = int.tryParse(value),
        keyboardType: TextInputType.numberWithOptions(),
      ),
    ];
  }
}
