from .__about__ import __version__
from gaunit.GAUnit import GAUnit


class GAUnitLibrary:

    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def check_tracking_from_har(
        self, test_case: str, har: dict, tracking_plan="tracking_plan.json"
    ) -> list:
        g = GAUnit(tracking_plan=tracking_plan)
        return g.check_tracking_from_har(test_case, har)
