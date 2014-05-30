<?php
require_once('config.php');
require_once('lib/stripe/lib/Stripe.php');
Stripe::setApiKey($stripe_secret_key);


date_default_timezone_set('America/Los_Angeles');
$db = new mysqli("localhost", "kfb", "kfb", "kfb_donations");

$email = $_GET['e_mail'];
$token  = $_GET['token'];
$amount = $_GET['amount'];
$data = $_GET['metadata'];
$recurring = $_GET['recurring'];
$response->error = '';
$response->error_detail = '';
$error = false;

try {
	$customer = Stripe_Customer::create(array(
    'email' => $email,
    'card'  => $token['id'],
		'metadata' => array(
			'subscribe_newsletter' => $data['subscribe_newsletter']
		)
  ));
} catch (Exception $e) {
	$error = true;
	$response->error = 'An unexpected error occurred. Please try again.';
	$response->error_detail = $e->getMessage();
}

if (!$error) {
	if($recurring == 'true'){
		
		try {

			$customer->subscriptions->create(array(
				"plan" => "recurring_gift",
				"quantity" => $amount,
				'metadata' => array(
					'designation' => $data['designation'],
					'honormemory' => $data['honormemory']
				)
			));

			$response->amount = sprintf("%01.2f", $amount / 100);
			$response->last4 = $token['card']['last4'];
			$response->designation = $data['designation'];
			$response->honormemory = $data['honormemory'];
			$response->email = $email;
			$charge_id = 0;
			
		} catch (Exception $e) {
			$error = true;
			$response->error = 'An unexpected error occurred. Please try again.';
			$response->error_detail = $e->getMessage();
		}

	}else{
		
		try {
			$charge = Stripe_Charge::create(array(
				'customer' => $customer->id,
				'amount'   => $amount, // in cents
				'currency' => 'usd',
				'metadata' => array(
					'designation' => $data['designation'],
					'honormemory' => $data['honormemory']
				),
			));

			$response->amount = sprintf("%01.2f", $charge->amount / 100);
			$response->last4 = $token['card']['last4'];
			$response->designation = $data['designation'];
			$response->honormemory = $data['honormemory'];
			$response->email = $email;
			$charge_id = $charge->id;
			
		} catch (Exception $e) {
			$error = true;
			$response->error = 'An unexpected error occurred. Please try again.';
			$response->error_detail = $e->getMessage();
		}

	}
}


//create table donations (id int, date datetime, charge_id varchar(50), customer_id varchar(50), designation varchar(200), amount int);
if(!$error){
	try{
		$id = 0;
		$date = date('Y-m-d h:i:s', time());
		$customer_id = $customer->id;
		$designation = $data['designation'];

		$q = $db->prepare("INSERT INTO donations (id, date, charge_id, customer_id, designation, amount) values(?, ?, ?, ?, ?, ?)");
		$q->bind_param("issssd",
			$id, //id
			$date, //date
			$charge_id, //charge_id
			$customer_id, //customer_id
			$designation, //designation
			$amount //amount
			);
		$q->execute();
		$q->close();
	}catch (Exception $e) {
	}
}

header('Content-Type: application/javascript');

echo $_GET['callback']. '('. json_encode($response) . ')'; 
?>