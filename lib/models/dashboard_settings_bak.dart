class DashboardSettings {
    bool showWeight;
    bool showWaistCircumference;
    bool showBodyFat;
    bool showBloodPressure;
    bool showTraining;
    bool showSteps;
    bool showStatistics;

    DashboardSettings({
        this.showWeight = true,
        this.showWaistCircumference = true,
        this.showBodyFat = true,
        this.showBloodPressure = true,
        this.showTraining = true,
        this.showSteps = true,
        this.showStatistics = true,
    });
}