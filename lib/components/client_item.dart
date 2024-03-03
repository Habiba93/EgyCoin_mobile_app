import 'package:egycoin_mobile_app/shared/cubit.dart';
import 'package:egycoin_mobile_app/shared/widgets.dart';
import 'package:flutter/material.dart';

class ClientItem extends StatelessWidget {
  late final int index;

  ClientItem({required this.index});

  @override
  Widget build(BuildContext context) {
    var cubit = MyCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          child: Row(
            children: [
              Container(
                color: Color(0xffff6659),
                height: 70,
                width: 70,
                child: Center(
                    child: Text(
                  '${cubit.clientsList[index]['id']}',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      clientDataText(
                          label: 'Name: ', size: 18, weight: FontWeight.bold),
                      SizedBox(
                        width: 2,
                      ),
                      clientDataText(
                          label: '${cubit.clientsList[index]['name']}',
                          size: 18),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      clientDataText(
                          label: 'Email: ', size: 18, weight: FontWeight.bold),
                      SizedBox(
                        width: 5,
                      ),
                      clientDataText(
                          label: '${cubit.clientsList[index]['mail']}',
                          size: 18),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      clientDataText(
                        label: 'Balance: ',
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      clientDataText(
                        label: '${cubit.clientsList[index]['Balance']}',
                        size: 18,
                        myColor: Color(0xff00600f),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: () {
          MyCubit.get(context).changeScreen(2);
          MyCubit.get(context).changeSelectedClientIndex(index);
        },
      ),
    );
  }
}