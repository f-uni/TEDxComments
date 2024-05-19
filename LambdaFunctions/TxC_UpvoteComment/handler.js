
const mongoose = require('mongoose');
const connect_to_db = require('./db');

// GET BY TALK HANDLER

const talk = require('./Talk');

module.exports.upvote_comment = (event, context, callback) => {
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
    
    if(!body.comment_id) {
        callback(null, {
                    statusCode: 500,
                    headers: { 'Content-Type': 'text/plain' },
                    body: 'Could not fetch the talks. comment_id is null.'
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
        talk.findOne({ _id: body.video_id }).then((result) => { //trova il video a cui il commento appartiene
            
            let comment = null; //variabile per salvare l'elemento che contiene il riferimento al commento
            
            if (body.type === "info") { //sceglie in quale categoria di commenti da cercare
                comment = result.comments.info.find((element)=>{return element.comment_id == body.comment_id});
            } else if (body.type === "disc") {
                comment = result.comments.disc.find((element)=>{return element.comment_id == body.comment_id});
            } else if (body.type === "extra") {
                comment = result.comments.extra.find((element)=>{return element.comment_id == body.comment_id});
            }
            
            comment.upvote++; //aggiorna il numero di upvote
            return result.save(); //salva il risultato nel database
        })
        .then((savedResult) => {
            
            callback(null, {
                statusCode: 200,
                body: JSON.stringify({ message: "success" })
            });
        })
        .catch((error) => {
            console.error('Errore nel salvataggio del documento aggiornato:', error);
            callback(null, {
                statusCode: 400,
                body: JSON.stringify({ message: "could not upvote the comment" })
            });
        });
        
    });
};