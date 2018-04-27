function validateForm() {
  var data = document.forms['details'];
  var name = data['name'].value;
  var address = data['address'].value;
  var email = data['email'].value;
  var mnumber = data['mnumber'].value;
  var bnumber = data['bnumber'].value;
  var bpass = data['bpass'].value;
  var english = /^[A-Za-z ]+$/;
  var number = /^[0-9]{10}$/;
  var numberb = /^[0-9]{5}$/;
  var mail = /^[a-zA-Z]+@[a-zA-Z]+\.com$/;
  if (name.length > 20 || name.length == 20 || !english.test(name)) {
    alert("name : Maximum 20 characters with only english alphabets and space");
    return false;
  } else if (address.length > 100 || address.length == 100){
    alert("address: Maximum 100 characters")
    return false;
  } else if (!mail.test(email)) {
    alert("leftside may contain english alphabets only and rightside must end with a .com domain name")
    return false;
  } else if (!number.test(mnumber) || mnumber[0]=="0") {
    alert("Mobile number is a 10-digit numeric value")
    return false;
  } else if (!numberb.test(bnumber)) {
    alert("Bank account number is a 5-digit numeric value")
    return false;
  } else if(bpass.length > 20 || bpass.length == 20) {
    alert("Bank password can be maximum 20 alphanumeric characters ")
    return false;
  }
return true;
}
