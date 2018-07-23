const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

AWS.config.update({
  region: "eu-west-2"
});

exports.handler = function (event, context, callback) {
  let verb = '';
  let response = null;
  
  const body = JSON.parse(event.body)
  if (body.verb) {
    verb = body.verb;
  }

  if (!verb) {
    response = {
      "statusCode": 404,
      "message": "Not found"
    };
    callback(response);
  }

  var params = {
    TableName: "NorskVerb",
    Key: {
      norsk_verb: verb
    }
  };

  ddb.get(params, (err, data) => {
    if (err) {
      return callback(err);
    }

    response = {
      "statusCode": 200,
      "headers": {
      },
      "body": JSON.stringify(data.Item),
      "isBase64Encoded": false
    };
    callback(null, response);
  });
}