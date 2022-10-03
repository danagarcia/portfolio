const express = require('express');
const path = require('path');
const nodemailer = require('nodemailer');
const dotenv = require('dotenv');
const computerName = require('computer-name');
dotenv.config();
let initialPath = path.join(__dirname, "public");
let app = express();
app.use(express.static(initialPath));
app.use(express.json());
app.get('/', (req, res) => {
    res.sendFile(path.join(initialPath, "index.html"));
})
app.get('/device_name', (req, res) => {
    res.send({ device_name: computerName() });
});
app.listen(80, () => {
    console.log('listening on port:80...');
})
app.post('/mail', (req, res) => {
    const { firstname, lastname, email, msg } = req.body;

    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: process.env.EMAIL,
            pass: process.env.PASSWORD
        }
    })

    const mailOptions = {
        from: 'sender email',
        to: 'receiver email',
        subject: 'Postfolio',
        text: `First name: ${firstname}, \nLast name: ${lastname}, \nEmail: ${email}, \nMessage: ${msg}`
    }

    transporter.sendMail(mailOptions, (err, result) => {
        if (err){
            console.log(err);
            res.json('opps! it seems like some error occured plz. try again.')
        } else{
            res.json('thanks for e-mailing me. I will reply to you within 2 working days');
        }
    })
})