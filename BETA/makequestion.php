<?php
header('Context-type: application/json');
if(isset($_POST['data'])){
        logInfo();
        exit(); 
}
?>
<html>
	<head>
		<title>Adam Elshoubri</title>
	</head>
	<body>
		<form action ='makequestion.php' method = POST>
            		<input type = "hidden" name = "data">
        	</form>

    		<?php
    			  function logInfo(){
            			mysql_connect('sql1.njit.edu', 'ase28', 'aoFxdVBX3');
            			mysql_select_db('ase28');	
	   		        	$datastring = $_POST['data'];
            			$data = json_decode($datastring);

            			$set = mysql_query("SELECT MAX(QUESTID) AS MAX_ID FROM QUESTIONBANK");
			          	$result = mysql_fetch_array($set);
				        $max = $result['MAX_ID'];
				        $max++;
				        echo $max;
			
			          	$result = mysql_query ("INSERT INTO QUESTIONBANK(INSTUSER, QUESTID, TYPE, DIFFICULTY, QUESTION, ANSWER) VALUES('$data->user','$max'
            			        ,'$data->type','$data->difficulty','$data->question', '$data->answer')");


             		}

    		?>

	</body>
</html>

