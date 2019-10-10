// This is a closure function https://medium.com/javascript-scene/master-the-javascript-interview-what-is-a-closure-b2f0d2152b36
(function() {
  var initialize = function() {
    /*
      1. Add all your event bindings here. Please avoid binding events inline and add your event listeners here.

      onSubmit callback
      disableDuplicateSecondaryDepartment callback,...
    */
    document.getElementsByName("department1")[0].addEventListener("change",()=>{disableDuplicateSecondaryDepartment();});
    document.getElementsByClassName("button")[0].addEventListener("click",()=>{onSubmit(event);});
  };

  var disableDuplicateSecondaryDepartment = function(event) {
    // 2. in department2, Should disable the option selected in department1
    let department2 = document.getElementsByName("department2")[0];
    let department1 = document.getElementsByName("department1")[0];
    let selectedValue = department1.value;
    let disable=department2.getElementsByTagName("OPTION");
    for(let i=0;i<disable.length;i++){
      if(disable[i].value==selectedValue){
        disable[i].disabled=true;
      }
      else{
        disable[i].disabled=false;
      }
    }
    //console.log(selectedValue);
  }

  var constructData = function() {
    var data = {};

    // 3. Construct data from the form here. Please ensure that the keys are the names of input elements
    data["name"]=String(document.getElementsByName("name")[0].value);
    data["phno"]=String(document.getElementsByName("phno")[0].value);
    data["emailaddress"]=String(document.getElementsByName("emailaddress")[0].value);
    data["department1"]=String(document.getElementsByName("department1")[0].value);
    data["department2"]=String(document.getElementsByName("department2")[0].value);
    return data;
  }

  var validateResults = function(data) {
    var isValid = true;
    // 4. Check if the data passes all the validations here
    if(data["name"].length>100){
        isValid=false;
    }
    let patt = new RegExp("^[a-zA-Z0-9\.]+@college\.edu$");
    let res = patt.exec(String(data["emailaddress"]));
    if(res==null){
        isValid=false;
    }
    if(data["phno"].length>10){
      isValid=false;
    }
    if(data["department1"]===data["department2"]){
      isValid=false;
    }
    return isValid;
  };

  var onSubmit = function(event) {
    // 5. Figure out how to avoid the redirection on form submit
    event.preventDefault();
    var data = constructData();

    if (validateResults(data)) {
      printResults(data);
    } else {
      var resultsDiv = document.getElementById("results");
      resultsDiv.innerHTML = '';
      resultsDiv.classList.add("hide");
    }
    return false;
  };

  var printResults = function(data) {
    var constructElement = function([key, value]) {
      return `<p class='result-item'>${key}: ${value}</p>`;
    };

    var resultHtml = (Object.entries(data) || []).reduce(function(innerHtml, keyValuePair) {
      debugger
      return innerHtml + constructElement(keyValuePair);
    }, '');
    var resultsDiv = document.getElementById("results");
    resultsDiv.innerHTML = resultHtml;
    resultsDiv.classList.remove("hide");
  };

  /*
    Initialize the javascript functions only after the html DOM content has loaded.
    This is to ensure that the elements are present in the DOM before binding any event listeners to them.
  */
  document.addEventListener('DOMContentLoaded', initialize);
})();
