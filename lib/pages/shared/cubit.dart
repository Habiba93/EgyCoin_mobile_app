import 'package:egycoin_mobile_app/model/client_model.dart';
import 'package:egycoin_mobile_app/model/transfer_model.dart';
import 'package:egycoin_mobile_app/pages/transfer_money.dart';
// import 'package:bank_app/screens/all_clients/allClientsScreen.dart';
// import 'package:bank_app/screens/client_account/clientAccountScreen.dart';
import 'package:egycoin_mobile_app/shared/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class MyCubit extends Cubit<States> {
  MyCubit() : super(InitialState());

  static MyCubit get(context) => BlocProvider.of(context);

  List<Widget> myScreens = [
    // ClientsScreen(),
    TransferMoneyScreen(),
    // ClientAccountScreen(),
  ];

  List<String> screenTitles = ['All clients', 'Transfers history', 'Transfer'];

  int selectedScreenIndex = 0;

  void changeScreen(int newIndex) {
    selectedScreenIndex = newIndex;
    emit(ChangeScreenState());
  }

  late var dataBase;
  late var dataBase2;
  List<Map> clientsList = [];
  List<Map> transfersList = [];

  void createDataBase() async {
    dataBase = await openDatabase(
      'bankAppData.db',
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE clients (id INTEGER PRIMARY KEY, name TEXT, mail TEXT, Balance INTEGER)');
      },
      onOpen: (db) async {
        dataBase = db;
        await selectDataBase();
      },
      version: 1,
    );
  }

  void createDataBase2() async {
    dataBase2 = await openDatabase(
      'bankAppDataTransfers.db',
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE transferss (id INTEGER PRIMARY KEY, sender INTEGER, receiver INTEGER, value INTEGER)');
      },
      onOpen: (db) async {
        dataBase2 = db;
        await selectDataBase2();
      },
      version: 1,
    );
  }

  void insertDataBase(ClientModel client) async {
    await dataBase.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO clients (name, mail, Balance) VALUES( "${client.name}", "${client.mail}", ${client.balance})');
    });
  }

  void insertDataBase2(TransferModel transfer) async {
    await dataBase2.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO transferss (sender, receiver, value) VALUES( ${transfer.from}, ${transfer.to}, ${transfer.value})');
    });
  }

  Future<void> selectDataBase() async {
    clientsList = await dataBase.rawQuery('SELECT * FROM clients');
    emit(SelectDataState());
  }

  Future<void> selectDataBase2() async {
    transfersList = await dataBase2.rawQuery('SELECT * FROM transferss');
    transfersList = transfersList.reversed.toList();
    emit(SelectTransfersState());
  }

  int selectedClientIndex = 0;

  void changeSelectedClientIndex(int newIndex) {
    selectedClientIndex = newIndex;
  }

  Future<void> updateDataBase(int from, int to, int value) async {
    int senderBalance = clientsList[from - 1]['Balance'];
    int receiverBalance = clientsList[to - 1]['Balance'];
    senderBalance -= value;
    receiverBalance += value;
    await dataBase.rawUpdate('UPDATE clients SET Balance = ? WHERE id = ?',
        ['$senderBalance', '$from']);
    await dataBase.rawUpdate('UPDATE clients SET Balance = ? WHERE id = ?',
        ['$receiverBalance', '$to']);
    selectDataBase();
    changeScreen(0);
    print('updated');
  }

  void fillData() {
    insertDataBase(
      ClientModel(
        name: 'Mahmoud Khalid',
        mail: 'mahmoudkhalid@gmail.com',
        balance: 200000,
      ),
    );
    insertDataBase(
      ClientModel(
        name: 'Ahmed Ashraf',
        mail: 'ahmed@gmail.com',
        balance: 210000,
      ),
    );
    insertDataBase(
      ClientModel(
        name: 'Mahmoud Mashaal',
        mail: 'mashaal@gmail.com',
        balance: 150000,
      ),
    );
    insertDataBase(
      ClientModel(
        name: 'Youssef Mostafa',
        mail: 'youssef@gmail.com',
        balance: 270000,
      ),
    );
    insertDataBase(
      ClientModel(
        name: 'Ali Shanawany',
        mail: 'ali@gmail.com',
        balance: 160000,
      ),
    );
    insertDataBase(
      ClientModel(
        name: 'Ahmed Khalid',
        mail: 'ahmeddkhalid@gmail.com',
        balance: 170000,
      ),
    );
    insertDataBase(
      ClientModel(
        name: 'Sara Reda',
        mail: 'sara@gmail.com',
        balance: 300000,
      ),
    );
    insertDataBase(
      ClientModel(
        name: 'Hani',
        mail: 'hani@gmail.com',
        balance: 110000,
      ),
    );
    insertDataBase(
      ClientModel(
        name: 'Waleed',
        mail: 'waleed@gmail.com',
        balance: 80000,
      ),
    );
    insertDataBase(
      ClientModel(
        name: 'Mohamed',
        mail: 'mohamed@gmail.com',
        balance: 140000,
      ),
    );
    selectDataBase();
    emit(SelectDataState());
  }
}
