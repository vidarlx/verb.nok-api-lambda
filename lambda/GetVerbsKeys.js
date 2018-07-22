const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

AWS.config.update({
  region: "eu-west-2"
});

exports.handler = function (event, context, callback) {

  var params = {
    TableName: "NorskVerb",
    ProjectionExpression: "norsk_verb, polsk_verb"
  };

  ddb.scan(params, (err, data) => {
    if (err) {
      return callback(err);
    }

    var response = {
      "statusCode": 200,
      "headers": {
      },
      "body": JSON.stringify( data.Items),
      "isBase64Encoded": false
    };
    callback(null, response);
  });
}