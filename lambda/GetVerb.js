const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

AWS.config.update({
  region: "eu-west-2"
});

exports.handler = function(event, context, callback) {
    let verb = '';
    if (event.verb) {
      verb = event.verb;
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

      callback(null, data.Item);
    });
  }