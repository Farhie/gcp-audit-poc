const Spanner = require('@google-cloud/spanner');

const projectId = 'audit-poc';
const instanceId = 'audit-poc-instance';
const databaseId = 'audit-poc-state-machine-table';

exports.writeToSpanner = (event, callback) => {

    const pseudoRandomId = Math.floor(Math.random() * 123456).toString();
    const pubSubMessage = event.data;
    const body = Buffer.from(pubSubMessage.data, 'base64').toString()
    const spanner = new Spanner({ projectId: projectId,});
    const instance = spanner.instance(instanceId);
    const database = instance.database(databaseId);
    const eventsTable = database.table('Events');

    console.log('Inserting event body: ' + body)

    eventsTable
      .insert([
        {Id: pseudoRandomId, Event: body},
      ]).then(() => {
        console.log('Inserted data.');
      })
      .catch(err => {
        console.error('ERROR:', err);
      })
      .then(() => {
        callback();
        return database.close();
      });
};