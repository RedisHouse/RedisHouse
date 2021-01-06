// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_page_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MainPageData extends MainPageData {
  @override
  final bool redisListOpen;
  @override
  final bool logOpen;
  @override
  final BuiltMap<String, ConnectionDetail> connectedRedisMap;
  @override
  final BuiltList<PanelInfo> panelList;
  @override
  final int activePanelIndex;

  factory _$MainPageData([void Function(MainPageDataBuilder) updates]) =>
      (new MainPageDataBuilder()..update(updates)).build();

  _$MainPageData._(
      {this.redisListOpen,
      this.logOpen,
      this.connectedRedisMap,
      this.panelList,
      this.activePanelIndex})
      : super._();

  @override
  MainPageData rebuild(void Function(MainPageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MainPageDataBuilder toBuilder() => new MainPageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MainPageData &&
        redisListOpen == other.redisListOpen &&
        logOpen == other.logOpen &&
        connectedRedisMap == other.connectedRedisMap &&
        panelList == other.panelList &&
        activePanelIndex == other.activePanelIndex;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, redisListOpen.hashCode), logOpen.hashCode),
                connectedRedisMap.hashCode),
            panelList.hashCode),
        activePanelIndex.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MainPageData')
          ..add('redisListOpen', redisListOpen)
          ..add('logOpen', logOpen)
          ..add('connectedRedisMap', connectedRedisMap)
          ..add('panelList', panelList)
          ..add('activePanelIndex', activePanelIndex))
        .toString();
  }
}

class MainPageDataBuilder
    implements Builder<MainPageData, MainPageDataBuilder> {
  _$MainPageData _$v;

  bool _redisListOpen;
  bool get redisListOpen => _$this._redisListOpen;
  set redisListOpen(bool redisListOpen) =>
      _$this._redisListOpen = redisListOpen;

  bool _logOpen;
  bool get logOpen => _$this._logOpen;
  set logOpen(bool logOpen) => _$this._logOpen = logOpen;

  MapBuilder<String, ConnectionDetail> _connectedRedisMap;
  MapBuilder<String, ConnectionDetail> get connectedRedisMap =>
      _$this._connectedRedisMap ??= new MapBuilder<String, ConnectionDetail>();
  set connectedRedisMap(
          MapBuilder<String, ConnectionDetail> connectedRedisMap) =>
      _$this._connectedRedisMap = connectedRedisMap;

  ListBuilder<PanelInfo> _panelList;
  ListBuilder<PanelInfo> get panelList =>
      _$this._panelList ??= new ListBuilder<PanelInfo>();
  set panelList(ListBuilder<PanelInfo> panelList) =>
      _$this._panelList = panelList;

  int _activePanelIndex;
  int get activePanelIndex => _$this._activePanelIndex;
  set activePanelIndex(int activePanelIndex) =>
      _$this._activePanelIndex = activePanelIndex;

  MainPageDataBuilder();

  MainPageDataBuilder get _$this {
    if (_$v != null) {
      _redisListOpen = _$v.redisListOpen;
      _logOpen = _$v.logOpen;
      _connectedRedisMap = _$v.connectedRedisMap?.toBuilder();
      _panelList = _$v.panelList?.toBuilder();
      _activePanelIndex = _$v.activePanelIndex;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MainPageData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MainPageData;
  }

  @override
  void update(void Function(MainPageDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MainPageData build() {
    _$MainPageData _$result;
    try {
      _$result = _$v ??
          new _$MainPageData._(
              redisListOpen: redisListOpen,
              logOpen: logOpen,
              connectedRedisMap: _connectedRedisMap?.build(),
              panelList: _panelList?.build(),
              activePanelIndex: activePanelIndex);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'connectedRedisMap';
        _connectedRedisMap?.build();
        _$failedField = 'panelList';
        _panelList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MainPageData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ConnectionDetail extends ConnectionDetail {
  @override
  final bool expanded;
  @override
  final int dbNum;
  @override
  final BuiltMap<String, int> dbKeyNumMap;

  factory _$ConnectionDetail(
          [void Function(ConnectionDetailBuilder) updates]) =>
      (new ConnectionDetailBuilder()..update(updates)).build();

  _$ConnectionDetail._({this.expanded, this.dbNum, this.dbKeyNumMap})
      : super._();

  @override
  ConnectionDetail rebuild(void Function(ConnectionDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConnectionDetailBuilder toBuilder() =>
      new ConnectionDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConnectionDetail &&
        expanded == other.expanded &&
        dbNum == other.dbNum &&
        dbKeyNumMap == other.dbKeyNumMap;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, expanded.hashCode), dbNum.hashCode), dbKeyNumMap.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ConnectionDetail')
          ..add('expanded', expanded)
          ..add('dbNum', dbNum)
          ..add('dbKeyNumMap', dbKeyNumMap))
        .toString();
  }
}

class ConnectionDetailBuilder
    implements Builder<ConnectionDetail, ConnectionDetailBuilder> {
  _$ConnectionDetail _$v;

  bool _expanded;
  bool get expanded => _$this._expanded;
  set expanded(bool expanded) => _$this._expanded = expanded;

  int _dbNum;
  int get dbNum => _$this._dbNum;
  set dbNum(int dbNum) => _$this._dbNum = dbNum;

  MapBuilder<String, int> _dbKeyNumMap;
  MapBuilder<String, int> get dbKeyNumMap =>
      _$this._dbKeyNumMap ??= new MapBuilder<String, int>();
  set dbKeyNumMap(MapBuilder<String, int> dbKeyNumMap) =>
      _$this._dbKeyNumMap = dbKeyNumMap;

  ConnectionDetailBuilder();

  ConnectionDetailBuilder get _$this {
    if (_$v != null) {
      _expanded = _$v.expanded;
      _dbNum = _$v.dbNum;
      _dbKeyNumMap = _$v.dbKeyNumMap?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConnectionDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ConnectionDetail;
  }

  @override
  void update(void Function(ConnectionDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ConnectionDetail build() {
    _$ConnectionDetail _$result;
    try {
      _$result = _$v ??
          new _$ConnectionDetail._(
              expanded: expanded,
              dbNum: dbNum,
              dbKeyNumMap: _dbKeyNumMap?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'dbKeyNumMap';
        _dbKeyNumMap?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ConnectionDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PanelInfo extends PanelInfo {
  @override
  final String uuid;
  @override
  final String type;
  @override
  final String name;
  @override
  final NewConnectionData connection;
  @override
  final String dbIndex;

  factory _$PanelInfo([void Function(PanelInfoBuilder) updates]) =>
      (new PanelInfoBuilder()..update(updates)).build();

  _$PanelInfo._(
      {this.uuid, this.type, this.name, this.connection, this.dbIndex})
      : super._();

  @override
  PanelInfo rebuild(void Function(PanelInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PanelInfoBuilder toBuilder() => new PanelInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PanelInfo &&
        uuid == other.uuid &&
        type == other.type &&
        name == other.name &&
        connection == other.connection &&
        dbIndex == other.dbIndex;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, uuid.hashCode), type.hashCode), name.hashCode),
            connection.hashCode),
        dbIndex.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PanelInfo')
          ..add('uuid', uuid)
          ..add('type', type)
          ..add('name', name)
          ..add('connection', connection)
          ..add('dbIndex', dbIndex))
        .toString();
  }
}

class PanelInfoBuilder implements Builder<PanelInfo, PanelInfoBuilder> {
  _$PanelInfo _$v;

  String _uuid;
  String get uuid => _$this._uuid;
  set uuid(String uuid) => _$this._uuid = uuid;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  NewConnectionDataBuilder _connection;
  NewConnectionDataBuilder get connection =>
      _$this._connection ??= new NewConnectionDataBuilder();
  set connection(NewConnectionDataBuilder connection) =>
      _$this._connection = connection;

  String _dbIndex;
  String get dbIndex => _$this._dbIndex;
  set dbIndex(String dbIndex) => _$this._dbIndex = dbIndex;

  PanelInfoBuilder();

  PanelInfoBuilder get _$this {
    if (_$v != null) {
      _uuid = _$v.uuid;
      _type = _$v.type;
      _name = _$v.name;
      _connection = _$v.connection?.toBuilder();
      _dbIndex = _$v.dbIndex;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PanelInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PanelInfo;
  }

  @override
  void update(void Function(PanelInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PanelInfo build() {
    _$PanelInfo _$result;
    try {
      _$result = _$v ??
          new _$PanelInfo._(
              uuid: uuid,
              type: type,
              name: name,
              connection: _connection?.build(),
              dbIndex: dbIndex);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'connection';
        _connection?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PanelInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
