const mongoose = require('mongoose');

const talk_schema = new mongoose.Schema({
    _id: String,
    title: String,
    url: String,
    description: String,
    speakers: String,
    comments: {
        info: [{
            comment_id:String,
            upvote: Number
        }],
        disc: [{
            comment_id:String,
            upvote: Number
        }],
        extra: [{
            comment_id:String,
            upvote: Number
        }]
    }
}, { collection: 'tedx_data' });

module.exports = mongoose.model('talk', talk_schema);