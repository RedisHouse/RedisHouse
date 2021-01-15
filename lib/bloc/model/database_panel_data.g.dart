// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_panel_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DatabasePanelData extends DatabasePanelData {
  @override
  final String panelUUID;
  @override
  final NewConnectionData connection;
  @override
  final String dbIndex;
  @override
  final int dbSize;
  @override
  final BaseKeyDetail keyDetail;
  @override
  final String selectedKey;
  @override
  final BuiltList<String> scanKeyList;

  factory _$DatabasePanelData(
          [void Function(DatabasePanelDataBuilder) updates]) =>
      (new DatabasePanelDataBuilder()..update(updates)).build();

  _$DatabasePanelData._(
      {this.panelUUID,
      this.connection,
      this.dbIndex,
      this.dbSize,
      this.keyDetail,
      this.selectedKey,
      this.scanKeyList})
      : super._();

  @override
  DatabasePanelData rebuild(void Function(DatabasePanelDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DatabasePanelDataBuilder toBuilder() =>
      new DatabasePanelDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DatabasePanelData &&
        panelUUID == other.panelUUID &&
        connection == other.connection &&
        dbIndex == other.dbIndex &&
        dbSize == other.dbSize &&
        keyDetail == other.keyDetail &&
        selectedKey == other.selectedKey &&
        scanKeyList == other.scanKeyList;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, panelUUID.hashCode), connection.hashCode),
                        dbIndex.hashCode),
                    dbSize.hashCode),
                keyDetail.hashCode),
            selectedKey.hashCode),
        scanKeyList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DatabasePanelData')
          ..add('panelUUID', panelUUID)
          ..add('connection', connection)
          ..add('dbIndex', dbIndex)
          ..add('dbSize', dbSize)
          ..add('keyDetail', keyDetail)
          ..add('selectedKey', selectedKey)
          ..add('scanKeyList', scanKeyList))
        .toString();
  }
}

class DatabasePanelDataBuilder
    implements Builder<DatabasePanelData, DatabasePanelDataBuilder> {
  _$DatabasePanelData _$v;

  String _panelUUID;
  String get panelUUID => _$this._panelUUID;
  set panelUUID(String panelUUID) => _$this._panelUUID = panelUUID;

  NewConnectionDataBuilder _connection;
  NewConnectionDataBuilder get connection =>
      _$this._connection ??= new NewConnectionDataBuilder();
  set connection(NewConnectionDataBuilder connection) =>
      _$this._connection = connection;

  String _dbIndex;
  String get dbIndex => _$this._dbIndex;
  set dbIndex(String dbIndex) => _$this._dbIndex = dbIndex;

  int _dbSize;
  int get dbSize => _$this._dbSize;
  set dbSize(int dbSize) => _$this._dbSize = dbSize;

  BaseKeyDetail _keyDetail;
  BaseKeyDetail get keyDetail => _$this._keyDetail;
  set keyDetail(BaseKeyDetail keyDetail) => _$this._keyDetail = keyDetail;

  String _selectedKey;
  String get selectedKey => _$this._selectedKey;
  set selectedKey(String selectedKey) => _$this._selectedKey = selectedKey;

  ListBuilder<String> _scanKeyList;
  ListBuilder<String> get scanKeyList =>
      _$this._scanKeyList ??= new ListBuilder<String>();
  set scanKeyList(ListBuilder<String> scanKeyList) =>
      _$this._scanKeyList = scanKeyList;

  DatabasePanelDataBuilder();

  DatabasePanelDataBuilder get _$this {
    if (_$v != null) {
      _panelUUID = _$v.panelUUID;
      _connection = _$v.connection?.toBuilder();
      _dbIndex = _$v.dbIndex;
      _dbSize = _$v.dbSize;
      _keyDetail = _$v.keyDetail;
      _selectedKey = _$v.selectedKey;
      _scanKeyList = _$v.scanKeyList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DatabasePanelData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DatabasePanelData;
  }

  @override
  void update(void Function(DatabasePanelDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DatabasePanelData build() {
    _$DatabasePanelData _$result;
    try {
      _$result = _$v ??
          new _$DatabasePanelData._(
              panelUUID: panelUUID,
              connection: _connection?.build(),
              dbIndex: dbIndex,
              dbSize: dbSize,
              keyDetail: keyDetail,
              selectedKey: selectedKey,
              scanKeyList: _scanKeyList?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'connection';
        _connection?.build();

        _$failedField = 'scanKeyList';
        _scanKeyList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DatabasePanelData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StringKeyDetail extends StringKeyDetail {
  @override
  final String value;
  @override
  final String valueChanged;
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$StringKeyDetail([void Function(StringKeyDetailBuilder) updates]) =>
      (new StringKeyDetailBuilder()..update(updates)).build();

  _$StringKeyDetail._(
      {this.value, this.valueChanged, this.key, this.type, this.ttl})
      : super._();

  @override
  StringKeyDetail rebuild(void Function(StringKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StringKeyDetailBuilder toBuilder() =>
      new StringKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StringKeyDetail &&
        value == other.value &&
        valueChanged == other.valueChanged &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, value.hashCode), valueChanged.hashCode),
                key.hashCode),
            type.hashCode),
        ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StringKeyDetail')
          ..add('value', value)
          ..add('valueChanged', valueChanged)
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class StringKeyDetailBuilder
    implements Builder<StringKeyDetail, StringKeyDetailBuilder> {
  _$StringKeyDetail _$v;

  String _value;
  String get value => _$this._value;
  set value(String value) => _$this._value = value;

  String _valueChanged;
  String get valueChanged => _$this._valueChanged;
  set valueChanged(String valueChanged) => _$this._valueChanged = valueChanged;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  StringKeyDetailBuilder();

  StringKeyDetailBuilder get _$this {
    if (_$v != null) {
      _value = _$v.value;
      _valueChanged = _$v.valueChanged;
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StringKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StringKeyDetail;
  }

  @override
  void update(void Function(StringKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StringKeyDetail build() {
    final _$result = _$v ??
        new _$StringKeyDetail._(
            value: value,
            valueChanged: valueChanged,
            key: key,
            type: type,
            ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$HashKeyDetail extends HashKeyDetail {
  @override
  final int hlen;
  @override
  final int scanIndex;
  @override
  final BuiltMap<String, String> scanKeyValueMap;
  @override
  final String selectedKey;
  @override
  final String selectedKeyChanged;
  @override
  final String selectedValue;
  @override
  final String selectedValueChanged;
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$HashKeyDetail([void Function(HashKeyDetailBuilder) updates]) =>
      (new HashKeyDetailBuilder()..update(updates)).build();

  _$HashKeyDetail._(
      {this.hlen,
      this.scanIndex,
      this.scanKeyValueMap,
      this.selectedKey,
      this.selectedKeyChanged,
      this.selectedValue,
      this.selectedValueChanged,
      this.key,
      this.type,
      this.ttl})
      : super._();

  @override
  HashKeyDetail rebuild(void Function(HashKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HashKeyDetailBuilder toBuilder() => new HashKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HashKeyDetail &&
        hlen == other.hlen &&
        scanIndex == other.scanIndex &&
        scanKeyValueMap == other.scanKeyValueMap &&
        selectedKey == other.selectedKey &&
        selectedKeyChanged == other.selectedKeyChanged &&
        selectedValue == other.selectedValue &&
        selectedValueChanged == other.selectedValueChanged &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, hlen.hashCode),
                                        scanIndex.hashCode),
                                    scanKeyValueMap.hashCode),
                                selectedKey.hashCode),
                            selectedKeyChanged.hashCode),
                        selectedValue.hashCode),
                    selectedValueChanged.hashCode),
                key.hashCode),
            type.hashCode),
        ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HashKeyDetail')
          ..add('hlen', hlen)
          ..add('scanIndex', scanIndex)
          ..add('scanKeyValueMap', scanKeyValueMap)
          ..add('selectedKey', selectedKey)
          ..add('selectedKeyChanged', selectedKeyChanged)
          ..add('selectedValue', selectedValue)
          ..add('selectedValueChanged', selectedValueChanged)
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class HashKeyDetailBuilder
    implements Builder<HashKeyDetail, HashKeyDetailBuilder> {
  _$HashKeyDetail _$v;

  int _hlen;
  int get hlen => _$this._hlen;
  set hlen(int hlen) => _$this._hlen = hlen;

  int _scanIndex;
  int get scanIndex => _$this._scanIndex;
  set scanIndex(int scanIndex) => _$this._scanIndex = scanIndex;

  MapBuilder<String, String> _scanKeyValueMap;
  MapBuilder<String, String> get scanKeyValueMap =>
      _$this._scanKeyValueMap ??= new MapBuilder<String, String>();
  set scanKeyValueMap(MapBuilder<String, String> scanKeyValueMap) =>
      _$this._scanKeyValueMap = scanKeyValueMap;

  String _selectedKey;
  String get selectedKey => _$this._selectedKey;
  set selectedKey(String selectedKey) => _$this._selectedKey = selectedKey;

  String _selectedKeyChanged;
  String get selectedKeyChanged => _$this._selectedKeyChanged;
  set selectedKeyChanged(String selectedKeyChanged) =>
      _$this._selectedKeyChanged = selectedKeyChanged;

  String _selectedValue;
  String get selectedValue => _$this._selectedValue;
  set selectedValue(String selectedValue) =>
      _$this._selectedValue = selectedValue;

  String _selectedValueChanged;
  String get selectedValueChanged => _$this._selectedValueChanged;
  set selectedValueChanged(String selectedValueChanged) =>
      _$this._selectedValueChanged = selectedValueChanged;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  HashKeyDetailBuilder();

  HashKeyDetailBuilder get _$this {
    if (_$v != null) {
      _hlen = _$v.hlen;
      _scanIndex = _$v.scanIndex;
      _scanKeyValueMap = _$v.scanKeyValueMap?.toBuilder();
      _selectedKey = _$v.selectedKey;
      _selectedKeyChanged = _$v.selectedKeyChanged;
      _selectedValue = _$v.selectedValue;
      _selectedValueChanged = _$v.selectedValueChanged;
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HashKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HashKeyDetail;
  }

  @override
  void update(void Function(HashKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HashKeyDetail build() {
    _$HashKeyDetail _$result;
    try {
      _$result = _$v ??
          new _$HashKeyDetail._(
              hlen: hlen,
              scanIndex: scanIndex,
              scanKeyValueMap: _scanKeyValueMap?.build(),
              selectedKey: selectedKey,
              selectedKeyChanged: selectedKeyChanged,
              selectedValue: selectedValue,
              selectedValueChanged: selectedValueChanged,
              key: key,
              type: type,
              ttl: ttl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'scanKeyValueMap';
        _scanKeyValueMap?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HashKeyDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ListKeyDetail extends ListKeyDetail {
  @override
  final int llen;
  @override
  final int pageIndex;
  @override
  final BuiltList<String> rangeList;
  @override
  final int selectedIndex;
  @override
  final String selectedValue;
  @override
  final String selectedValueChanged;
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$ListKeyDetail([void Function(ListKeyDetailBuilder) updates]) =>
      (new ListKeyDetailBuilder()..update(updates)).build();

  _$ListKeyDetail._(
      {this.llen,
      this.pageIndex,
      this.rangeList,
      this.selectedIndex,
      this.selectedValue,
      this.selectedValueChanged,
      this.key,
      this.type,
      this.ttl})
      : super._();

  @override
  ListKeyDetail rebuild(void Function(ListKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListKeyDetailBuilder toBuilder() => new ListKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListKeyDetail &&
        llen == other.llen &&
        pageIndex == other.pageIndex &&
        rangeList == other.rangeList &&
        selectedIndex == other.selectedIndex &&
        selectedValue == other.selectedValue &&
        selectedValueChanged == other.selectedValueChanged &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, llen.hashCode), pageIndex.hashCode),
                                rangeList.hashCode),
                            selectedIndex.hashCode),
                        selectedValue.hashCode),
                    selectedValueChanged.hashCode),
                key.hashCode),
            type.hashCode),
        ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListKeyDetail')
          ..add('llen', llen)
          ..add('pageIndex', pageIndex)
          ..add('rangeList', rangeList)
          ..add('selectedIndex', selectedIndex)
          ..add('selectedValue', selectedValue)
          ..add('selectedValueChanged', selectedValueChanged)
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class ListKeyDetailBuilder
    implements Builder<ListKeyDetail, ListKeyDetailBuilder> {
  _$ListKeyDetail _$v;

  int _llen;
  int get llen => _$this._llen;
  set llen(int llen) => _$this._llen = llen;

  int _pageIndex;
  int get pageIndex => _$this._pageIndex;
  set pageIndex(int pageIndex) => _$this._pageIndex = pageIndex;

  ListBuilder<String> _rangeList;
  ListBuilder<String> get rangeList =>
      _$this._rangeList ??= new ListBuilder<String>();
  set rangeList(ListBuilder<String> rangeList) => _$this._rangeList = rangeList;

  int _selectedIndex;
  int get selectedIndex => _$this._selectedIndex;
  set selectedIndex(int selectedIndex) => _$this._selectedIndex = selectedIndex;

  String _selectedValue;
  String get selectedValue => _$this._selectedValue;
  set selectedValue(String selectedValue) =>
      _$this._selectedValue = selectedValue;

  String _selectedValueChanged;
  String get selectedValueChanged => _$this._selectedValueChanged;
  set selectedValueChanged(String selectedValueChanged) =>
      _$this._selectedValueChanged = selectedValueChanged;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  ListKeyDetailBuilder();

  ListKeyDetailBuilder get _$this {
    if (_$v != null) {
      _llen = _$v.llen;
      _pageIndex = _$v.pageIndex;
      _rangeList = _$v.rangeList?.toBuilder();
      _selectedIndex = _$v.selectedIndex;
      _selectedValue = _$v.selectedValue;
      _selectedValueChanged = _$v.selectedValueChanged;
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListKeyDetail;
  }

  @override
  void update(void Function(ListKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListKeyDetail build() {
    _$ListKeyDetail _$result;
    try {
      _$result = _$v ??
          new _$ListKeyDetail._(
              llen: llen,
              pageIndex: pageIndex,
              rangeList: _rangeList?.build(),
              selectedIndex: selectedIndex,
              selectedValue: selectedValue,
              selectedValueChanged: selectedValueChanged,
              key: key,
              type: type,
              ttl: ttl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'rangeList';
        _rangeList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ListKeyDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SetKeyDetail extends SetKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$SetKeyDetail([void Function(SetKeyDetailBuilder) updates]) =>
      (new SetKeyDetailBuilder()..update(updates)).build();

  _$SetKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  SetKeyDetail rebuild(void Function(SetKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetKeyDetailBuilder toBuilder() => new SetKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SetKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class SetKeyDetailBuilder
    implements Builder<SetKeyDetail, SetKeyDetailBuilder> {
  _$SetKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  SetKeyDetailBuilder();

  SetKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SetKeyDetail;
  }

  @override
  void update(void Function(SetKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SetKeyDetail build() {
    final _$result =
        _$v ?? new _$SetKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$ZSetKeyDetail extends ZSetKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$ZSetKeyDetail([void Function(ZSetKeyDetailBuilder) updates]) =>
      (new ZSetKeyDetailBuilder()..update(updates)).build();

  _$ZSetKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  ZSetKeyDetail rebuild(void Function(ZSetKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ZSetKeyDetailBuilder toBuilder() => new ZSetKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ZSetKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ZSetKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class ZSetKeyDetailBuilder
    implements Builder<ZSetKeyDetail, ZSetKeyDetailBuilder> {
  _$ZSetKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  ZSetKeyDetailBuilder();

  ZSetKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ZSetKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ZSetKeyDetail;
  }

  @override
  void update(void Function(ZSetKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ZSetKeyDetail build() {
    final _$result =
        _$v ?? new _$ZSetKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
