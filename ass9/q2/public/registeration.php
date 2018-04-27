<?php include 'templates/header.php'; ?>
<?php
  include '../config.php';

  $connection = new PDO($dsn, $username, $password, $options);

  $new_user = array(
    "name"    => $_POST['name'],
    "address" => $_POST['address'],
    "email"   => $_POST['email'],
    "mnumber" => $_POST['mnumber'],
    "bnumber" => $_POST['bnumber'],
    "bpass"   => $_POST['bpass']
  );

  $sql = "SELECT *
				  FROM registerations
				  WHERE email = :email";

  $statement_ = $connection->prepare($sql);
  $statement_->bindParam(':email', $new_user['email'], PDO::PARAM_STR);
  $statement_->execute();

  if ($statement_->rowCount() > 0) {
    echo "<h2>Already registered</h2>";
  } else {
    $sql = "SELECT balance
            FROM bankac
            WHERE bnumber = :bnumber
            AND bpass = :bpass";

    $statement_ = $connection->prepare($sql);
    $statement_->bindParam(':bnumber', $new_user['bnumber'], PDO::PARAM_STR);
    $statement_->bindParam(':bpass', $new_user['bpass'], PDO::PARAM_STR);
    $statement_->execute();
    $result = $statement_->fetchAll();

    if ($statement_->rowCount()==0) {
          echo "<h2>Invalid Account/Password</h2>";
    } else {
      if ($result[0]["balance"]<1000) {
          echo "<h2>Insufficient Balance</h2>";
      } else {

        $sql = "UPDATE bankac
                SET balance = :balance - 1000
                WHERE bnumber = :bnumber
                AND bpass = :bpass";

        $statement_ = $connection->prepare($sql);
        $statement_->bindParam(':bnumber', $new_user['bnumber'], PDO::PARAM_STR);
        $statement_->bindParam(':balance', $result[0]["balance"], PDO::PARAM_STR);
        $statement_->bindParam(':bpass', $new_user['bpass'], PDO::PARAM_STR);
        $statement_->execute();

        $sql = sprintf(
              "INSERT INTO %s (%s) values (%s)",
              "registerations",
              implode(", ", array_keys($new_user)),
              ":" . implode(", :", array_keys($new_user))
            );

        $statement = $connection->prepare($sql);
        $statement->execute($new_user);
        echo "<h2>Registration Successful</h2>";
    }
  }
}

 ?>
<?php include 'templates/footer.php'; ?>
