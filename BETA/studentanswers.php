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
        <form action ='studentanswers.php' method = POST>
      		  <input type = "hidden" name = "data">
     	  </form>
    		<?php
    			function logInfo(){
            			mysql_connect('sql1.njit.edu', 'ase28', 'aoFxdVBX3');
            			mysql_select_db('ase28');
    			        $datastring = $_POST['data'];
            			$data = json_decode($datastring);

                  $result = mysql_query ("SELECT SCORE FROM STUDTEST WHERE TESTID='$data->testid' AND STUDUSER='$data->user'");
                  $stdscore = mysql_fetch_array($result);
                  $score = $stdscore['SCORE'];
                  $return->score = $score;
                  
                  $result = mysql_query ("SELECT * FROM STUDANSWERS WHERE TESTID='$data->testid' AND STUDUSER='$data->user'");
                  $array = array();
	    			      if($row = mysql_fetch_array($result)) {
					          do{
						            $array[] = $row;
					          } while($row= mysql_fetch_array($result));
	    			      }
                  array_push($array, $score);
                  
                  echo json_encode($array);
          }
    		?>
    </body>
</html>
