<?php
if(isset($_POST['insert'])){
        insert();
        exit();
}
?>
<html>
    <head>
        <title>Adam Elshoubri</title>
    </head>
    <body>
        <form action ='inserttestquestions.php' method = POST>
            <input type = "hidden" name = "insert">
        	</form>
 	</body>
</html>
<?php
    		function insert(){
                mysql_connect('sql1.njit.edu', 'ase28', 'aoFxdVBX3');
            	mysql_select_db('ase28');
       			$insertstring = $_POST['insert'];
            	$insert = json_decode($insertstring);
            
                $t_id = mysql_query ("SELECT MAX(TESTID) AS MAX_ID FROM INSTTEST ");
                $tid = mysql_fetch_array($t_id);
                $rsize = sizeof($insert);
                $testid = $tid['MAX_ID'];
                for($i = 0; $i< $rsize; $i++){
                    $id = $insert[$i];
                    $res2 = mysql_query ("INSERT INTO QUEST_TEST(QUESTID, TESTID) VALUES('$id', '$testid')");
                }
            }
?>