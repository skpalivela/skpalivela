<?php
// Create the tabular data we want to upload to  Sheets
function convertXmlToCsvFile($xml_file_input, $csv_file_output) {
	$xml = simplexml_load_file($xml_file_input);
	
	$output_file = fopen($csv_file_output, 'w');
	
	$header = false;
	
	foreach($xml as $key => $value){
		if(!$header) {
			fputcsv($output_file, array_keys(get_object_vars($value)));
			$header = true;
		}
		fputcsv($output_file, get_object_vars($value));
	}
	
	fclose($output_file);
        echo "File conversion completed " . $csv_file_output;
}

convertXmlToCsvFile("C:\php-case-study\coffee_feed.xml", "C:\php-case-study\coffee_feed.csv");
?>