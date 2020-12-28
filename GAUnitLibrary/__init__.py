import json

import gaunit
from robot.libraries.BuiltIn import BuiltIn

from .__about__ import __version__


class GAUnitLibrary:
    """GAUnitLibrary is a Robot Framework library to interface with
    [https://pypi.org/project/gaunit/|GAUnit]

    See [https://github.com/VinceCabs/robotframework-gaunitlibrary|project page] for more info
    """

    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    result = None

    def check_tracking_from_har(
        self, test_case: str, tracking_plan: str, har: dict
    ) -> list:
        """Performs checks of a har dict file against a tracking plan

        ``test_case`` (str): test case id (same id used to match with tracking plan)
        ``tracking_plan`` (str): path to tracking plan file (see Documentation)
        ``har`` (dict): actual har for this test case in dict format.

        Example:

        | ${checklist} =       | `Check Tracking From HAR` | ${TEST NAME} | ${tracking_plan} | ${har}
        | `Should Not Contain` | ${checklist}              | ${False}
        """
        r = gaunit.check_har(test_case, tracking_plan, har=har)
        # store result in class instance for further use
        self.result = r
        return r.checklist_expected

    def check_tracking_from_perf_log(self, test_case: str, tracking_plan: str) -> list:

        perf_log = self._get_perf_log()
        r = gaunit.check_perf_log(test_case, tracking_plan, perf_log)
        # store result in class instance for further use
        self.result = r
        return r.checklist_expected

    def get_status_expected_events(self) -> str:

        r = self.result
        if r:
            return json.dumps(r.get_status_expected_events(), indent=4)
        else:
            return None

    def get_status_actual_events(self) -> str:

        r = self.result
        if r:
            return json.dumps(r.get_status_actual_events(), indent=4)
        else:
            return None

    def _get_perf_log(self):
        # get Performance Log from current webdriver instance
        perf_log = (
            BuiltIn()
            .get_library_instance("SeleniumLibrary")
            .driver.get_log("performance")
        )
        return perf_log
