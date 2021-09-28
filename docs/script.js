var mymap = L.map('mapid').setView([53.905234, 27.545696], 13);

L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
    maxZoom: 18,
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, ' +
        'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1
}).addTo(mymap);

var popups = []
fetch("https://da7f50c3-7a27-497c-80bb-4a9652cdc548.mock.pstmn.io/atm?currency=USD")
    .then(response => response.json())
    .then(function (result) {
        for (let i = 0; i < result.length; i++) {
            fetch("https://da7f50c3-7a27-497c-80bb-4a9652cdc548.mock.pstmn.io/commission?issuerBankId=1&atmBankId=" + result[i].id)
                .then(res => res.json())
                .then(commission => {
                    L.marker([result[i].location.lat, result[i].location.lon]).addTo(mymap)
                        .bindPopup("<b>" + result[i].name + "</b><br />" +
                            "<b>Is active: </b>" + result[i].active + "</br>" +
                            "<b>Hours of work: </b>" + result[i].hoursOfWork + "</br>" +
                            "<b>Total percent: </b>" + commission.totalPercent + "</br>" +
                            "<b>Issuer percent: </b>" + commission.issuerPercent +  "</br>" +
                            "<b>Issuer commission fixed amount: </b>" + commission.issuerCommissionFixedAmount + "</br>" +
                            "<b>Acquirer percent: </b>" +  commission.issuerCommissionFixedAmount + "</br>" +
                            "<b>Acquirer Commission Fixed Amount: </b>" + commission.acquirerCommissionFixedAmount + "</br>" +
                            "<b>Issuer Min Commission Amount: </b>" + commission.issuerMinCommissionAmount + "</br>" +
                            "<b>Acquirer Min Commission Amount: </b>" + commission.acquirerMinCommissionAmount + "</br>" +
                            "<b>Currency: </b>" + commission.currency
                        ).openPopup();
                    popups.push(result[i])
                })
                .catch(error => console.log('error', error));
        }
    })
    .catch(error => console.log('error', error));


var popup = L.popup();

function onMapClick(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(mymap);
}

mymap.on('click', onMapClick);