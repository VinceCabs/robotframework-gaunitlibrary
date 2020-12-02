from .__about__ import __version__
import gaunit


class GAUnitLibrary:

    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    result = None

    def check_tracking_from_har(
        self, test_case: str, tracking_plan: str, har: dict
    ) -> list:
        r = gaunit.check_har(test_case, tracking_plan, har=har)
        self.result = r
        return r.checklist_expected

    def get_status_expected_events(self) -> list:
        r = self.result
        if r:
            return r.get_status_expected_events()
        else:
            return None
