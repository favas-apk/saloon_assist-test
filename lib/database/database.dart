/* import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:saloon_assist/database/tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [ChairLocal, ProductLocal, ServiceLocal])
class AppDB extends _$AppDB {
  AppDB() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future<List<ChairLocalData>> getchairTable() async {
    return await select(chairLocal).get();
  }

  Future<List<ProductLocalData>> getAllProducts() async {
    return await select(productLocal).get();
  }

  Future<List<ServiceLocalData>> getAllServices() async {
    return await select(serviceLocal).get();
  }

  Future addNewChair(ChairLocalCompanion chairLocalCompanion) async {
    return await into(chairLocal)
        .insert(chairLocalCompanion)
        .then((value) => print(chairLocal.isInWork));
  }

  Future addNewService(ServiceLocalCompanion serviceLocalCompanion) async {
    return await into(serviceLocal)
        .insert(serviceLocalCompanion)
        .then((value) => print(serviceLocal.serviceName));
  }

  Future addLocalProduct(ProductLocalCompanion productLocalCompanion) async {
    return await into(productLocal).insert(productLocalCompanion);
  }

  Future updateChair(int chairid, ChairLocalCompanion newData) async {
    return update(chairLocal)
      ..where((tbl) => tbl.chairsid.equals(chairid))
      ..write(newData);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'coredddw.sqlite'));
    return NativeDatabase(file);
  });
}
 */