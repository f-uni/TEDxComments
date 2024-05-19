
const mongoose = require('mongoose');
const connect_to_db = require('./db');

// GET BY TALK HANDLER
const talk = require('./Talk');

module.exports.watch_next = (event, context, callback) => {
    context.callbackWaitsForEmptyEventLoop = false;
    console.log('Received event:', JSON.stringify(event, null, 2));
    let body = {}
    console.log(event.body)
    if (event.body) {
        body = JSON.parse(event.body)
    }
    if(!body.video_id) {
        callback(null, {
            statusCode: 500,
            headers: { 'Content-Type': 'text/plain' },
            body: 'Could not fetch the talk. video_id is null.'
        })
    }
    
    
    connect_to_db().then(() => {
        talk.findOne({ _id: body.video_id }).then((result) => {
            callback(null, {
                statusCode: 200,
                body: JSON.stringify({ result: result })
            });
        }).catch((error) => {
            console.error('Errore nel lettura del documento aggiornato:', error);
            callback(null, {
                statusCode: 400,
                body: JSON.stringify({ message: "could not get the talk" })
            });
        });
        
    });
};