<?php
if (isset($_POST['submit'])){

	require "../config.php";

	try
  {
		$connection = new PDO($dsn, $username, $password, $options);

		$user_det = array(
			"uname"  => $_POST['uname'],
			"upass"  => $_POST['upass']
		);

    $sql = "SELECT * FROM admin WHERE uname = :uname AND upass = :upass";

		$statement_ = $connection->prepare($sql);
    $statement_->bindParam(':uname', $user_det['uname'], PDO::PARAM_STR);
    $statement_->bindParam(':upass', $user_det['upass'], PDO::PARAM_STR);
		$statement_->execute();

    if ($statement_->rowCount() > 0) {
      $sql = sprintf(
        "SELECT * FROM %s",
        "registerations"
      );

    $statement = $connection->prepare($sql);
		$statement->execute();

		$result = $statement->fetchAll();
    }
	}

	catch(PDOException $error)
	{
		echo $sql . "<br>" . $error->getMessage();
	}

}
?>



<?php include "templates/header.php"; ?>

<?php
if (isset($_POST['submit']))
{
	if ($result && $statement_->rowCount() > 0 && $statement->rowCount() > 0)
	{ ?>
		<h2>Results</h2>

		<table>
			<thead>
				<tr>
					<th>Name</th>
					<th>Address</th>
					<th>Email</th>
					<th>Mobile Number</th>
					<th>Bank Number</th>
				</tr>
			</thead>
			<tbody>
	<?php
		foreach ($result as $row)
		{ ?>
			<tr>
				<td><?php echo $row["name"]; ?></td>
				<td><?php echo $row["address"]; ?></td>
				<td><?php echo $row["email"]; ?></td>
				<td><?php echo $row["mnumber"]; ?></td>
				<td><?php echo $row["bnumber"]; ?></td>
			</tr>
		<?php
		} ?>
		</tbody>
	</table>
  <?php
  }
  elseif ($statement_->rowCount() == 0 ) { ?>
    <blockquote>Not authorized to see all the details</blockquote>
    <?php
  } else { ?>
    <blockquote>No results found in the registerations table.</blockquote>
    <?php
  }
}?>

<form name="details" method="post">
  <fieldset>
    <legend>Admin Login</legend>
    Username:<br>
    <input type="text" name="uname" placeholder="admin"><br>
    Password:<br>
    <input type="password" name="upass"><br>
    <input type="submit" name="submit">
  </fieldset>
</form>

<?php include "templates/footer.php"; ?>
