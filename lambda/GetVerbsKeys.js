const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

AWS.config.update({
  region: "eu-west-2"
});

exports.handler = function (event, context, callback) {
  ddb.scan(createDbQuery(), (err, data) => {
    if (err) {
      return callback(err);
    }

    callback(null, createResponse(data.Items));
  });
}

function createDbQuery() {
  return {
    TableName: "NorskVerb",
    ProjectionExpression: "norsk_verb, polsk_verb"
  };
}

function createResponse(data) {
  return {
    "statusCode": 200,
    "headers": {
    },
    "body": JSON.stringify(data),
    "isBase64Encoded": false
  }
}