<?php
date_default_timezone_set('America/Los_Angeles');
$db = new mysqli("localhost", "kfb", "kfb", "kfb_donations");

$goal->value = 0;

$q = $db->query('select sum(amount) / 100 from donations where designation in ("Grand Rapids General Donation", "Holland General Donation", "Muskegon General Donation") and date(date) > "2015-05-25";');
while ($row = $q->fetch_row()) {
    $goal->value = $row[0];
}


header('Content-Type: application/javascript');
echo $_GET['callback']. '('. json_encode($goal) . ')'; 

?>