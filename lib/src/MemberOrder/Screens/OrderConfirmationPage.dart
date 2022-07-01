// @dart=2.9
import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('ตรวจสอบและยืนยัน')),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Image(image: const AssetImage('assets/images/confirm.png'), width: 180),
            const SizedBox(height: 20),
            const Text(
              'กรุณาตรวจสอบข้อมูลให้เรียบร้อย',
              style: TextStyle(
                  color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: const Text(
                'หลังจากยืนยันการขอทำสำเนาแล้ว ระบบจะทำการส่งข้อมูลไปยังเจ้าหน้าทีที่เกี่ยวข้องและใช้เวลาในการดำเนินการอนุมัติภายใน 48 ชม',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal[800]),
              ),
              child: const Text(
                'ยืนยัน',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {},
            )
          ],
        ));
  }
}
