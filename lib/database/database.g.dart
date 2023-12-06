/* // GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ChairLocalTable extends ChairLocal
    with TableInfo<$ChairLocalTable, ChairLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChairLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _chairsidMeta =
      const VerificationMeta('chairsid');
  @override
  late final GeneratedColumn<int> chairsid = GeneratedColumn<int>(
      'chairsid', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _activeStaffMeta =
      const VerificationMeta('activeStaff');
  @override
  late final GeneratedColumn<String> activeStaff = GeneratedColumn<String>(
      'active_staff', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startedTimeMeta =
      const VerificationMeta('startedTime');
  @override
  late final GeneratedColumn<String> startedTime = GeneratedColumn<String>(
      'started_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isInWorkMeta =
      const VerificationMeta('isInWork');
  @override
  late final GeneratedColumn<bool> isInWork = GeneratedColumn<bool>(
      'is_in_work', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_in_work" IN (0, 1))'));
  static const VerificationMeta _currentStatusMeta =
      const VerificationMeta('currentStatus');
  @override
  late final GeneratedColumn<bool> currentStatus = GeneratedColumn<bool>(
      'current_status', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("current_status" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, chairsid, activeStaff, startedTime, isInWork, currentStatus];
  @override
  String get aliasedName => _alias ?? 'chair_local';
  @override
  String get actualTableName => 'chair_local';
  @override
  VerificationContext validateIntegrity(Insertable<ChairLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chairsid')) {
      context.handle(_chairsidMeta,
          chairsid.isAcceptableOrUnknown(data['chairsid']!, _chairsidMeta));
    } else if (isInserting) {
      context.missing(_chairsidMeta);
    }
    if (data.containsKey('active_staff')) {
      context.handle(
          _activeStaffMeta,
          activeStaff.isAcceptableOrUnknown(
              data['active_staff']!, _activeStaffMeta));
    }
    if (data.containsKey('started_time')) {
      context.handle(
          _startedTimeMeta,
          startedTime.isAcceptableOrUnknown(
              data['started_time']!, _startedTimeMeta));
    }
    if (data.containsKey('is_in_work')) {
      context.handle(_isInWorkMeta,
          isInWork.isAcceptableOrUnknown(data['is_in_work']!, _isInWorkMeta));
    } else if (isInserting) {
      context.missing(_isInWorkMeta);
    }
    if (data.containsKey('current_status')) {
      context.handle(
          _currentStatusMeta,
          currentStatus.isAcceptableOrUnknown(
              data['current_status']!, _currentStatusMeta));
    } else if (isInserting) {
      context.missing(_currentStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChairLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChairLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chairsid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chairsid'])!,
      activeStaff: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}active_staff']),
      startedTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}started_time']),
      isInWork: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_in_work'])!,
      currentStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}current_status'])!,
    );
  }

  @override
  $ChairLocalTable createAlias(String alias) {
    return $ChairLocalTable(attachedDatabase, alias);
  }
}

class ChairLocalData extends DataClass implements Insertable<ChairLocalData> {
  final int id;
  final int chairsid;
  final String? activeStaff;
  final String? startedTime;
  final bool isInWork;
  final bool currentStatus;
  const ChairLocalData(
      {required this.id,
      required this.chairsid,
      this.activeStaff,
      this.startedTime,
      required this.isInWork,
      required this.currentStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chairsid'] = Variable<int>(chairsid);
    if (!nullToAbsent || activeStaff != null) {
      map['active_staff'] = Variable<String>(activeStaff);
    }
    if (!nullToAbsent || startedTime != null) {
      map['started_time'] = Variable<String>(startedTime);
    }
    map['is_in_work'] = Variable<bool>(isInWork);
    map['current_status'] = Variable<bool>(currentStatus);
    return map;
  }

  ChairLocalCompanion toCompanion(bool nullToAbsent) {
    return ChairLocalCompanion(
      id: Value(id),
      chairsid: Value(chairsid),
      activeStaff: activeStaff == null && nullToAbsent
          ? const Value.absent()
          : Value(activeStaff),
      startedTime: startedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startedTime),
      isInWork: Value(isInWork),
      currentStatus: Value(currentStatus),
    );
  }

  factory ChairLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChairLocalData(
      id: serializer.fromJson<int>(json['id']),
      chairsid: serializer.fromJson<int>(json['chairsid']),
      activeStaff: serializer.fromJson<String?>(json['activeStaff']),
      startedTime: serializer.fromJson<String?>(json['startedTime']),
      isInWork: serializer.fromJson<bool>(json['isInWork']),
      currentStatus: serializer.fromJson<bool>(json['currentStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chairsid': serializer.toJson<int>(chairsid),
      'activeStaff': serializer.toJson<String?>(activeStaff),
      'startedTime': serializer.toJson<String?>(startedTime),
      'isInWork': serializer.toJson<bool>(isInWork),
      'currentStatus': serializer.toJson<bool>(currentStatus),
    };
  }

  ChairLocalData copyWith(
          {int? id,
          int? chairsid,
          Value<String?> activeStaff = const Value.absent(),
          Value<String?> startedTime = const Value.absent(),
          bool? isInWork,
          bool? currentStatus}) =>
      ChairLocalData(
        id: id ?? this.id,
        chairsid: chairsid ?? this.chairsid,
        activeStaff: activeStaff.present ? activeStaff.value : this.activeStaff,
        startedTime: startedTime.present ? startedTime.value : this.startedTime,
        isInWork: isInWork ?? this.isInWork,
        currentStatus: currentStatus ?? this.currentStatus,
      );
  @override
  String toString() {
    return (StringBuffer('ChairLocalData(')
          ..write('id: $id, ')
          ..write('chairsid: $chairsid, ')
          ..write('activeStaff: $activeStaff, ')
          ..write('startedTime: $startedTime, ')
          ..write('isInWork: $isInWork, ')
          ..write('currentStatus: $currentStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, chairsid, activeStaff, startedTime, isInWork, currentStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChairLocalData &&
          other.id == this.id &&
          other.chairsid == this.chairsid &&
          other.activeStaff == this.activeStaff &&
          other.startedTime == this.startedTime &&
          other.isInWork == this.isInWork &&
          other.currentStatus == this.currentStatus);
}

class ChairLocalCompanion extends UpdateCompanion<ChairLocalData> {
  final Value<int> id;
  final Value<int> chairsid;
  final Value<String?> activeStaff;
  final Value<String?> startedTime;
  final Value<bool> isInWork;
  final Value<bool> currentStatus;
  const ChairLocalCompanion({
    this.id = const Value.absent(),
    this.chairsid = const Value.absent(),
    this.activeStaff = const Value.absent(),
    this.startedTime = const Value.absent(),
    this.isInWork = const Value.absent(),
    this.currentStatus = const Value.absent(),
  });
  ChairLocalCompanion.insert({
    this.id = const Value.absent(),
    required int chairsid,
    this.activeStaff = const Value.absent(),
    this.startedTime = const Value.absent(),
    required bool isInWork,
    required bool currentStatus,
  })  : chairsid = Value(chairsid),
        isInWork = Value(isInWork),
        currentStatus = Value(currentStatus);
  static Insertable<ChairLocalData> custom({
    Expression<int>? id,
    Expression<int>? chairsid,
    Expression<String>? activeStaff,
    Expression<String>? startedTime,
    Expression<bool>? isInWork,
    Expression<bool>? currentStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chairsid != null) 'chairsid': chairsid,
      if (activeStaff != null) 'active_staff': activeStaff,
      if (startedTime != null) 'started_time': startedTime,
      if (isInWork != null) 'is_in_work': isInWork,
      if (currentStatus != null) 'current_status': currentStatus,
    });
  }

  ChairLocalCompanion copyWith(
      {Value<int>? id,
      Value<int>? chairsid,
      Value<String?>? activeStaff,
      Value<String?>? startedTime,
      Value<bool>? isInWork,
      Value<bool>? currentStatus}) {
    return ChairLocalCompanion(
      id: id ?? this.id,
      chairsid: chairsid ?? this.chairsid,
      activeStaff: activeStaff ?? this.activeStaff,
      startedTime: startedTime ?? this.startedTime,
      isInWork: isInWork ?? this.isInWork,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chairsid.present) {
      map['chairsid'] = Variable<int>(chairsid.value);
    }
    if (activeStaff.present) {
      map['active_staff'] = Variable<String>(activeStaff.value);
    }
    if (startedTime.present) {
      map['started_time'] = Variable<String>(startedTime.value);
    }
    if (isInWork.present) {
      map['is_in_work'] = Variable<bool>(isInWork.value);
    }
    if (currentStatus.present) {
      map['current_status'] = Variable<bool>(currentStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChairLocalCompanion(')
          ..write('id: $id, ')
          ..write('chairsid: $chairsid, ')
          ..write('activeStaff: $activeStaff, ')
          ..write('startedTime: $startedTime, ')
          ..write('isInWork: $isInWork, ')
          ..write('currentStatus: $currentStatus')
          ..write(')'))
        .toString();
  }
}

class $ProductLocalTable extends ProductLocal
    with TableInfo<$ProductLocalTable, ProductLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
      'product_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _productNameMeta =
      const VerificationMeta('productName');
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
      'product_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<String> rate = GeneratedColumn<String>(
      'rate', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<int> tax = GeneratedColumn<int>(
      'tax', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, productId, productName, category, rate, tax, details];
  @override
  String get aliasedName => _alias ?? 'product_local';
  @override
  String get actualTableName => 'product_local';
  @override
  VerificationContext validateIntegrity(Insertable<ProductLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
          _productNameMeta,
          productName.isAcceptableOrUnknown(
              data['product_name']!, _productNameMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('rate')) {
      context.handle(
          _rateMeta, rate.isAcceptableOrUnknown(data['rate']!, _rateMeta));
    }
    if (data.containsKey('tax')) {
      context.handle(
          _taxMeta, tax.isAcceptableOrUnknown(data['tax']!, _taxMeta));
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}product_id'])!,
      productName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_name']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      rate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rate']),
      tax: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tax']),
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details']),
    );
  }

  @override
  $ProductLocalTable createAlias(String alias) {
    return $ProductLocalTable(attachedDatabase, alias);
  }
}

class ProductLocalData extends DataClass
    implements Insertable<ProductLocalData> {
  final int id;
  final int productId;
  final String? productName;
  final String? category;
  final String? rate;
  final int? tax;
  final String? details;
  const ProductLocalData(
      {required this.id,
      required this.productId,
      this.productName,
      this.category,
      this.rate,
      this.tax,
      this.details});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    if (!nullToAbsent || productName != null) {
      map['product_name'] = Variable<String>(productName);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || rate != null) {
      map['rate'] = Variable<String>(rate);
    }
    if (!nullToAbsent || tax != null) {
      map['tax'] = Variable<int>(tax);
    }
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    return map;
  }

  ProductLocalCompanion toCompanion(bool nullToAbsent) {
    return ProductLocalCompanion(
      id: Value(id),
      productId: Value(productId),
      productName: productName == null && nullToAbsent
          ? const Value.absent()
          : Value(productName),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      rate: rate == null && nullToAbsent ? const Value.absent() : Value(rate),
      tax: tax == null && nullToAbsent ? const Value.absent() : Value(tax),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
    );
  }

  factory ProductLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductLocalData(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      productName: serializer.fromJson<String?>(json['productName']),
      category: serializer.fromJson<String?>(json['category']),
      rate: serializer.fromJson<String?>(json['rate']),
      tax: serializer.fromJson<int?>(json['tax']),
      details: serializer.fromJson<String?>(json['details']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'productName': serializer.toJson<String?>(productName),
      'category': serializer.toJson<String?>(category),
      'rate': serializer.toJson<String?>(rate),
      'tax': serializer.toJson<int?>(tax),
      'details': serializer.toJson<String?>(details),
    };
  }

  ProductLocalData copyWith(
          {int? id,
          int? productId,
          Value<String?> productName = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<String?> rate = const Value.absent(),
          Value<int?> tax = const Value.absent(),
          Value<String?> details = const Value.absent()}) =>
      ProductLocalData(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName.present ? productName.value : this.productName,
        category: category.present ? category.value : this.category,
        rate: rate.present ? rate.value : this.rate,
        tax: tax.present ? tax.value : this.tax,
        details: details.present ? details.value : this.details,
      );
  @override
  String toString() {
    return (StringBuffer('ProductLocalData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('category: $category, ')
          ..write('rate: $rate, ')
          ..write('tax: $tax, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, productName, category, rate, tax, details);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductLocalData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.category == this.category &&
          other.rate == this.rate &&
          other.tax == this.tax &&
          other.details == this.details);
}

class ProductLocalCompanion extends UpdateCompanion<ProductLocalData> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String?> productName;
  final Value<String?> category;
  final Value<String?> rate;
  final Value<int?> tax;
  final Value<String?> details;
  const ProductLocalCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.category = const Value.absent(),
    this.rate = const Value.absent(),
    this.tax = const Value.absent(),
    this.details = const Value.absent(),
  });
  ProductLocalCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    this.productName = const Value.absent(),
    this.category = const Value.absent(),
    this.rate = const Value.absent(),
    this.tax = const Value.absent(),
    this.details = const Value.absent(),
  }) : productId = Value(productId);
  static Insertable<ProductLocalData> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<String>? category,
    Expression<String>? rate,
    Expression<int>? tax,
    Expression<String>? details,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (category != null) 'category': category,
      if (rate != null) 'rate': rate,
      if (tax != null) 'tax': tax,
      if (details != null) 'details': details,
    });
  }

  ProductLocalCompanion copyWith(
      {Value<int>? id,
      Value<int>? productId,
      Value<String?>? productName,
      Value<String?>? category,
      Value<String?>? rate,
      Value<int?>? tax,
      Value<String?>? details}) {
    return ProductLocalCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      rate: rate ?? this.rate,
      tax: tax ?? this.tax,
      details: details ?? this.details,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rate.present) {
      map['rate'] = Variable<String>(rate.value);
    }
    if (tax.present) {
      map['tax'] = Variable<int>(tax.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductLocalCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('category: $category, ')
          ..write('rate: $rate, ')
          ..write('tax: $tax, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }
}

class $ServiceLocalTable extends ServiceLocal
    with TableInfo<$ServiceLocalTable, ServiceLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _serviceNameMeta =
      const VerificationMeta('serviceName');
  @override
  late final GeneratedColumn<String> serviceName = GeneratedColumn<String>(
      'service_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serviceChargeMeta =
      const VerificationMeta('serviceCharge');
  @override
  late final GeneratedColumn<String> serviceCharge = GeneratedColumn<String>(
      'service_charge', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, serviceName, serviceCharge];
  @override
  String get aliasedName => _alias ?? 'service_local';
  @override
  String get actualTableName => 'service_local';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceLocalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('service_name')) {
      context.handle(
          _serviceNameMeta,
          serviceName.isAcceptableOrUnknown(
              data['service_name']!, _serviceNameMeta));
    }
    if (data.containsKey('service_charge')) {
      context.handle(
          _serviceChargeMeta,
          serviceCharge.isAcceptableOrUnknown(
              data['service_charge']!, _serviceChargeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceLocalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      serviceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_name']),
      serviceCharge: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_charge']),
    );
  }

  @override
  $ServiceLocalTable createAlias(String alias) {
    return $ServiceLocalTable(attachedDatabase, alias);
  }
}

class ServiceLocalData extends DataClass
    implements Insertable<ServiceLocalData> {
  final int id;
  final String? serviceName;
  final String? serviceCharge;
  const ServiceLocalData(
      {required this.id, this.serviceName, this.serviceCharge});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serviceName != null) {
      map['service_name'] = Variable<String>(serviceName);
    }
    if (!nullToAbsent || serviceCharge != null) {
      map['service_charge'] = Variable<String>(serviceCharge);
    }
    return map;
  }

  ServiceLocalCompanion toCompanion(bool nullToAbsent) {
    return ServiceLocalCompanion(
      id: Value(id),
      serviceName: serviceName == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceName),
      serviceCharge: serviceCharge == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceCharge),
    );
  }

  factory ServiceLocalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceLocalData(
      id: serializer.fromJson<int>(json['id']),
      serviceName: serializer.fromJson<String?>(json['serviceName']),
      serviceCharge: serializer.fromJson<String?>(json['serviceCharge']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serviceName': serializer.toJson<String?>(serviceName),
      'serviceCharge': serializer.toJson<String?>(serviceCharge),
    };
  }

  ServiceLocalData copyWith(
          {int? id,
          Value<String?> serviceName = const Value.absent(),
          Value<String?> serviceCharge = const Value.absent()}) =>
      ServiceLocalData(
        id: id ?? this.id,
        serviceName: serviceName.present ? serviceName.value : this.serviceName,
        serviceCharge:
            serviceCharge.present ? serviceCharge.value : this.serviceCharge,
      );
  @override
  String toString() {
    return (StringBuffer('ServiceLocalData(')
          ..write('id: $id, ')
          ..write('serviceName: $serviceName, ')
          ..write('serviceCharge: $serviceCharge')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, serviceName, serviceCharge);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceLocalData &&
          other.id == this.id &&
          other.serviceName == this.serviceName &&
          other.serviceCharge == this.serviceCharge);
}

class ServiceLocalCompanion extends UpdateCompanion<ServiceLocalData> {
  final Value<int> id;
  final Value<String?> serviceName;
  final Value<String?> serviceCharge;
  const ServiceLocalCompanion({
    this.id = const Value.absent(),
    this.serviceName = const Value.absent(),
    this.serviceCharge = const Value.absent(),
  });
  ServiceLocalCompanion.insert({
    this.id = const Value.absent(),
    this.serviceName = const Value.absent(),
    this.serviceCharge = const Value.absent(),
  });
  static Insertable<ServiceLocalData> custom({
    Expression<int>? id,
    Expression<String>? serviceName,
    Expression<String>? serviceCharge,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serviceName != null) 'service_name': serviceName,
      if (serviceCharge != null) 'service_charge': serviceCharge,
    });
  }

  ServiceLocalCompanion copyWith(
      {Value<int>? id,
      Value<String?>? serviceName,
      Value<String?>? serviceCharge}) {
    return ServiceLocalCompanion(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      serviceCharge: serviceCharge ?? this.serviceCharge,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serviceName.present) {
      map['service_name'] = Variable<String>(serviceName.value);
    }
    if (serviceCharge.present) {
      map['service_charge'] = Variable<String>(serviceCharge.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceLocalCompanion(')
          ..write('id: $id, ')
          ..write('serviceName: $serviceName, ')
          ..write('serviceCharge: $serviceCharge')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDB extends GeneratedDatabase {
  _$AppDB(QueryExecutor e) : super(e);
  late final $ChairLocalTable chairLocal = $ChairLocalTable(this);
  late final $ProductLocalTable productLocal = $ProductLocalTable(this);
  late final $ServiceLocalTable serviceLocal = $ServiceLocalTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [chairLocal, productLocal, serviceLocal];
}
 */