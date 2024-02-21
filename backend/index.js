const express = require('express');
const app = express();
const port = 8000;

const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'livechat'
});

/************ Middleware to parse JSON bodies ************/
app.use(express.json());

/************ Function to replace underscores with spaces ************/
function underscore_to_space(string){
  return string.replace(/_/g, " ");
}

/************ Route to retrieve all chat messages ************/
app.post('/', (req, res) => {
    // SQL query to select all messages from the database and order them by idMsg
    var query = "SELECT * FROM chat ORDER BY idMsg";
    
    // Executing the SQL query
    connection.query(query, (err, result) => {
        if(err) throw err;
        else{
            res.json(result);
        }
    });
});

/************ Route to send a chat message ************/
app.post('/enviar', (req, res) => {
    // Extracting the message content from the request body
    var message = req.body;

    var nome = message.nome;
    var msg = message.content;
  
    // SQL query to insert the message into the database
    var query = "INSERT INTO chat (idMsg, nome, content) VALUES (NULL, ?, ?)";
  
    // Executing the SQL query with parameters
    connection.query(query, [nome, msg], (err, result) => {
      if (err) {
        console.error("Error inserting message:", err);
        res.status(500).json({ error: "Failed to insert message" });
      } else {
        console.log("Message inserted successfully:", result);
        res.status(200).json({ success: true });
      }
    });
});

/************ Route to delete all chat messages ************/
app.post('/apagar', (req, res) => {
  // SQL query to delete all messages from the database
  var query = "DELETE FROM chat";
  
  // Executing the SQL query
  connection.query(query, (err, result) => {
    if(err) throw err;
    else{
      res.send(result);
    }
  });
});

/************ Start the server ************/
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});
