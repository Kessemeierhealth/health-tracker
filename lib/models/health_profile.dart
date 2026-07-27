class HealthProfile {
    List<String> conditions;
    List<String> allergies;
    List<String> surgeries;

    HealthProfile({
        this.conditions = const [],
        this.allergies = const [],
        this.surgeries = const [],
    });
}