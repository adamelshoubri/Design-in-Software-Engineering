<?php
    $user = $_POST['user'];
    $testid = $_POST['testid'];
    $answers = $_POST['answer'];
    $ids = $_POST['id'];
    $pass->testid=$testid;

    /**
    echo $user; echo "<br/>";
    echo $testid; echo "<br/>";
    print_r($answers); echo "<br/>";
    print_r($ids); echo "<br/>";
    */
    $json = json_encode($pass);
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'https://web.njit.edu/~ase28/getanswer.php');
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, array("data"=>$json));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($ch, CURLOPT_HEADER, false);
    $contents = curl_exec($ch);
    curl_close($ch);
    $correct = json_decode($contents);

    $total = 0;
    $final = 0;
    $size = sizeof($ids);
    $data->user=$user;
    $data->testid=$testid;
    for($i=0;$i<$size;$i++){
                    $total = 0;
                    $sanswer = strip_tags($answers[$i]);
                    echo "STUDENT ANSWER: ".$sanswer; echo "<br/>";
                    $ianswer = $correct->$i->ANSWER;
                    $ch = curl_init();
                    $id->questid=$ids[$i];
                    $json = json_encode($id);
                    curl_setopt($ch, CURLOPT_URL, 'https://web.njit.edu/~ase28/backend/getparam.php');
                    curl_setopt($ch, CURLOPT_POST, 1);
                    curl_setopt($ch, CURLOPT_POSTFIELDS, array("data"=>$json));
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_setopt($ch, CURLOPT_HEADER, false);
                    $contents = curl_exec($ch);
                    curl_close($ch);
                    $params = json_decode($contents);
                    //var_dump($params); echo "<br/>";
                    $p_size = count((array)$params);
                    for($x=0;$x<$p_size;$x++){
                        unset($output);
                        $par1 = $params->$x->PARAM1;
                        $par2 = $params->$x->PARAM2;
                        $par3 = $params->$x->PARAM3;
                        $par4 = $params->$x->PARAM4;
                        $amount = $correct->$i->AMOUNT;
                        if($par1 == ""){
                            //echo "java -jar /afs/cad/u/j/t/jtd32/public_html/tomcat7/WEB-INF/lib/test.jar \''.$sanswer.'\' \''.$ianswer.'\' \''.$amount.'\' ";
                            exec('java -jar /afs/cad/u/j/t/jtd32/public_html/tomcat7/WEB-INF/lib/test.jar \''.$sanswer.'\' \''.$ianswer.'\' \''.$amount.'\' ', $output);
                        }
                        elseif($par2 == ""){
                            //echo "java -jar /afs/cad/u/j/t/jtd32/public_html/tomcat7/WEB-INF/lib/test.jar \''.$sanswer.'\' \''.$ianswer.'\' \''.$amount.'\' \''.$par1.'\' ";
                            exec('java -jar /afs/cad/u/j/t/jtd32/public_html/tomcat7/WEB-INF/lib/test.jar \''.$sanswer.'\' \''.$ianswer.'\' \''.$amount.'\' \''.$par1.'\' ', $output);
                        }
                        elseif($par3 == ""){
                            //echo "java -jar /afs/cad/u/j/t/jtd32/public_html/tomcat7/WEB-INF/lib/test.jar \''.$sanswer.'\' \''.$ianswer.'\' \''.$amount.'\' \''.$par1.'\' \''.$par2.'\' ";
                            exec('java -jar /afs/cad/u/j/t/jtd32/public_html/tomcat7/WEB-INF/lib/test.jar \''.$sanswer.'\' \''.$ianswer.'\' \''.$amount.'\' \''.$par1.'\' \''.$par2.'\' ', $output);
                        }
                        elseif($par4 == ""){
                        //echo "java -jar /afs/cad/u/j/t/jtd32/public_html/tomcat7/WEB-INF/lib/test.jar \''.$sanswer.'\' \''.$ianswer.'\' \''.$amount.'\' \''.$par1.'\' \''.$par2.'\' \''.$par3.'\' ";
                            exec('java -jar /afs/cad/u/j/t/jtd32/public_html/tomcat7/WEB-INF/lib/test.jar \''.$sanswer.'\' \''.$ianswer.'\' \''.$amount.'\' \''.$par1.'\' \''.$par2.'\' \''.$par3.'\' ', $output);
                        } else {
                            exec('java -jar /afs/cad/u/j/t/jtd32/public_html/tomcat7/WEB-INF/lib/test.jar \''.$sanswer.'\' \''.$ianswer.'\' \''.$amount.'\' \''.$par1.'\' \''.$par2.'\' \''.$par3.'\' \''.$par4.'\' ', $output);
                        }
                        $score = (float) $output[0];
                        $total += $score;
                        print_r($output[0]);
                        echo "<br/>";
                        print_r($output[1]);
                        echo "<br/>";
                    }        
                    $total = number_format($total/floatval($p_size), 2);
                    $final += $total;
                    $data->questid = $ids[$i];
                    $data->score = $total;
                    $data->comments = $output[1];
                    $data->answer = $sanswer;
                    print_r($data);
                    $json = json_encode($data);
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_URL, 'https://web.njit.edu/~ase28/backend/submitanswer.php');
                    curl_setopt($ch, CURLOPT_POST, 1);
                    curl_setopt($ch, CURLOPT_POSTFIELDS, array("data"=>$json));
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_setopt($ch, CURLOPT_HEADER, false);
                    $contents = curl_exec($ch);
                    curl_close($ch);
    }
    $submit->user = $user;
    $submit->testid = $testid;
    $submit->score = $final;
    $json = json_encode($submit);
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'https://web.njit.edu/~ase28/backend/inserttestscore.php');
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, array("data"=>$json));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($ch, CURLOPT_HEADER, false);
    $contents = curl_exec($ch);
    curl_close($ch);

    header("Location: https://web.njit.edu/~ase28/frontend/studhp.php?user=$user");
?>