
import 'package:built_value/built_value.dart';

part 'new_connection_data.g.dart';

abstract class NewConnectionData implements Built<NewConnectionData, NewConnectionDataBuilder>  {

  @nullable
  bool get useSSLTLS;

  @nullable
  bool get useSSHTunnel;

  @nullable
  bool get useSSHPrivateKey;

  @nullable
  String get redisName;

  @nullable
  String get redisAddress;

  @nullable
  String get redisPort;

  @nullable
  String get redisPassword;

  @nullable
  String get sshAddress;

  @nullable
  String get sshPort;

  @nullable
  String get sshUser;

  @nullable
  String get sshPassword;

  @nullable
  String get sshPrivateKey;

  @nullable
  String get sshPrivateKeyPassword;

  NewConnectionData._();
  factory NewConnectionData([updates(NewConnectionDataBuilder b)]) = _$NewConnectionData;

}