from .__about__ import __version__
import gaunit


class GAUnitLibrary:

    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def check_tracking_from_har(
        self, test_case: str, tracking_plan: str, har: str
    ) -> list:
        r = gaunit.check_har(test_case, tracking_plan, har=har)
        return r.checklist_trackers
