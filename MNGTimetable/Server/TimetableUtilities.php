<?php

class Constants {
	const baseURL = "http://info.tam.ch/display/timetable_external.php?school=%school&classname=%name&sem=%sem&week=%week";
}
class TimetableUtilities {
	public function setupDb() {
		if ($db = new SQLiteDatabase('timetable.sqlite')) {
		
		}
	}

	public function fetchLessons() {
		if ($db = new SQLiteDatabase('timetable.sqlite')) {
			$res = @$db->query(".read timetable.sql");
			echo $res;
		}
		
		file_get_contents();
	}
}
TimetableUtilities->fetchLessons();
?>
hello