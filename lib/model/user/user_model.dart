import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:luvit/utils/asset_helper.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  UserModel._();
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  factory UserModel({
    required String id,
    required String fullName,
    required int age,
    @Default(0) double rating,
    @Default('') String bio,
    String? profilePicUrl,
    DateTime? updatedAt,
    DateTime? createdAt,
    @Default([]) List<String> imagePaths,
    @Default([]) List<String> hobbies,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

List<UserModel> get fakeUsers => [
      UserModel(
          id: '1',
          fullName: '잭과분홍콩나물',
          age: 25,
          rating: 2930,
          imagePaths: [
            image1,
            image2,
            image3,
            image3,
            image3,
          ],
          bio: '서로 아껴주고 힘이 되어줄 사람 찾아요'
              ' 선릉으로 직장 다니고 있고 여행 좋아해요'
              ' 이상한 이야기하시는 분 바로 차단입니다',
          hobbies: [
            ';💖 진지한 연애를 찾는 중',
            '🍸 전혀 안 함',
            '🚬 비흡연',
            '💪 매일 1시간 이상',
            '🤝 만나는 걸 좋아함',
            'INFP'
          ]),
    ];
