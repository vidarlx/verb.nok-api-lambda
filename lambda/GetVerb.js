const AWS = require('aws-sdk');

const TABLE_NAME = "NorskVerb";

AWS.config.update({
  region: "eu-west-2"
});

exports.handler = function (event, context, callback) {
  const ddb = new AWS.DynamoDB.DocumentClient();
  
  let verb = getVerb(event);

  if (!verb) {
    callback("Not found");
  }

  ddb.get(prepareQuery(verb), (err, data) => {
    if (err) {
      return callback(err.message);
    }

    const response = {
      "statusCode": 200,
      "headers": {
        'Access-Control-Allow-Origin' : 'https://verbs.nok.blue'
      },
      "body": JSON.stringify(data.Item),
      "isBase64Encoded": false
    };
    callback(null, response);
  });
}

function prepareQuery(verb) {
  return {
    TableName: TABLE_NAME,
    Key: {
      norsk_verb: verb
    }
  };
}

function getVerb(event) {
  const body = JSON.parse(event.body);
  let verb = null;
  if (body.verb) {
    verb = body.verb;
  }
  return verb;
}