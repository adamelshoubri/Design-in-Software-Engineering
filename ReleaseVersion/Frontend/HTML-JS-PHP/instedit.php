<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name "description" content="CodeQuiz">
        <meta name="author" content="John Deignan/Adam Elshoubri">
        <title>Instructor-Edit Results</title>
        <link href="bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600' rel='stylesheet' type='text/css'>
        <link href='style.css' rel='stylesheet'>
        <style>
            body {
                font-family: Trebuchet MS;
            }
            #navbar ul {
        	  list-style-type: none;
        	  margin: 0;
        	  padding:0;
        	  overflow: hidden;
        	  background-color: #333;
        	}
        	#navbar ul li {
        	  float: left;
        	  border-right: none;
        	  border-left: none;
        	}
        	#navbar ul li a{
        	  display: block;
        	  color: white;
        	  text-align: center;
        	  padding: 14px 16px;
        	  text-decoration: none;
        	}
        	#navbar ul li a:hover:not(.active){
        	  background-color: #111;
        	}
        	
        	.active {
        	  background-color: #1E90FF;
        	}
        </style>
    </head>
    <body>
        <div id="navbar">
            <ul>
                <?php
                $user = $_POST['user'];
                echo "<li><a href='insthp.php?user=".$user."'><b>CODEQUIZ</b></a></li>";
                echo "<li><a href='bank.php?user=".$user."'><b>Make Questions</b></a></li>";
                echo "<li><a href='create.php?user=".$user."'><b>Create Tests</b></a></li>";
                echo "<li style='float:right'><a href='login.php'><b>Log Out</b></a></li>";
                ?>
            </ul>
        </div>
        <section class="container">
                 <?php
                    $data->testid = $_POST['testid'];
                    $data->user = $_POST['stuser'];
                    $json = json_encode($data);
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_URL, 'https://web.njit.edu/~ase28/backend/studentanswers.php');
                    curl_setopt($ch, CURLOPT_POST, 1);
                    curl_setopt($ch, CURLOPT_POSTFIELDS, array("data"=>$json));
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_setopt($ch, CURLOPT_HEADER, false);
                    $contents = curl_exec($ch);
                    curl_close();
                    $array = json_decode($contents);
                     ?>
                     <h2>
                        Test results of: <?php echo $data->user; ?>
                     </h2>
                     <form action='updatetest.php' method=POST >
                                    <table class="table" style="font-size:1.2rem;">
                                    <tr>

                                        <?php
                                                echo "<th>Question:</th>";
                                                echo "<th>Student's Answer:</th>";
                                                echo "<th>Correct Answer:</th>";
                                                echo "<th>Comments:</th>";
                                                echo "<th>Edit Score:</th>";
                                        ?>

                                    </tr>

                                        <?php
                                            $arrsize = count((array)$array) - 1;
                                            $tagsize = count((array)$tags);
                                            $qtext = 6;
                                            $corranswer = 7;
                                            for($i = 0; $i<$arrsize; $i++){
                                                echo "<tr>";
                                                echo "<td>".$array[$i]->$qtext."<input type='hidden' name='questid[]' value=".$array[$i]->QUESTID." /></td>";
                                                echo "<td>".$array[$i]->ANSWERS."</td>";
                                                echo "<td>".$array[$i]->$corranswer."</td>";
                                                echo "<td>".$array[$i]->COMMENTS."</td>";
                                                echo "<td><input style='width:60px' class='form-control' type='text' name='scores[]' value=".$array[$i]->SCORE." /></td>";
                                                echo "</tr>";
                                            }
                                        ?>
                    </table><br/>
                      <input type="text" class="form-control" style="width:55%;margin:auto;" id="instcomment" name="comment" placeholder="Add Comments Here..." /><br/>
                      <input class='form-control' type='submit' value='Finalize Results' style="width:20%;margin:auto;" />
                      <input type='hidden' name='user' value=<?php echo $data->user ?> />
                      <input type='hidden' name='instuser' value=<?php echo $user ?> />
                      <input type='hidden' name='testid' value=<?php echo $data->testid ?> />
                    </form>
        </section>
    </body>
</html>