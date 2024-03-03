import 'package:egycoin_mobile_app/model/transfer_model.dart';
import 'package:egycoin_mobile_app/shared/cubit.dart';
import 'package:egycoin_mobile_app/shared/widgets.dart';
import 'package:flutter/material.dart';

class TransferItem extends StatelessWidget {
  final TransferModel transfer;

  TransferItem(this.transfer);

  @override
  Widget build(BuildContext context) {
    var cubit = MyCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 225,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      clientDataText(
                          label: 'From ',
                          size: 18,
                          weight: FontWeight.bold,
                          overFlow: TextOverflow.ellipsis),
                      SizedBox(
                        width: 2,
                      ),
                      clientDataText(
                          label:
                              '${transfer.from}: ${cubit.clientsList[transfer.from - 1]['name']}',
                          size: 18,
                          overFlow: TextOverflow.ellipsis,
                          myColor: Color(0xff9a0007)),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      clientDataText(
                        label: 'To ',
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      clientDataText(
                        label:
                            '${transfer.to}: ${cubit.clientsList[transfer.to - 1]['name']}',
                        size: 18,
                        overFlow: TextOverflow.ellipsis,
                        myColor: Color(0xff00600f),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  clientDataText(
                    label: 'Value: ',
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  clientDataText(
                    label: '${transfer.value}',
                    size: 18,
                    overFlow: TextOverflow.ellipsis,
                    myColor: Color(0xff140078),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}