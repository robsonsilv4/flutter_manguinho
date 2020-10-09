import '../../domain/entities/account_entity.dart';

class RemoteAccountModel {
  final String acessToken;

  RemoteAccountModel(this.acessToken);

  factory RemoteAccountModel.fromJson(Map json) =>
      RemoteAccountModel(json['accessToken']);

  AccountEntity toEntity() => AccountEntity(acessToken);
}
