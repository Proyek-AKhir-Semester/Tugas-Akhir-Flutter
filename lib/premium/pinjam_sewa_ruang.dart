import 'package:flutter/material.dart';

class PinjamSewaRuangScreen extends StatelessWidget {
  const PinjamSewaRuangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFF0A3),
      appBar: AppBar(
        backgroundColor: Color(0XFFAA5200),
        title: Text(
          "Pinjam & Sewa Ruang",
          style: TextStyle(color: Color(0XFFFFF0A3), fontSize: 20),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 53,
        color: Color(0XFFAA5200),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        // width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            width: 328,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(20),
                  height: 147,
                  decoration: BoxDecoration(
                    color: Color(0XFFFFD336),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pinjam Buku",
                        style: TextStyle(
                          color: Color(0XFFAA5200),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Premium",
                        style: TextStyle(
                          color: Color(0XFFAA5200),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Container(
                                height: 33,
                                width: 112,
                                decoration: BoxDecoration(
                                  color: Color(0XFFFFC736),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text(
                                  "1 Minggu",
                                  style: TextStyle(color: Color(0XFF4D1212)),
                                )),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Container(
                                height: 33,
                                width: 112,
                                decoration: BoxDecoration(
                                  color: Color(0XFFFFC736),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text(
                                  "2 Minggu",
                                  style: TextStyle(color: Color(0XFF4D1212)),
                                )),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(20),
                  height: 147,
                  decoration: BoxDecoration(
                    color: Color(0XFFFFD336),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sewa Ruang",
                        style: TextStyle(
                          color: Color(0XFFAA5200),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Premium",
                        style: TextStyle(
                          color: Color(0XFFAA5200),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Container(
                                height: 33,
                                width: 112,
                                decoration: BoxDecoration(
                                  color: Color(0XFFFFC736),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text(
                                  "1 Jam",
                                  style: TextStyle(color: Color(0XFF4D1212)),
                                )),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Container(
                                height: 33,
                                width: 112,
                                decoration: BoxDecoration(
                                  color: Color(0XFFFFC736),
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text(
                                  "2 Jam",
                                  style: TextStyle(color: Color(0XFF4D1212)),
                                )),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 33,
                          width: 112,
                          decoration: BoxDecoration(
                            color: Color(0XFFFFC736),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            "kembali",
                            style: TextStyle(color: Color(0XFF4D1212)),
                          )),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Container(
                          height: 33,
                          width: 112,
                          decoration: BoxDecoration(
                            color: Color(0XFFFFC736),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            "pesan",
                            style: TextStyle(color: Color(0XFF4D1212)),
                          )),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
