
const mongoose = require('mongoose');
const connect_to_db = require('./db');
const crypto = require('crypto');

// GET BY TALK HANDLER

const talk = require('./Talk');

module.exports.insert_comment = (event, context, callback) => {
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
                    body: 'Could not fetch the talks. video_id is null.'
        })
    }
    // set default
    if(!body.user_id) {
        callback(null, {
                    statusCode: 500,
                    headers: { 'Content-Type': 'text/plain' },
                    body: 'Could not fetch the talks. user_id is null.'
        })
    }
    if(!body.timestamp) {
        callback(null, {
                    statusCode: 500,
                    headers: { 'Content-Type': 'text/plain' },
                    body: 'Could not fetch the talks. timestamp is null.'
        })
    }
    if(!body.title) {
        callback(null, {
                    statusCode: 500,
                    headers: { 'Content-Type': 'text/plain' },
                    body: 'Could not fetch the talks. title is null.'
        })
    }
    if(!body.body) {
        callback(null, {
                    statusCode: 500,
                    headers: { 'Content-Type': 'text/plain' },
                    body: 'Could not fetch the talks. body is null.'
        })
    }
    
    if(!body.type) {
        callback(null, {
                    statusCode: 500,
                    headers: { 'Content-Type': 'text/plain' },
                    body: 'Could not fetch the talks. type is null.'
        });
    }
    
    
    connect_to_db().then(() => {
        talk.findOne({ _id: body.video_id }).then((result) => {
            let comment = {
                comment_id: crypto.randomUUID(),
                user_id: body.user_id,
                timestamp: body.timestamp,
                title: body.title,
                body: body.body,
                upvote:0
            };
            
            
    
            if (body.type === "info") {
                result.comments.info.push(comment);
            } else if (body.type === "disc") {
                result.comments.disc.push(comment);
            } else if (body.type === "extra") {
                result.comments.extra.push(comment);
            }
    
            return result.save();
        })
        .then((savedResult) => {
            console.log(savedResult);
            callback(null, {
                statusCode: 200,
                body: JSON.stringify({ message: "success" })
            });
        })
        .catch((error) => {
            console.error('Errore nel salvataggio del documento aggiornato:', error);
            callback(null, {
                statusCode: 400,
                body: JSON.stringify({ message: "could not insert the comment" })
            });
        });
        
    });
};