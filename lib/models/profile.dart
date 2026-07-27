import 'health_profile.dart';


class Profile {
  final String id;
  String Name;
  int? birthYear;
  double? height;

  HealthProfile health_profile;

  Profile({
    required this.id,
    required this.name,
    this.birthYear,
    this.height,
    HealthProfile? HealthProfile,
  }) : HealthProfile = HealthProfile ?? HealthProfile();
}