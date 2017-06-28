<?php
/*
Get and vcard file and filter only contacts with phone number
I've used that to import contats from Google contacts to my iCloud account
*/

$vcard_file = $_SERVER['argv'][1];
if(!file_exists($vcard_file)){
	exit('vcard file nt exists');
}

$contents = file_get_contents($vcard_file);
$explode = explode("\r\n", $contents);

$vcard = array();

$contact = '';
foreach($explode as $linha){
   if($linha == 'BEGIN:VCARD'){
      $contact = $linha . "\r\n";
      continue;
   }

   if($linha == 'END:VCARD'){
      $contact .= $linha;
      $vcard[] = $contact;
      $contact = '';
      continue;
   }

   $contact .= $linha . "\r\n";
}


foreach($vcard as $id => $linha){
	if(!strstr($linha, 'TEL')){
		unset($vcard[$id]);
	}        	
}


echo implode("\r\n", $vcard);
