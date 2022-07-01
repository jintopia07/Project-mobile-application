// @dart=2.9
import 'package:flutter/material.dart';
import 'package:nat/constants.dart';
import 'package:test/expect.dart';

class UnApproveOrder extends StatefulWidget {
  const UnApproveOrder({Key key}) : super(key: key);

  @override
  _UnApproveOrderState createState() => _UnApproveOrderState();
}

class _UnApproveOrderState extends State<UnApproveOrder> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการที่รออนุมัติ'),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: defaultPadding,
                ),
                headerSection(),
                resonUnapproveSection(),
                const SizedBox(
                  height: defaultPadding * 1.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerSection() => Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: Text(
                      "ระบุเหตุผลในการไม่อนุมัติการขอทำสำเนา",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.brown[400],
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget resonUnapproveSection() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        alignment: FractionalOffset.topCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding * 1.5),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(),
                  ),
                  isDense: true, // Added this
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: (value) {
                  setState(() {});
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'กรุณากรอกเหตุผลในการพิจารณาไม่อนุมัติ';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.teal[600]),
              ),
              child: const Text(
                'ยืนยัน',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {}
                });
              },
            ),
            const SizedBox(
              height: defaultPadding * 1.5,
            ),
          ],
        ),
      );
}
