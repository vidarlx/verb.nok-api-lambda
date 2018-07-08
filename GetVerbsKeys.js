const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

AWS.config.update({
  region: "eu-west-2"
});

exports.handler = function(event, context, callback) {

    var params = {
        TableName: "NorskVerb",
        ProjectionExpression: "norsk_verb, polsk_verb"
    };
    
    ddb.scan(params, onVerbsFound);
    
    callback(null, "200!");
}

function onVerbsFound(err, data) {
    if (err) {
       return callback(err);
    }
    
    callback(null, data);
}
