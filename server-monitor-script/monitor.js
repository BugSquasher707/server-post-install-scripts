const nodemailer = require("nodemailer");
const tcpp = require("tcp-ping");
const dotenv = require("dotenv");
dotenv.config();

const serverHost = process.env.SERVER_HOST;
const serverPort = process.env.SERVER_PORT;

const gmail = {
  server: "gmail",
  host: "smtp.gmail.com",
  port: 587,
  email: process.env.GMAIL_EMAIL,
  password: process.env.GMAIL_PASSWORD,
};

const transporter = nodemailer.createTransport({
  service: gmail.server,
  host: gmail.host,
  port: gmail.port,
  secure: false,
  auth: {
    user: gmail.email,
    pass: gmail.password,
  },
});

const sendEmail = (error) => {
  const mailOptions = {
    from: `"${process.env.EMAIL_HOST_NAME}" <${gmail.email}>`,
    to: ["arslanarjumand012@gmail.com", "thaheem001@gmail.com"],
    subject: "Server Down Alert",
    text: `Your ${process.env.SERVER_NAME} server is down. Error: ${error}`,
  };

  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log("Email sent: " + info.response);
    }
  });
};

const checkServer = () => {
  tcpp.ping(
    { address: serverHost, port: serverPort, attempts: 5 },
    function (err, data) {
      if (err || !data.avg) {
        console.log(
          `Error pinging server: ${
            err ? err.message : "No average response time"
          }`
        );
        sendEmail(err ? err.message : "No average response time available.");
      } else {
        console.log(`Server is up. Response time: ${data.avg}ms`);
      }
    }
  );
};

checkServer();
