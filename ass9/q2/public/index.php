<?php include 'templates/header.php'; ?>
<script src="test.js"></script>
<form name="details" method="post" action="registeration.php" onsubmit="return validateForm()">
  <fieldset>
    <legend>Personal information:</legend>
    Name:<br>
    <input type="text" name="name" placeholder="Hritvik Taneja"><br>
    Address<br>
    <textarea name="address" placeholder="IIT Kanpur"></textarea><br>
    Email:<br>
    <input type="email" name="email" placeholder="someone@example.com"><br>
    Mobile Number:<br>
    <input type="text" name="mnumber" placeholder="1234567890"><br>
    Bank Number:<br>
    <input type="text" name="bnumber" placeholder="12345"><br>
    Bank Password:<br>
    <input type="password" name="bpass"><br>
    <input type="submit" value="Submit">
  </fieldset>
</form>
<div style="position:fixed; bottom:0; left:0;"><a href="admin.php">See All Registerations</a></div>
</body>
</html>
