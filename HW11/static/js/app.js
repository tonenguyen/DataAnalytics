// from data.js
var UFOsightings = data;

// Select the submit button
var submit = d3.select("#submit");

submit.on("click", function() {

    // Prevent the page from refreshing
    d3.event.preventDefault();
  
    // Select the input element and get the raw HTML node
    var inputElement = d3.select("#datetime");
  
    // Get the value property of the input element
    var inputValue = inputElement.property("value");
	
	d3.select("#datetime").node().value = "";
    console.log("Hello")
    //console.log(inputElement);  
    console.log(inputValue);
    
    //console.log(people);
    var filteredData = UFOsightings.filter(sighting => sighting.datetime === inputValue);
    console.log(filteredData)
    console.log()
    console.log("Got something")
    buildTable(filteredData)

})
// YOUR CODE HERE!
/*
  datetime: "1/1/2010",
    city: "bonita",
    state: "ca",
    country: "us",
    shape: "light",
    durationMinutes: "13 minutes",
    comments

                  <th class="table-head">Date</th>
                  <th class="table-head">City</th>
                  <th class="table-head">State</th>
                  <th class="table-head">Country</th>
                  <th class="table-head">Shape</th>
                  <th class="table-head">Duration</th>
                  <th class="table-head">Comments</th>
*/
function buildTable(filterData) {
    var data = filterData
    var table = d3.select("#ufo-table");
    // remove elements
    d3.select("tbody").selectAll("tr").remove();
    var tbody = table.select("tbody");
    var trow;
    var len = Object.keys(data).length;
    for (var i = 0; i < len; i++) {
        trow = tbody.append("tr");
        trow.append("td").text(data[i].datetime);
        trow.append("td").text(data[i].city);
        trow.append("td").text(data[i].state);
        trow.append("td").text(data[i].country);
        trow.append("td").text(data[i].shape);
        trow.append("td").text(data[i].durationMinutes);
        trow.append("td").text(data[i].comments);
    }
}
