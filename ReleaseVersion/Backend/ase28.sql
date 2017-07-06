SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ase28`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`ase28`@`%.njit.edu` PROCEDURE `FindReplace`(Value INT, NewValue INT)
FindReplaceSP: BEGIN
START TRANSACTION;
INSERT INTO temp VALUES(0);
IF Value IS NULL OR Value = 0 THEN
ROLLBACK;
LEAVE FindReplaceSP;
END IF;
/* Code to Find Value & Replace with NewValue*/
COMMIT;
END$$

--
-- Functions
--
CREATE DEFINER=`ase28`@`%.njit.edu` FUNCTION `StateCheck`(Abbr CHAR(2)) RETURNS tinyint(1)
BEGIN
IF EXISTS
(SELECT StateName FROM States WHERE Abbr = State2)
THEN
RETURN TRUE;
ELSE
RETURN FALSE;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Instructor`
--

CREATE TABLE IF NOT EXISTS `Instructor` (
  `INSTUSER` varchar(16) NOT NULL,
  `PASSWORD` varchar(32) NOT NULL,
  `FNAME` varchar(32) NOT NULL,
  `LNAME` varchar(32) NOT NULL,
  `CODE` int(8) NOT NULL,
  `CPASSWORD` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Instructor`
--

INSERT INTO `Instructor` (`INSTUSER`, `PASSWORD`, `FNAME`, `LNAME`, `CODE`, `CPASSWORD`) VALUES
('instructor', 'instructor', 'John', 'Smith', 0, 'class');

-- --------------------------------------------------------

--
-- Table structure for table `INSTTEST`
--

CREATE TABLE IF NOT EXISTS `INSTTEST` (
  `TNAME` varchar(32) NOT NULL,
  `CODE` int(8) NOT NULL,
  `TESTID` int(8) NOT NULL,
  `ACTIVE` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `INSTTEST`
--

INSERT INTO `INSTTEST` (`TNAME`, `CODE`, `TESTID`, `ACTIVE`) VALUES
('Test 5', 0, 5, 'true'),
('Test 8', 0, 8, 'true'),
('Test 10', 0, 10, 'true'),
('Test 13', 0, 13, 'true');

-- --------------------------------------------------------

--
-- Table structure for table `QUESTIONBANK`
--

CREATE TABLE IF NOT EXISTS `QUESTIONBANK` (
  `INSTUSER` varchar(32) NOT NULL,
  `QUESTID` int(8) NOT NULL,
  `TYPE` varchar(32) NOT NULL,
  `DIFFICULTY` int(1) NOT NULL,
  `QUESTION` text NOT NULL,
  `ANSWER` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QUESTIONBANK`
--

INSERT INTO `QUESTIONBANK` (`INSTUSER`, `QUESTID`, `TYPE`, `DIFFICULTY`, `QUESTION`, `ANSWER`) VALUES
('instructor', 1, 'General', 2, 'Create a method multiply() which accepts two parameters, multiplies them, and returns the result.', 'public int multiply(int x, int y){int z = x*y; return z;}'),
('instructor', 2, 'General', 1, 'Create a method add() which accepts two parameters, adds them, and returns the result.', 'public int add(int x, int y){int z=x+y; return z;}'),
('instructor', 3, 'For Loop', 4, 'Create a method factorial() that uses a for loop to calculate the factorial of a number passed to the method. Return the result.', 'public int factorial(int x){ int y=1; for(int i =x; i>0;i--){ y*=i;} return y;}'),
('instructor', 4, 'If-Else If Statement', 3, 'Create a method calc() which accepts an operator and two numbers as parameters. Return the result of the two numbers when modified by the operator.', 'public int calc(String op, int x, int y){ if(op.equals("+")){return x+y;}else if(op.equals("*")){return x*y;}else if(op.equals("/")){return x/y;}else if(op.equals("-")){return x-y;}else{return 0;}}'),
('instructor', 5, 'While Loop', 5, 'Create a method series(), which calculates the series of an integer parameter using a while loop, then returns the result.', 'public int series(int x){ int z = 0; while(x >= 0){ z += x; x--; } return z; }'),
('instructor', 6, 'General', 1, 'Create a method subtract(), which accepts two integer parameters, subtracts them, then returns the result.', 'public int subtract(int x, int y){ int z = x - y; return x; }'),
('instructor', 7, 'Recursion', 5, 'Create a method series() which uses recursion to calculate the series of an integer parameter and returns the result.', 'int z = 0;\r\npublic int series(int x){\r\nz += x;\r\nx--;\r\nif(x == 0){\r\nreturn z;\r\n} else {\r\nreturn series(x);'),
('instructor', 8, 'For Loop', 4, 'Create a method series() which uses a for loop to calculate the series of an integer parameter and returns the result.', 'public int series(int x){\r\nint z = 0;\r\nfor(int i = x; i >0; i--){\r\nz += i;\r\n}\r\nreturn z;\r\n}'),
('instructor', 9, 'Do-While Loop', 4, 'creat a method factorial() which uses a do-while loop to calculate the factorial of an integer parameter then returns the result.', 'public int factorial(int x){\r\nint z = 1;\r\ndo{\r\nz *= x;\r\nx--;\r\n}while(x > 0);\r\nreturn z;\r\n}'),
('instructor', 10, 'General', 2, 'Create a method average() which calculates the average of two integer parameters and returns the result.', 'public int average(int x, int y){ int z = (x + y)/2; return z; }'),
('instructor', 11, 'If-Else Statement', 2, 'Create a method greaterThan() which returns true if the integer parameter is greater than 10 and returns false otherwise.', 'public boolean greaterThan(int x){ if(x > 10){ return true; } else { return false; }'),
('instructor', 12, 'If-Else Statement', 2, 'Create a method lessThan() which returns true if the integer parameter is less than 100 and returns false otherwise.', 'public boolean lessThan(int x){ if(x < 100){ return true; } else { return false; }'),
('instructor', 13, 'General', 1, 'Create a function addThree() which adds three integer parameters and returns the result.', 'public int addThree(int x, int y, int z){ int a = x + y + z; return a; }');

-- --------------------------------------------------------

--
-- Table structure for table `QUESTPARAMS`
--

CREATE TABLE IF NOT EXISTS `QUESTPARAMS` (
  `QUESTID` int(8) NOT NULL,
  `PARAM1` varchar(20) NOT NULL,
  `PARAM2` varchar(20) NOT NULL,
  `PARAM3` varchar(20) NOT NULL,
  `PARAM4` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QUESTPARAMS`
--

INSERT INTO `QUESTPARAMS` (`QUESTID`, `PARAM1`, `PARAM2`, `PARAM3`, `PARAM4`) VALUES
(1, '23', '15', '', ''),
(1, '4', '8', '', ''),
(1, '90', '27', '', ''),
(2, '90', '27', '', ''),
(2, '555', '341', '', ''),
(3, '61', '', '', ''),
(3, '19', '', '', ''),
(4, '-', '72', '21', ''),
(4, '', '72', '43', ''),
(5, '102', '', '', ''),
(5, '66', '', '', ''),
(5, '19', '', '', ''),
(5, '20', '', '', ''),
(6, '51', '40', '', ''),
(6, '67', '18', '', ''),
(7, '64', '', '', ''),
(7, '55', '', '', ''),
(7, '41', '', '', ''),
(8, '36', '', '', ''),
(8, '74', '', '', ''),
(8, '111', '', '', ''),
(9, '33', '', '', ''),
(9, '14', '', '', ''),
(10, '3', '2', '', ''),
(10, '25', '14', '', ''),
(10, '39', '12', '', ''),
(12, '47', '', '', ''),
(12, '198', '', '', ''),
(12, '98', '', '', ''),
(11, '20', '', '', ''),
(11, '2', '', '', ''),
(12, '223', '', '', ''),
(12, '23', '', '', ''),
(13, '1', '2', '3', ''),
(13, '3', '4', '5', ''),
(13, '23', '34', '45', '');

-- --------------------------------------------------------

--
-- Table structure for table `QUEST_TEST`
--

CREATE TABLE IF NOT EXISTS `QUEST_TEST` (
  `QUESTID` int(8) NOT NULL,
  `TESTID` int(8) NOT NULL,
  `AMOUNT` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QUEST_TEST`
--

INSERT INTO `QUEST_TEST` (`QUESTID`, `TESTID`, `AMOUNT`) VALUES
(5, 5, 20),
(10, 5, 10),
(11, 5, 15),
(1, 5, 10),
(3, 5, 30),
(4, 5, 25),
(1, 8, 30),
(11, 8, 30),
(1, 10, 10),
(2, 10, 10),
(1, 13, 20),
(2, 13, 20),
(3, 13, 40),
(4, 13, 20);

-- --------------------------------------------------------

--
-- Table structure for table `STUDANSWERS`
--

CREATE TABLE IF NOT EXISTS `STUDANSWERS` (
  `STUDUSER` varchar(16) NOT NULL,
  `TESTID` int(8) NOT NULL,
  `QUESTID` int(8) NOT NULL,
  `ANSWERS` text NOT NULL,
  `SCORE` varchar(16) NOT NULL,
  `COMMENTS` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `STUDANSWERS`
--

INSERT INTO `STUDANSWERS` (`STUDUSER`, `TESTID`, `QUESTID`, `ANSWERS`, `SCORE`, `COMMENTS`) VALUES
('student', 8, 1, 'public int mult(int x, int y){\r\nint z = x * y;\r\nreturn z;', '15', '(1) Incorrect method name. Expected method name: multiply. (2) Syntax errors made in method body.'),
('student', 8, 11, 'public boolean greaterThan(int x){\r\nif(x > 10){\r\nreturn true;\r\n} else{\r\nreturn false;\r\n}\r\n}', '20', '(1) Output does not match correct output after attempting to correct.'),
('student', 8, 14, 'public int calc(String op, int x, int y){\r\nif (op.equals("+")){\r\nreturn x+y;\r\n} else if (op.equals("-")){\r\nreturn x - y;\r\n} else {\r\nreturn 0;\r\n}\r\n}', '15.63', '(1) Syntax errors made in method body.'),
('student', 10, 1, 'public int multiply(int x, int y){int z = x*y; return z;}', '50.0', '(0) Does Not Compile. (1) Outputs match.'),
('student', 10, 2, 'public int add(int x, int y){int z = x+y; return z;}', '90.0', '(0) Does Not Compile. (1) Outputs match.'),
('student', 13, 1, 'public int multiply(int x, int y){int z = x*y; return z;}', '100.0', '(0) Does Not Compile. (1) Outputs match.'),
('student', 13, 2, 'public int add(int x, int y){int z=x+y; return z;}', '100.0', '(0) Does Not Compile. (1) Outputs match.'),
('student', 13, 3, 'public int factorial(int x){ int y=1; for(int i =x; i>0;i--){ y*=i;} return y;}', '50.0', '(0) Does Not Compile. (1) Outputs match.'),
('student', 13, 4, 'public int calc(String op, int x, int y){ if(op.equals("+")){return x+y;}else if(op.equals("*")){return x*y;}else \r\n{return 0;}}', '48.14', '(0) Does Not Compile. (1) Outputs match.');

-- --------------------------------------------------------

--
-- Table structure for table `STUDENTS`
--

CREATE TABLE IF NOT EXISTS `STUDENTS` (
  `STUDUSER` varchar(32) NOT NULL,
  `PASSWORD` varchar(32) NOT NULL,
  `CODE` int(8) NOT NULL,
  `FNAME` varchar(32) NOT NULL,
  `LNAME` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `STUDENTS`
--

INSERT INTO `STUDENTS` (`STUDUSER`, `PASSWORD`, `CODE`, `FNAME`, `LNAME`) VALUES
('student', 'student', 0, 'John', 'Smith');

-- --------------------------------------------------------

--
-- Table structure for table `STUDTEST`
--

CREATE TABLE IF NOT EXISTS `STUDTEST` (
  `STUDUSER` varchar(32) NOT NULL,
  `TESTID` int(8) NOT NULL,
  `SCORE` varchar(16) NOT NULL,
  `COMMENT` text NOT NULL,
  `ACTIVE` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `STUDTEST`
--

INSERT INTO `STUDTEST` (`STUDUSER`, `TESTID`, `SCORE`, `COMMENT`, `ACTIVE`) VALUES
('student', 8, '50.63', 'Good job.', 'false'),
('student', 10, '70', 'gl', 'false'),
('student', 13, '74.535', 'good job', 'false');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Instructor`
--
ALTER TABLE `Instructor`
 ADD PRIMARY KEY (`INSTUSER`), ADD UNIQUE KEY `CODE_2` (`CODE`), ADD KEY `CODE` (`CODE`);

--
-- Indexes for table `INSTTEST`
--
ALTER TABLE `INSTTEST`
 ADD PRIMARY KEY (`TESTID`), ADD KEY `C` (`CODE`);

--
-- Indexes for table `QUESTIONBANK`
--
ALTER TABLE `QUESTIONBANK`
 ADD PRIMARY KEY (`QUESTID`), ADD KEY `INSTUSER` (`INSTUSER`);

--
-- Indexes for table `QUESTPARAMS`
--
ALTER TABLE `QUESTPARAMS`
 ADD KEY `QUESTID` (`QUESTID`);

--
-- Indexes for table `QUEST_TEST`
--
ALTER TABLE `QUEST_TEST`
 ADD KEY `TESTID` (`TESTID`), ADD KEY `QUESTID` (`QUESTID`);

--
-- Indexes for table `STUDANSWERS`
--
ALTER TABLE `STUDANSWERS`
 ADD KEY `STUDUSER` (`STUDUSER`);

--
-- Indexes for table `STUDENTS`
--
ALTER TABLE `STUDENTS`
 ADD PRIMARY KEY (`STUDUSER`), ADD KEY `CODE` (`CODE`);

--
-- Indexes for table `STUDTEST`
--
ALTER TABLE `STUDTEST`
 ADD KEY `TESTID` (`TESTID`), ADD KEY `STUDUSER` (`STUDUSER`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `QUESTIONBANK`
--
ALTER TABLE `QUESTIONBANK`
ADD CONSTRAINT `instuser` FOREIGN KEY (`INSTUSER`) REFERENCES `Instructor` (`INSTUSER`);

--
-- Constraints for table `QUESTPARAMS`
--
ALTER TABLE `QUESTPARAMS`
ADD CONSTRAINT `PARAMID` FOREIGN KEY (`QUESTID`) REFERENCES `QUESTIONBANK` (`QUESTID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `QUEST_TEST`
--
ALTER TABLE `QUEST_TEST`
ADD CONSTRAINT `questid` FOREIGN KEY (`QUESTID`) REFERENCES `QUESTIONBANK` (`QUESTID`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `test_id` FOREIGN KEY (`TESTID`) REFERENCES `INSTTEST` (`TESTID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `STUDANSWERS`
--
ALTER TABLE `STUDANSWERS`
ADD CONSTRAINT `user_stud` FOREIGN KEY (`STUDUSER`) REFERENCES `STUDENTS` (`STUDUSER`);

--
-- Constraints for table `STUDENTS`
--
ALTER TABLE `STUDENTS`
ADD CONSTRAINT `studcode` FOREIGN KEY (`CODE`) REFERENCES `Instructor` (`CODE`);

--
-- Constraints for table `STUDTEST`
--
ALTER TABLE `STUDTEST`
ADD CONSTRAINT `testid` FOREIGN KEY (`TESTID`) REFERENCES `INSTTEST` (`TESTID`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `studuser` FOREIGN KEY (`STUDUSER`) REFERENCES `STUDENTS` (`STUDUSER`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
